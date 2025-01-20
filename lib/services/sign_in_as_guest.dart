import 'package:biblio/utils/constants/supabase_instanse.dart';

Future<void> signInAsGuest() async {
  try {
    // final response =
    await supabase.auth.signInAnonymously();
    // if (response.user != null) {
    //   print('User signed in as guest: ${response.user!.id}');
    //   // يمكنك استخدام id لتخزين بيانات المستخدم
    // } else {
    //   print('Failed to sign in as guest.');
    // }
  } catch (error) {
    // print('Error signing in as guest: $error');
  }
}
