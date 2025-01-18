import 'package:supabase_flutter/supabase_flutter.dart';

final SupabaseClient supabase = Supabase.instance.client;

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
