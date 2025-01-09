import 'dart:io';

import 'package:biblio/components/app_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  bool _isLoading = false;

  Future<void> _pickAndUploadImage() async {
    setState(() {
      _isLoading = true;
    });

    // اختيار الصورة
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });

      // رفع الصورة
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String? imageUrl = await uploadImage(pickedImage, userId);

      if (imageUrl != null) {
        // حفظ رابط الصورة في Firestore
        await saveImageUrl(userId, imageUrl);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image uploaded successfully'),
          ),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Image')),
      body: Center(
        child: _isLoading
            ? const AppIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_image != null)
                    Image.file(_image!, height: 200, width: 200)
                  else
                    const Text('No image selected'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickAndUploadImage,
                    child: const Text('Pick and Upload Image'),
                  ),
                ],
              ),
      ),
    );
  }
}

Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
  ); // يمكن تغيير المصدر إلى ImageSource.camera
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null; // إذا لم يختر المستخدم صورة
}

Future<String?> uploadImage(File imageFile, String userId) async {
  try {
    // تحديد مسار الصورة في Firebase Storage
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_images/$userId/${DateTime.now().toIso8601String()}');

    // رفع الصورة
    await ref.putFile(imageFile);

    // جلب رابط الصورة
    String downloadUrl = await ref.getDownloadURL();
    print('Image uploaded successfully: $downloadUrl');
    return downloadUrl;
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}

Future<void> saveImageUrl(String userId, String imageUrl) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'imageUrl': imageUrl,
    });
    print('Image URL saved successfully');
  } catch (e) {
    print('Error saving image URL: $e');
  }
}
