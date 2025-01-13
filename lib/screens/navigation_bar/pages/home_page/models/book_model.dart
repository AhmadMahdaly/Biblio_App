import 'package:flutter/material.dart';

class BookModel {
  BookModel({
    required this.page,
    required this.bookImage,
    required this.userName,
    required this.bookName,
    required this.writerName,
    required this.userImage,
  });

  final Widget page;
  final String bookImage;
  final String userName;
  final String bookName;
  final String writerName;
  final String userImage;
}
