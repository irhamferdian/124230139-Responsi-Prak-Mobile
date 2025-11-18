import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/services/session_service.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final session = SessionService();
  String username = "";
  File? imageFile;

  @override
  void initState() {
    super.initState();
    loadUsername();
  }

  // Ambil username dari SharedPreferences
  void loadUsername() async {
    final user = await session.getLogin();
    setState(() => username = user ?? "");
  }

  // Ambil foto dari kamera
  Future pickFromCamera() async {
    final imagePicked = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (imagePicked != null) {
      setState(() => imageFile = File(imagePicked.path));
    }
  }

  // Ambil foto dari galeri
  Future pickFromGallery() async {
    final imagePicked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (imagePicked != null) {
      setState(() => imageFile = File(imagePicked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Foto Profil
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade300,
                backgroundImage:
                    imageFile != null ? FileImage(imageFile!) : null,
                child: imageFile == null
                    ? Icon(Icons.person, size: 60, color: Colors.grey)
                    : null,
              ),
            ),

            SizedBox(height: 20),

            // Tombol camera + gallery
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: pickFromCamera,
                  icon: Icon(Icons.camera_alt),
                  label: Text("Camera"),
                ),
                SizedBox(width: 15),
                ElevatedButton.icon(
                  onPressed: pickFromGallery,
                  icon: Icon(Icons.photo),
                  label: Text("Gallery"),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Data statis
            infoItem("Nama", "Irham Ferdiansyah"),
            infoItem("NIM", "124230139"),

            SizedBox(height: 20),

            // Data dinamis
            infoItem("Username", username),

            SizedBox(height: 40),

            // LOGOUT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  await session.logout();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
                  );
                },
                child: Text("Logout", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan informasi
  Widget infoItem(String title, String value) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title:", style: TextStyle(fontSize: 16)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
