import 'package:biblio/components/app_indicator.dart';
import 'package:biblio/services/user.dart';
import 'package:flutter/material.dart';

class UserName extends StatelessWidget {
  const UserName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: fetchUserName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('');
        } else {
          return Text(
            'أهلًا ${snapshot.data}!',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          );
        }
      },
    );
  }
}
