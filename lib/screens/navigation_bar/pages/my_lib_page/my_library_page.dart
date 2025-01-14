import 'package:biblio/screens/navigation_bar/pages/my_lib_page/added_library.dart';
// import 'package:biblio/screens/navigation_bar/pages/my_lib_page/empty_library.dart';
import 'package:flutter/material.dart';

class MyLibraryPage extends StatelessWidget {
  const MyLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: const AddedLibrary(),
      //  const EmptyLibrary(),
    );
  }
}
