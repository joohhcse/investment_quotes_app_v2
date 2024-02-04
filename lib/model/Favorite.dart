class Favorite {
  final int? id;
  final String quote;
  final DateTime date;

  const Favorite({
    this.id,
    required this.quote,
    required this.date,
  });

  Favorite copyWith({
    int? id,
    String? quote,
    DateTime? date,
  }) {
    return Favorite(
      id: id ?? this.id,
      quote: quote ?? this.quote,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quote': quote,
      'date': date.toIso8601String(),
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'] as int,
      quote: map['quote'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }


}