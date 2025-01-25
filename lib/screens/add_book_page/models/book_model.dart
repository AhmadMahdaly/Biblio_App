class BookModel {
  BookModel({
    required this.userName,
    required this.userImage,
    required this.coverImageUrlI,
    required this.userId,
    required this.coverImageUrl,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.condition,
    required this.offerType,
    this.price,
  });
  final int? price;
  final String userId;
  final String coverImageUrl;
  final String coverImageUrlI;
  final String userName;
  final String userImage;
  final String title;
  final String author;
  final String category;
  final String description;
  final String condition;
  final String offerType;

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'user_image': userImage,
      'user_name': userName,
      'user_id': userId,
      'cover_image_url': coverImageUrl,
      'title': title,
      'author': author,
      'category': category,
      'description': description,
      'condition': condition,
      'offer_type': offerType,
      'cover_book_url2': coverImageUrlI,
    };
  }
}
