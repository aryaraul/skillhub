import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'course_screen.dart';
import 'upload_video_screen.dart';

final List<Map<String, String>> courses = [
  {
    'id': 'c1',
    'title': 'Complete Flutter Course',
    'category': 'Programming',
    'thumbnail': 'https://picsum.photos/seed/c1/600/350',
    'description': 'Build apps with Flutter'
  },
  {
    'id': 'c2',
    'title': 'Guitar & Music Lessons',
    'category': 'Music',
    'thumbnail': 'https://picsum.photos/seed/c2/600/350',
    'description': 'Learn guitar step-by-step'
  },
  {
    'id': 'c3',
    'title': 'Android Development',
    'category': 'Programming',
    'thumbnail': 'https://picsum.photos/seed/c3/600/350',
    'description': 'Android tips & guides'
  },
  {
    'id': 'c4',
    'title': 'Gaming Highlights',
    'category': 'Gaming',
    'thumbnail': 'https://picsum.photos/seed/c4/600/350',
    'description': 'Game clips & walkthroughs'
  },
  {
    'id': 'c5',
    'title': 'Baking & Desserts',
    'category': 'Cooking',
    'thumbnail': 'https://picsum.photos/seed/c5/600/350',
    'description': 'Sweet treats and baking tips'
  },
  {
    'id': 'c6',
    'title': 'Fitness & Workouts',
    'category': 'Sports',
    'thumbnail': 'https://picsum.photos/seed/c6/600/350',
    'description': 'Home workouts and fitness tips'
  },
  {
    'id': 'c7',
    'title': 'Photography Basics',
    'category': 'Art',
    'thumbnail': 'https://picsum.photos/seed/c7/600/350',
    'description': 'Learn photography fundamentals'
  },
  {
    'id': 'c8',
    'title': 'Quick Cooking Hacks',
    'category': 'Cooking',
    'thumbnail': 'https://picsum.photos/seed/c8/600/350',
    'description': 'Easy recipes and kitchen tricks'
  },
];

final List<Map<String, String>> allContinue = [
  {
    'id': 'v1',
    'title': 'Flutter Basics',
    'thumbnail': 'https://picsum.photos/seed/1/400/230',
    'category': 'Programming',
    'courseId': 'c1'
  },
  {
    'id': 'v2',
    'title': 'State Management in Flutter',
    'thumbnail': 'https://picsum.photos/seed/2/400/230',
    'category': 'Programming',
    'courseId': 'c1'
  },
  {
    'id': 'v3',
    'title': 'Guitar Chords for Beginners',
    'thumbnail': 'https://picsum.photos/seed/3/400/230',
    'category': 'Music',
    'courseId': 'c2'
  },
  {
    'id': 'v4',
    'title': 'Fingerstyle Basics',
    'thumbnail': 'https://picsum.photos/seed/4/400/230',
    'category': 'Music',
    'courseId': 'c2'
  },
  {
    'id': 'v9',
    'title': 'Sourdough Starter',
    'thumbnail': 'https://picsum.photos/seed/9/400/230',
    'category': 'Cooking',
    'courseId': 'c5'
  },
];

