class BookPageModel {
  BookPageModel({
    required this.images,
    required this.bookName,
    required this.writerName,
    required this.category,
    required this.aboutBook,
    required this.bookState,
    required this.offerType,
  });

  final List<String> images;
  final String bookName;
  final String writerName;
  final String category;
  final String aboutBook;
  final String bookState;
  final String offerType;
}
