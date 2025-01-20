import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
final picker = ImagePicker();
final user = supabase.auth.currentUser;