final List<Map<String, String>> allForYou = [
  {
    'id': 'v5',
    'title': 'Chocolate Cake Masterclass',
    'thumbnail': 'https://picsum.photos/seed/5/400/230',
    'category': 'Cooking',
    'courseId': 'c5'
  },
  {
    'id': 'v6',
    'title': 'Perfect Cookies Every Time',
    'thumbnail': 'https://picsum.photos/seed/6/400/230',
    'category': 'Cooking',
    'courseId': 'c5'
  },
  {
    'id': 'v7',
    'title': 'Full Body Workout at Home',
    'thumbnail': 'https://picsum.photos/seed/7/400/230',
    'category': 'Sports',
    'courseId': 'c6'
  },
  {
    'id': 'v8',
    'title': 'Morning Yoga Routine',
    'thumbnail': 'https://picsum.photos/seed/8/400/230',
    'category': 'Sports',
    'courseId': 'c6'
  },
  {
    'id': 'v10',
    'title': 'Intro to Photography',
    'thumbnail': 'https://picsum.photos/seed/10/400/230',
    'category': 'Art',
    'courseId': 'c7'
  },
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";
  final List<String> categories = [
    "All",
    "Programming",
    "Music",
    "Cooking",
    "Sports",
    "Gaming",
    "Art"
  ];

  // collect videos for a course (used to pass to CourseScreen)
  List<Map<String, String>> _collectCourseVideos(String courseId) {
    final fromContinue = allContinue.where((v) => v['courseId'] == courseId);
    final fromForYou = allForYou.where((v) => v['courseId'] == courseId);
    return [...fromContinue, ...fromForYou];
  }

  Drawer appDrawer(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.displayName ?? 'SkillHub User'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
          ),
          ListTile(leading: Icon(Icons.home), title: Text('Home'), onTap: () => Navigator.pop(context)),
          ListTile(leading: Icon(Icons.history), title: Text('History'), onTap: () => Navigator.pop(context)),
          ListTile(
  leading: Icon(Icons.video_library),
  title: Text('Your videos'),
  onTap: () {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => UploadVideoScreen()),
    );
  },
),

          ListTile(leading: Icon(Icons.watch_later), title: Text('Watch Later'), onTap: () => Navigator.pop(context)),
          ListTile(leading: Icon(Icons.thumb_up), title: Text('Liked videos'), onTap: () => Navigator.pop(context)),
          Spacer(),
          ListTile(
  leading: const Icon(Icons.video_library),
  title: const Text('Your videos'),
  onTap: () {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const UploadVideoScreen()),
    );
  },
),

        ],
      ),
    );
  }

  Widget _buildHorizontalSection(String title, List<Map<String, String>> videos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 200,
          child: videos.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No items to show', style: TextStyle(color: Colors.grey)),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final v = videos[index];
                    return GestureDetector(
                      onTap: () {
                        // open course if tapped (if it belongs to a course)
                        final courseId = v['courseId'];
                        if (courseId != null) {
                          final course = courses.firstWhere((c) => c['id'] == courseId);
                          final courseVideos = _collectCourseVideos(courseId);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CourseScreen(course: course, videos: courseVideos),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 300,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(v['thumbnail']!, height: 140, width: 300, fit: BoxFit.cover),
                            ),
                            const SizedBox(height: 6),
                            Text(v['title']!, maxLines: 2, overflow: TextOverflow.ellipsis),
                            Text(v['category']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // filter courses by selectedCategory
    List<Map<String, String>> filteredCourses = selectedCategory == "All"
        ? courses
        : courses.where((c) => c['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SkillHub'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(icon: const Icon(Icons.account_circle), onPressed: () => Navigator.pushNamed(context, '/profile')),
        ],
      ),
      drawer: appDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // categories
            SizedBox(
              height: 54,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, i) {
                  final c = categories[i];
                  final sel = c == selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ChoiceChip(
                      label: Text(c),
                      selected: sel,
                      onSelected: (_) {
                        setState(() => selectedCategory = c);
                      },
                      selectedColor: Colors.black,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(color: sel ? Colors.white : Colors.black),
                    ),
                  );
                },
              ),
            ),

            // only show horizontal rows when All selected
            if (selectedCategory == 'All') ...[
              _buildHorizontalSection('Continue Watching', allContinue),
              _buildHorizontalSection('For You', allForYou),
            ],

            // courses grid
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Text('Courses', style: Theme.of(context).textTheme.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredCourses.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 190,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, idx) {
                  final course = filteredCourses[idx];
                  return GestureDetector(
                    onTap: () {
                      final cv = _collectCourseVideos(course['id']!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CourseScreen(course: course, videos: cv),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(course['thumbnail']!, fit: BoxFit.cover),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            child: Text(course['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
