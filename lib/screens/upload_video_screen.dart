import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'videolistscreen.dart'; // <-- import the list screen here

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  PlatformFile? _pickedVideo;
  PlatformFile? _pickedThumbnail; // ✅ NEW: For thumbnail
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool _isUploading = false;
  String? _error;
  String? _uploadedVideoUrl;
  String? _uploadedThumbnailUrl; // ✅ NEW: Uploaded thumbnail URL
  String? _selectedCategory; // ✅ NEW: Selected category

  final String cloudName = 'daz13wucu'; // your Cloudinary cloud name
  final String uploadPreset = 'skillhub_videos'; // your unsigned preset

  final List<String> _categories = [
    'Education',
    'Entertainment',
    'Technology',
    'Lifestyle',
    'Sports'
  ];

  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedVideo = result.files.first;
      });
    }
  }

  Future<void> _pickThumbnail() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedThumbnail = result.files.first;
      });
    }
  }

  Future<String?> _uploadToCloudinary(PlatformFile file, String resourceType) async {
    try {
      final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/$resourceType/upload');
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = uploadPreset;

      if (kIsWeb) {
        Uint8List fileBytes = file.bytes!;
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          fileBytes,
          filename: file.name,
        ));
      } else {
        request.files.add(await http.MultipartFile.fromPath(
          'file',
          file.path!,
        ));
      }

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final data = json.decode(responseString);
        return data['secure_url'];
      } else {
        final responseString = await response.stream.bytesToString();
        setState(() {
          _error = 'Upload failed: $responseString';
        });
        return null;
      }
    } catch (e) {
      setState(() {
        _error = 'Upload error: $e';
      });
      return null;
    }
  }

  Future<void> _uploadVideo() async {
    if (_pickedVideo == null) {
      setState(() => _error = 'Please pick a video first.');
      return;
    }
    if (_pickedThumbnail == null) {
      setState(() => _error = 'Please pick a thumbnail image.');
      return;
    }
    if (_titleController.text.trim().isEmpty) {
      setState(() => _error = 'Please enter a video title.');
      return;
    }
    if (_selectedCategory == null) {
      setState(() => _error = 'Please select a category.');
      return;
    }

    setState(() {
      _isUploading = true;
      _error = null;
      _uploadedVideoUrl = null;
    });

    try {
      // ✅ Upload video
      final videoUrl = await _uploadToCloudinary(_pickedVideo!, 'video');
      if (videoUrl == null) {
        setState(() => _isUploading = false);
        return;
      }

      // ✅ Upload thumbnail
      final thumbUrl = await _uploadToCloudinary(_pickedThumbnail!, 'image');
      if (thumbUrl == null) {
        setState(() => _isUploading = false);
        return;
      }

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _error = 'User not logged in.';
          _isUploading = false;
        });
        return;
      }

      // ✅ Save metadata to Firestore
      await FirebaseFirestore.instance.collection('videos').add({
        'title': _titleController.text.trim(),
        'description': _descController.text.trim(),
        'videoUrl': videoUrl,
        'thumbnailUrl': thumbUrl,
        'category': _selectedCategory,
        'userId': user.uid,
        'uploadedAt': FieldValue.serverTimestamp(),
      });

      setState(() {
        _uploadedVideoUrl = videoUrl;
        _uploadedThumbnailUrl = thumbUrl;
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video uploaded successfully!')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const VideoListScreen()),
      );
    } catch (e) {
      setState(() {
        _error = 'Upload error: $e';
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Video')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Video Title'),
              ),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.video_library),
                label: Text(_pickedVideo == null
                    ? 'Pick Video'
                    : 'Picked: ${_pickedVideo!.name}'),
                onPressed: _pickVideo,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: Text(_pickedThumbnail == null
                    ? 'Pick Thumbnail'
                    : 'Picked: ${_pickedThumbnail!.name}'),
                onPressed: _pickThumbnail,
              ),
              const SizedBox(height: 20),
              if (_isUploading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _uploadVideo,
                  child: const Text('Upload Video'),
                ),
              const SizedBox(height: 20),
              if (_uploadedVideoUrl != null) ...[
                const Text('Upload successful!'),
                SelectableText(_uploadedVideoUrl!),
                if (_uploadedThumbnailUrl != null) ...[
                  const SizedBox(height: 10),
                  const Text('Thumbnail URL:'),
                  SelectableText(_uploadedThumbnailUrl!),
                ],
              ],
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const VideoListScreen()),
                  );
                },
                child: const Text('View Uploaded Videos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
