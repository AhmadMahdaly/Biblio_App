import 'package:biblio/utils/constants/supabase_instanse.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> updatePassword(String newPassword) async {
  try {
    await supabase.auth.updateUser(
      UserAttributes(
        password: newPassword,
      ),
    );
  } catch (error) {
    // print('خطأ أثناء تحديث كلمة المرور: $error');
  }
}
