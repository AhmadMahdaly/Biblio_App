class BookModel {
  BookModel(
    this.userId,
    this.coverImageUrl,
    this.title,
    this.author,
    this.category,
    this.description,
    this.condition,
    this.offerType,
  );

  final String userId;
  final String coverImageUrl;
  final String title;
  final String author;
  final String category;
  final String description;
  final String condition;
  final String offerType;
}
