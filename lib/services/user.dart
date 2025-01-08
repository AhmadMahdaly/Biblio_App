import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Add user
Future<void> addUser(
  String userId,
  String name,
  String email,
  String password,
) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': name,
      'email': email,
      'password': password,
      'createdAt': FieldValue.serverTimestamp(),
    });
  } catch (e) {}
}

/// Get user
Future<void> getUser(String userId) async {
  try {
    // final DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
  } catch (e) {}
}

/// Update user
Future<void> updateUser(
  String userId,
  String newName,
  String newEmail,
  String newPassword,
) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'name': newName,
      'email': newEmail,
      'password': newPassword,
    });
  } catch (e) {}
}

/// Delete user
Future<void> deleteUser(String userId) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).delete();
  } catch (e) {}
}

/// fetchUserName
Future<String?> fetchUserName() async {
  try {
    // احصل على uid المستخدم الحالي
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      // جلب مستند المستخدم من Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        // استخرج الاسم من المستند
        return userDoc['name'] as String?;
      }
    }
  } catch (e) {
    print('Error: $e');
  }
  return null; // إذا لم يتم العثور على بيانات
}
