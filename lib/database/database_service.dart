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

          Quote(id: 5, quote: '사람들이 빚더미에 앉은 이유를 이해하려면 금리를 공부할 게 아니라 인간의 탐욕, 불안정성, 낙관주의의 역사를 연구해야 한다. \n\n - 모건 하우절', isLiked: 0),
          Quote(id: 6, quote: '남들이 겁을 먹고 있을때 욕심을 부려라. \n남들이 겁을 먹고 있을 때가 욕심을 부려도 되는 때이다. \n\n - 워렌 버핏', isLiked: 0),
          Quote(id: 7, quote: '조바심을 절제할 수 있어야 한다. \n조바심 때문에 많은 투자자들이 문제에 부딪힌다. \n\n - 워렌 버핏', isLiked: 0),
          Quote(id: 8, quote: '위험은 자신이 무엇을 하는지 모르는데서 온다.\n썰물이 빠졌을 때 비로소 \n누가 발가벗고 수영을 했는지 알 수 있다. \n\n - 워렌 버핏', isLiked: 0),
          Quote(id: 9, quote: '만약 투자가 재미있는 것이라면, \n만약 당신이 투자하는 것이 재밌다면, \n당신은 아마 돈을 전혀 벌지 못할 겁니다. \n좋은 투자는 지루합니다. \n\n - 조지 소로스', isLiked: 0),

          Quote(id: 10, quote: '백미러로는 미래를 볼 수 없다. 과거 사건으로 미래를 예단하지 말라.\n\n - 피터 린치', isLiked: 0),
          Quote(id: 11, quote: '주식시장은 확신을 요구하며, \n확신이 없는 사람은 반드시 희생된다.\n\n - 피터 린치', isLiked: 0),
          Quote(id: 12, quote: '평범한 주식들이 모두 똑같이 평범하진 않다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 13, quote: '가장 좋은 주식은 이미 보유한 주식이다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 14, quote: '수익을 당연하게 여기는 생각은 주가가 큰 폭으로 하락하면 확실히 치유된다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 15, quote: '영결식 나팔 소리가 울려퍼지는데 다시 돌아온다는 환상을 품지 마라. 이미 끝난 주식은 미련없이 보내라. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 16, quote: '어떤 기업의 매장을 좋아하면, 그 기업의 주식도 좋아하게 될 확률이 높다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 17, quote: '기업 내부자가 주식을 사면 긍정적인 신호다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 18, quote: '주가 하락은 공포에 사로잡혀 폭풍우 치는 주식시장을 빠져나가려는 부화뇌동자들이 내던진 좋은 주식을 싸게 살 수 있는 기회다. \n\n - 피터 린치', isLiked: 0),
          Quote(id: 19, quote: '주식 시장은 인내심이 없는 자로부터 인내심이 많은 자에게로 돈이 넘어가도록 설계되어 있다. \n\n - 워렌 버핏', isLiked: 0),

          Quote(id: 20, quote: '강세장에서 최대의 도박으로 최대 이익을 얻은 자는 필연적으로 뒤따르는 약세장에서 가장 큰 손실을 본다. \n\n - 벤자민 그레이엄', isLiked: 0),
          Quote(id: 21, quote: '첫 번째 규칙은 절대로 잃지 마라. 두 번째 규칙은 첫 번째를 절대로 따라라. \n\n - 워렌 버핏', isLiked: 0),
          Quote(id: 22, quote: '당신이 잠자는 동안에도 돈이 들어오는 방법을 찾지 못한다면 당신은 죽을 때까지 일을 해야 할 것이다. \n\n - 워렌 버핏', isLiked: 0),
          Quote(id: 23, quote: '투자는 IQ나 통찰력 혹은 기법의 문제가 아닌 원칙과 태도의 문제이다. \n\n - 벤자민 그레이엄', isLiked: 0),
          Quote(id: 24, quote: '최적의 매수 타이밍은 시장에 피가 낭자할 때이다. 그것이 당신의 피 일지라도. \n\n - 존 템플턴', isLiked: 0),
          Quote(id: 25, quote: '사람들이 무작정 확신하고 공격적으로 매수할 때 우리는 매우 신중해야 한다. 사람들이 공포심에 패닉에 빠져 아무것도 하지 않거나 매도할 때 우리는 공격적이어야 한다. \n\n - 하워드 막스', isLiked: 0),
          Quote(id: 26, quote: '모두가 탐욕스러울 때 두려워하고 두려워할 때 탐욕스러워라. \n\n - 워렌 버핏', isLiked: 0),
          Quote(id: 27, quote: '현명한 투자자는 비관주의자에게 주식을 사서 낙관주의자에게 판다. \n\n - 벤자민 그레이엄', isLiked: 0),
          Quote(id: 28, quote: '하락장에서 돈을 가장 많이 벌 수 있다. 단지 깨닫지 못할 뿐이다. \n\n - 셀비 M.C. 데이비스', isLiked: 0),
          Quote(id: 29, quote: '투자자는 무엇이 옳고 그른지에 대한 자신만의 생각, 아이디어, 방향을 가지고 있어야 하며, 대중에 휩쓸려 감정적 행동을 하지 않아야 한다. \n\n - 앙드레 코스톨라니', isLiked: 0),

          Quote(id: 30, quote: '돈이란 헛된 기대에 부풀어 있는 도박꾼에게 나와 정확한 확률이 어디인지 아는 사람에게로 들어간다. \n\n - 랄프 웬저', isLiked: 0),
          Quote(id: 31, quote: '단기적으로 시장은 투표 기계이지만 장기적으로 볼 때 체중 측정 기계입니다. \n\n - 벤자민 그레이엄', isLiked: 0),
          Quote(id: 32, quote: '다른 사람들이 팔릴 때 사고 다른 사람들이 살 때까지 기다리세요. 그것은 그저 눈에 띄는 슬로건이 아닙니다. 그것이 바로 성공적인 투자의 본질입니다. \n\n - 진 폴 게티', isLiked: 0),
          Quote(id: 33, quote: '투자할 때 가장 위험한 네 가지 단어는 [이번에는 다르다] 입니다. \n\n - 존 템플턴 경', isLiked: 0),
          Quote(id: 34, quote: '주식시장은 모든 것의 가격을 알고 있지만, 아무것도 아닌 것의 가치를 아는 개인들로 가득 차 있습니다. \n\n - 필립 피셔', isLiked: 0),
          Quote(id: 35, quote: '주식시장은 결코 명백하지 않습니다. 주식시장은 대부분의 사람들을 속이려고 고안된 것입니다. \n\n - 제시 리버모어', isLiked: 0),
          Quote(id: 36, quote: '성공적인 투자는 위험을 피하는 것이 아니라 위험을 관리하는 것입니다. \n\n - 벤자민 그레이엄', isLiked: 0),
          Quote(id: 37, quote: '우리와 같은 사람들이 매우 똑똑해지려고 노력하는 대신, 계속해서 멍청하지 않게 노력함으로써 장기적으로 얼마나 많은 이점을 얻었는지는 주목할 만하다. \n\n - 찰리 멍거', isLiked: 0),
          Quote(id: 38, quote: '투자는 페인트가 마르는 것을 보거나 풀이 자라는 것을 보는 것과 더 비슷해야 합니다. 만약 여러분이 흥분하고 싶다면, 800달러를 가지고 라스베가스로 가세요. \n\n - 폴 새뮤얼슨', isLiked: 0),
          Quote(id: 39, quote: '최대 비관론의 시기는 매수하기에 가장 좋은 시기이고, 최대 낙관론의 시기는 매도하기에 가장 좋은 시기입니다. \n\n - 존 템플턴', isLiked: 0),

          Quote(id: 40, quote: '투자는 보기만큼 어렵지 않습니다. 성공적인 투자는 몇 가지 일을 올바르게 하고 심각한 실수를 피하는 것을 포함합니다. \n\n - 존 보글', isLiked: 0),
          Quote(id: 41, quote: '오늘의 투자자는 어제의 성장으로부터 이익을 얻지 못합니다.\n\n - 워렌 버핏', isLiked: 0),
          Quote(id: 42, quote: '돈을 얼마나 많이 벌느냐가 아니라 얼마나 많은 돈을 유지하느냐, 얼마나 열심히 일하느냐, 그리고 얼마나 많은 세대를 위해 돈을 유지하느냐가 중요합니다. \n\n - 로버트 기요사키', isLiked: 0),
          Quote(id: 43, quote: '당신이 옳고 그름이 중요한 것은 당신이 옳고 그름이 아니라, 당신이 옳을 때 얼마나 많은 돈을 벌고 틀렸을 때 얼마나 많은 돈을 잃는가 하는 것입니다. \n\n - 조지 소로스', isLiked: 0),
          Quote(id: 44, quote: '시장에서 성공하기 위해서는 홀로 설 수 있는 용기와 어려운 결정을 내릴 수 있는 용기가 필요합니다. \n\n - 바이런 윈', isLiked: 0),
          Quote(id: 45, quote: '투자자의 가장 큰 문제는, 그리고 심지어 그의 최악의 적은 그 자신일 가능성이 높습니다. \n\n - 벤자민 그레이엄', isLiked: 0),
          Quote(id: 46, quote: '평판을 쌓는 데는 20년이 걸리고 평판을 망치는 데는 5분이 걸립니다. 만약 여러분이 그것에 대해 생각한다면, 여러분은 다르게 행동할 것입니다.\n\n - 워렌 버핏', isLiked: 0),
          Quote(id: 47, quote: '투자자에게 가장 중요한 자질은 지성이 아니라 기질입니다. \n\n - 워렌 버핏', isLiked: 0),
          Quote(id: 48, quote: '경제 예측의 기능은 점성술을 품위 있게 보이게 만드는 것입니다. \n\n - 존 케네스', isLiked: 0),
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

    print('>>> length >>');
    print(quoteData.length);

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
