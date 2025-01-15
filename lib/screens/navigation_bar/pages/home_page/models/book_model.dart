class BookModel {
  BookModel({
    required this.coverImageUrlI,
    required this.coverImageUrlII,
    required this.userId,
    required this.coverImageUrl,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.condition,
    required this.offerType,
  });
  final String userId;
  final String coverImageUrl;
  final String coverImageUrlI;

  final String coverImageUrlII;

  final String title;
  final String author;
  final String category;
  final String description;
  final String condition;
  final String offerType;

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'cover_image_url': coverImageUrl,
      'title': title,
      'author': author,
      'category': category,
      'description': description,
      'condition': condition,
      'offer_type': offerType,
      'cover_book_url2': coverImageUrlI,
      'cover_book_url3': coverImageUrlII,
    };
  }
}
