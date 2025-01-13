import 'package:biblio/screens/onboard_screen.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({super.key});

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  bool _isDeleting = false;

  Future<void> deleteAccount(BuildContext context) async {
    setState(() {
      _isDeleting = true;
    });
    try {
      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        throw Exception('لم يتم تسجيل الدخول.');
      }

      // حذف البيانات المرتبطة بالمستخدم من قاعدة البيانات
      final deleteResponse = await Supabase.instance.client
          .from('users')
          .delete()
          .eq('id', user.id);

      // ignore: avoid_dynamic_calls
      if (deleteResponse.error != null) {
        throw Exception(
          // ignore: avoid_dynamic_calls
          'حدث خطأ أثناء حذف بيانات المستخدم: ${deleteResponse.error!.message}',
        );
      }

      // حذف الحساب من Supabase Auth
      //  final authResponse =
      await Supabase.instance.client.auth.admin.deleteUser(user.id);

      // if (authResponse. == null) {
      //   throw Exception(
      //       'حدث خطأ أثناء حذف الحساب: ${authResponse.error!.message}');
      // }
      await Future.delayed(
        const Duration(seconds: 2),
      ); // محاكاة التأخير
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم حذف الحساب بنجاح!'),
          ),
        );
      }
      if (mounted) {
        // توجيه المستخدم إلى صفحة البداية
        await Navigator.pushNamedAndRemoveUntil(
          context,
          OnboardScreen.id,
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        if (kDebugMode) {
          print('خطأ أثناء حذف الحساب: $e');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ أثناء حذف الحساب.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isDeleting
        ? const AppIndicator()
        :

        /// Delete Account
        Row(
            children: [
              TextButton(
                onPressed: () async {
                  // ignore: inference_failure_on_function_invocation
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('تأكيد حذف الحساب'),
                      content: const Text(
                        'هل أنت متأكد أنك تريد حذف حسابك؟\n ستختفي كل بياناتك ومعلوماتك بمجرد قبولك بحذف الحساب.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('إلغاء'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context); // إغلاق نافذة التأكيد
                            await deleteAccount(context);
                          },
                          child: const Text('حذف الحساب'),
                        ),
                      ],
                    ),
                  );
                  await Navigator.popAndPushNamed(
                    context,
                    OnboardScreen.id,
                  );
                },
                child: Text(
                  'حذف الحساب',
                  style: TextStyle(
                    color: const Color(0xFFEA1C25),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          );
  }
}
