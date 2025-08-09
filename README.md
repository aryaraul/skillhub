# 🎯 SkillHub

SkillHub is a **skill-sharing platform** built using **Flutter** where users can **learn or teach** various skills like guitar, coding, photography, and more.  
The app allows people to upload courses, watch lessons, and connect with other learners and mentors.

---

## 🚀 Features

- 🔐 **User Authentication** – Sign up and log in using Firebase Authentication  
- 🎥 **Video Uploads** – Share your skills by uploading video lessons  
- 📚 **Browse Courses** – Discover skills in different categories  
- 📜 **Personalized Recommendations** – Get skill suggestions based on your history  
- 🖥 **Cross-Platform** – Works on Android, iOS, and Web  
- 📂 **Firebase Integration** – For authentication, storage, and database

---

## 🛠 Tech Stack

- **Frontend**: Flutter  
- **Backend**: Firebase (Auth, Firestore, Storage)  
- **Language**: Dart  
- **Database**: Cloud Firestore  

---

## 📂 Project Structure

```plaintext
skillhub/
│
├── lib/
│   ├── main.dart              # App entry point
│   ├── login/                 # Login and signup UI
│   ├── home/                  # Home screen and dashboard
│   ├── course_screen.dart     # Course detail screen
│   ├── upload_video_screen.dart # Upload course videos
│   └── widgets/               # Reusable UI components
│
├── assets/
│   └── images/                # App images & icons
│
├── pubspec.yaml               # Dependencies
└── README.md
