import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userName = "Arya Raul";
  final String email = "arya@example.com";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50, backgroundColor: Colors.grey[300], child: Icon(Icons.person, size: 50)),
            SizedBox(height: 20),
            Text(userName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(email, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
