import 'package:path/path.dart';
import 'package:investment_quotes_app_v2/model/quote.dart';
import 'package:investment_quotes_app_v2/model/Favorite.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseService{
  // static final DatabaseService _database = DatabaseService._internal();
  // DatabaseService._internal() {
  //   _openDb();
  // }

  static const DatabaseService instance = DatabaseService._();

  const DatabaseService._();

  static const String _quotesTable = 'quotes_table';
  // static const String _colId = 'id';
  // static const String _colQuote = 'quote';

  static Database? _db;

  Future<Database> get database async {
    print('Future<Database> get db async >>>>>');
    _db ??= await _openDb();
    return _db!;

    // if(_db != null) {
    //   return db!;
    // }
    //
    // _db ??= await _openDb();
    // return _db!;
  }

  Future<Database> _openDb() async {
    // final dir = await getApplicationDocumentsDirectory();
    // final path = dir.path + '/quote_database.db';
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'quote_database.db');

    // await deleteDatabase(path);  //remove // 이 코드로 계속 재실행하면 디비 초기화됨

    final quoteListDb = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE quotes_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            quote TEXT,
            isLiked INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE favorite_table (
            id INTEGER,
            quote TEXT,
            date TEXT
          )
        ''');

        // "1이것은 성공적인 투자 비결 중 하나다.\n주식이 아닌 회사에 집중하라. \n\n - 피터 린치",
        // "2나는 형편없는 산업에서 훌륭한 회사를 항상 찾고 있다. \n컴퓨터나 의료 기술과 같이 빠르게 성장하는 위대한 산업은 너무 많은 관심과 너무 많은 경쟁자를 끌어들인다. \n\n - 피터 린치",
        // "3다른 사람들이 다음 기적을 쫓고 있을 때에도 \n당신이 이해하고, 믿고, 지키려고 하는 것만 사라. \n\n - 피터 린치 ",
        // "4기본적인 이야기는 단순하고 끝이 없다. \n주식은 복권이 아니다. \n모든 주식에는 회사가 붙어 있다. \n\n - 피터 린치 ",
        // "5이것은 성공적인 투자 비결 중 하나다.\n주식이 아닌 회사에 집중하라. \n\n - 피터 린치",
        // "6나는 형편없는 산업에서 훌륭한 회사를 항상 찾고 있다. \n컴퓨터나 의료 기술과 같이 빠르게 성장하는 위대한 산업은 너무 많은 관심과 너무 많은 경쟁자를 끌어들인다. \n\n - 피터 린치",
        // "7다른 사람들이 다음 기적을 쫓고 있을 때에도 \n당신이 이해하고, 믿고, 지키려고 하는 것만 사라. \n\n - 피터 린치 ",
        // "8기본적인 이야기는 단순하고 끝이 없다. \n주식은 복권이 아니다. \n모든 주식에는 회사가 붙어 있다. \n\n - 피터 린치 ",

        // "이것은 성공적인 투자 비결 중 하나다.\n주식이 아닌 회사에 집중하라. \n\n - 피터 린치",
        // "나는 형편없는 산업에서 훌륭한 회사를 항상 찾고 있다. \n컴퓨터나 의료 기술과 같이 빠르게 성장하는 위대한 산업은 너무 많은 관심과 너무 많은 경쟁자를 끌어들인다. \n\n - 피터 린치",
        // "다른 사람들이 다음 기적을 쫓고 있을 때에도 \n당신이 이해하고, 믿고, 지키려고 하는 것만 사라. \n\n - 피터 린치 ",
        // "기본적인 이야기는 단순하고 끝이 없다. \n주식은 복권이 아니다. \n모든 주식에는 회사가 붙어 있다. \n\n - 피터 린치 ",
        // "이것은 성공적인 투자 비결 중 하나다.\n주식이 아닌 회사에 집중하라. \n\n - 피터 린치",

        // "이것은 성공적인 투자 비결 중 하나다.\n주식이 아닌 회사에 집중하라. \n\n - 피터 린치",
        // "나는 형편없는 산업에서 훌륭한 회사를 항상 찾고 있다. \n컴퓨터나 의료 기술과 같이 빠르게 성장하는 위대한 산업은 너무 많은 관심과 너무 많은 경쟁자를 끌어들인다. \n\n - 피터 린치",
        // "다른 사람들이 다음 기적을 쫓고 있을 때에도 \n당신이 이해하고, 믿고, 지키려고 하는 것만 사라. \n\n - 피터 린치 ",
        // "기본적인 이야기는 단순하고 끝이 없다. \n주식은 복권이 아니다. \n모든 주식에는 회사가 붙어 있다. \n\n - 피터 린치 ",

        List<Quote> initialQuotes = [
          Quote(id: 1, quote: '이것은 성공적인 투자 비결 중 하나다.\n주식이 아닌 회사에 집중하라. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 2, quote: '나는 형편없는 산업에서 훌륭한 회사를 항상 찾고 있다. \n컴퓨터나 의료 기술과 같이 빠르게 성장하는 위대한 산업은 너무 많은 관심과 너무 많은 경쟁자를 끌어들인다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 3, quote: '다른 사람들이 다음 기적을 쫓고 있을 때에도 \n당신이 이해하고, 믿고, 지키려고 하는 것만 사라. \n\n - 피터 린치 ', isLiked: 0),
          Quote(id: 4, quote: '기본적인 이야기는 단순하고 끝이 없다. \n주식은 복권이 아니다. \n모든 주식에는 회사가 붙어 있다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 5, quote: '이것은 성공적인 투자 비결 중 하나다.\n주식이 아닌 회사에 집중하라. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 6, quote: '나는 형편없는 산업에서 훌륭한 회사를 항상 찾고 있다. \n컴퓨터나 의료 기술과 같이 빠르게 성장하는 위대한 산업은 너무 많은 관심과 너무 많은 경쟁자를 끌어들인다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 7, quote: '다른 사람들이 다음 기적을 쫓고 있을 때에도 \n당신이 이해하고, 믿고, 지키려고 하는 것만 사라. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 8, quote: '기본적인 이야기는 단순하고 끝이 없다. \n주식은 복권이 아니다. \n모든 주식에는 회사가 붙어 있다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 9, quote: '사람들이 빚더미에 앉은 이유를 이해하려면 금리를 공부할 게 아니라 인간의 탐욕, 불안정성, 낙관주의의 역사를 연구해야 한다. \n\n - 모건 하우절', isLiked: 0),
          Quote(id: 10, quote: '남들이 겁을 먹고 있을때 욕심을 부려라. \n남들이 겁을 먹고 있을 때가 욕심을 부려도 되는 때이다. \n\n - 워렌 버핏', isLiked: 0),
          Quote(id: 11, quote: '조바심을 절제할 수 있어야 한다. \n조바심 때문에 많은 투자자들이 문제에 부딪힌다. \n\n - 워렌 버핏', isLiked: 0),
          Quote(id: 12, quote: '위험은 자신이 무엇을 하는지 모르는데서 온다.\n썰물이 빠졌을 때 비로소 \n누가 발가벗고 수영을 했는지 알 수 있다. \n\n - 워렌 버핏', isLiked: 0),
          Quote(id: 13, quote: '만약 투자가 재미있는 것이라면, \n만약 당신이 투자하는 것이 재밌다면, \n당신은 아마 돈을 전혀 벌지 못할 겁니다. \n좋은 투자는 지루합니다. \n\n - 조지소로스', isLiked: 0),
          Quote(id: 14, quote: '백미러로는 미래를 볼 수 없다. 과거 사건으로 미래를 예단하지 말라.\n\n - 피터 린치', isLiked: 0),
          Quote(id: 15, quote: '주식시장은 확신을 요구하며, \n확신이 없는 사람은 반드시 희생된다.\n\n - 피터 린치', isLiked: 0),
          Quote(id: 16, quote: '평범한 주식들이 모두 똑같이 평범하진 않다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 17, quote: '가장 좋은 주식은 이미 보유한 주식이다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 18, quote: '수익을 당연하게 여기는 생각은 주가가 큰 폭으로 하락하면 확실히 치유된다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 19, quote: '영결식 나팔 소리가 울려퍼지는데 다시 돌아온다는 환상을 품지 마라. 이미 끝난 주식은 미련없이 보내라. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 20, quote: '어떤 기업의 매장을 좋아하면, 그 기업의 주식도 좋아하게 될 확률이 높다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 21, quote: '기업 내부자가 주식을 사면 긍정적인 신호다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 22, quote: '주가 하락은 공포에 사로잡혀 폭풍우 치는 주식시장을 빠져나가려는 부화뇌동자들이 내던진 좋은 주식을 싸게 살 수 있는 기회다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 23, quote: '기업 내부자가 주식을 사면 긍정적인 신호다. \n\n - 피터 린치', isLiked: 0),
        ];

        List<Favorite> initialFavoriteQuotes = [];

        Batch batch = db.batch();
        initialQuotes.forEach((quote) {
          batch.insert('quotes_table', quote.toMap());
        });

        initialFavoriteQuotes.forEach((favorite) {
          batch.insert('favorite_table', favorite.toMap());
        });

        await batch.commit();
      },
    );

     print('Database opened >>>>>');

    return quoteListDb;
  }

  //quote_table
  Future<Quote> insert(Quote quote) async { //copyWith, toMap error?? : sqflite: ^2.0.0+3 : sqflite version problem
    // final db = await this.db;
    final Database db = await database;
    final id = await db.insert('quotes_table', quote.toMap());
    final quoteWithId = quote.copyWith(id: id);
    return quoteWithId;
  }

  Future<List<Quote>> getAllQuotes() async {
    final db = await database;
    final quoteData = await db.query('quotes_table');
    return quoteData.map((e) => Quote.fromMap(e)).toList();
  }
  // Future<int> getIsLikedById(int id) async {
  //   final db = await database;
  //   var result = await db.rawQuery('SELECT isLiked FROM quotes WHERE id=?', ['id']);
  //
  //   if (result.isNotEmpty) {
  //     return result[0]['isLiked'] as int;
  //   } else {
  //     return 2; // 해당 id에 대한 데이터가 없을 경우
  //   }
  // }

  //hhjoo 20240206 add
  Future<Quote?> getQuoteById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> quoteData = await db.query(
      _quotesTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if(quoteData.isEmpty) {
      return null;
    }

    return Quote.fromMap(quoteData.first);
  }

  Future<String> selectQuoteById(int id) async {
    final db = await database;
    var quote = await db.rawQuery('SELECT quote FROM quotes_table WHERE id=?', ['id']);

    if(quote.length > 0) {
      String retQuote = quote.first.values.toString();
      return retQuote;
    }
    else {
      return 'empty';
    }
  }

  Future<int?> getIsLikedById(int id) async {
    final db = await database;
    return await db.rawUpdate('SELECT isLiked FROM quotes_table WHERE id=?', [id]);
  }

  //hhjoo 202402026 //not used
  Future<int> updateQuoteByQuote(Quote quote) async {
    final db = await database;
    return await db.update(
      'quotes_table',
      quote.toMap(),
      where: 'id = ?',
      whereArgs: [quote.id],
    );
  }

  Future<void> updateQuoteIsLikedById(int id, int isLiked) async {
    final db = await database;
    await db.rawUpdate('UPDATE quotes_table SET isLiked = ? WHERE id=?', [isLiked, id]);
  }

  //favorite_table
  Future<List<Favorite>> getAllFavoriteQuotes() async {
    final db = await database;
    final quoteData = await db.query('favorite_table', orderBy: 'date');
    return quoteData.map((e) => Favorite.fromMap(e)).toList();
  }

  Future<Favorite> insertFavoriteQuote(Favorite favorite) async {
    final Database db = await database;
    final id = await db.insert('favorite_table', favorite.toMap());
    final quoteWithId = favorite.copyWith(id: id);
    return quoteWithId;
  }

  Future<int> deleteFavoriteQuote(int id) async {
    final Database db = await database;
    return await db.delete(
      'favorite_table',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}

// class DatabaseConfig{
//
//   static Database? _database;
//
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//
//     // If _database is null, initialize it
//     _database = await databaseInit();
//     return _database!;
//   }
//
//   Future<Database> databaseInit() async {
//     // Get the directory path for both Android and iOS to store the database.
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'quote_database.db');
//
//     // Open the database
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }
//
//   Future<void> _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE quotes(
//         id INTEGER PRIMARY KEY,
//         quote TEXT,
//         isLiked INTEGER
//       )
//     ''');
//
//     // Insert initial data
//     List<Quote> initialWords = [
//       Quote(id: 1, quote: 'apple', isLiked: false),
//       Quote(id: 2, quote: 'school', isLiked: false),
//       Quote(id: 3, quote: 'study', isLiked: false),
//     ];
//
//     Batch batch = db.batch();
//     initialWords.forEach((word) {
//       batch.insert('quotes', word.toMap());
//     });
//
//     await batch.commit();
//   }
//
//   Future<void> insertQuote(Quote quote) async {
//     final Database db = await database;
//     await db.insert('quotes', quote.toMap());
//   }
//
//   Future<Quote?> selectQuoteById(int id) async {
//     final Database db = await database;
//     List<Map<String, dynamic>> result = await db.query('quotes', where: 'id = ?', whereArgs: [id]);
//
//     if (result.isNotEmpty) {
//       return Quote(
//         id: result[0]['id'],
//         quote: result[0]['quote'],
//         isLiked: result[0]['isLiked'],
//       );
//     } else {
//       return null;
//     }
//   }
//
//
//   Future<List<Quote>> getAllQuotes() async {
//     final Database db = await database;
//     List<Map<String, dynamic>> results = await db.query('quotes');
//     List<Quote> quotes = results.map((result) {
//       return Quote(
//         id: result['id'],
//         quote: result['quote'],
//         isLiked: result['isLiked'],
//       );
//     }).toList();
//     return quotes;
//   }
//
//   Future<List<Quote>> selectQuotes() async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> data = await db.query('quotes');
//
//     return List.generate(data.length, (i) {
//       return Quote(
//         id: data[i]['id'],
//         quote: data[i]['quote'],
//         isLiked: data[i]['isLiked'],
//       );
//     });
//   }
//
//   Future<String> selectQuoteById2(int id) async {
//     final Database db = await database;
//     var quote = await db.rawQuery('SELECT quote FROM quotes WHERE id=?', ['id']);
//
//     if(quote.length > 0) {
//       String retQuote = quote.first.values.toString();
//       return retQuote;
//     }
//     else {
//       return 'empty';
//     }
//   }
// }


