class Quote {
  final int? id;
  final String quote;
  final int isLiked;

  const Quote({
    this.id,
    required this.quote,
    required this.isLiked,
  });

  Quote copyWith({
    int? id,
    String? quote,
    int? isLiked,
  }) {
    return Quote(
      id: id ?? this.id,
      quote: quote ?? this.quote,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quote': quote,
      'isLiked' : isLiked,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'] as int,
      quote: map['quote'] as String,
      isLiked: map['isLiked'] as int,
    );
  }

}