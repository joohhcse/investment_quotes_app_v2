class Quote {

  final int id;
  final String quote;
  final bool isLiked;

  Quote({
    required this.id,
    required this.quote,
    required this.isLiked
  });

  Map<String , dynamic> toMap() {
    return {
      'id': id,
      'quote': quote,
      'isLiked': isLiked
    };
  }

}