// static final DatabaseConfig _database = DatabaseConfig._internal();
// late Future<Database> database;
// factory DatabaseConfig() => _database;
//
// DatabaseConfig._internal() {
//   databaseInit();
// }
//
// Future<bool> databaseInit() async {
//   try {
//     database = openDatabase(
//       join(await getDatabasesPath(), 'quote_database.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE quotes(id INTEGER PRIMARY KEY, quote TEXT, isLiked INTEGER)',
//         );
//       },
//       version: 1,
//     );
//
//     print('database Init!!');
//     print(getDatabasesPath());
//
//     return true;
//   } catch (err) {
//     print(err.toString());
//
//     return false;
//   }
// }
//
// Future<List<Quote>> selectQuotes() async {
//   final Database db = await database;
//
//   final List<Map<String, dynamic>> data = await db.query('quotes');
//
//   return List.generate(data.length, (i) {
//     return Quote(
//       id: data[i]['id'],
//       quote: data[i]['quote'],
//       isLiked: data[i]['isLiked'],
//     );
//   });
// }
//
// Future<Quote> selectQuote(int isLiked) async {
//   final Database db = await database;
//
//   final List<Map<String, dynamic>> data =
//   await db.query('quotes', where: "isLiked = ?", whereArgs: [isLiked]);
//
//   return Quote(
//       id: data[0]['id'], quote: data[0]['quote'], isLiked: data[0]['isLiked']);
// }
