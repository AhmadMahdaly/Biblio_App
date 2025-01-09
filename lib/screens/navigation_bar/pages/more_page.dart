import 'package:biblio/services/image_picker.dart';
import 'package:biblio/widgets/more_page/user_name.dart';
import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: const Column(
        children: [
          Center(child: UserName()),
          SizedBox(height: 300, child: UploadImageScreen())
        ],
      ),
    );
  }
}
