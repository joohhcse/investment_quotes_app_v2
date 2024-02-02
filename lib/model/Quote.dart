class Quote {
  final int? id;
  final String quote;

  const Quote({
    this.id,
    required this.quote,
  });

  Quote copyWith({
    int? id,
    String? quote,
  }) {
    return Quote(
      id: id ?? this.id,
      quote: quote ?? this.quote,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quote': quote,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'] as int,
      quote: map['quote'] as String,
    );
  }

}