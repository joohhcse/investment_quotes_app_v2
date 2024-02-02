import 'package:path/path.dart';
import 'package:investment_quotes_app_v2/model/quote.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseService{
  static final DatabaseService _database = DatabaseService._internal();
  DatabaseService._internal() {
    print('_openDb()');
    _openDb();
  }

  static const DatabaseService instance = DatabaseService._();

  const DatabaseService._();

  static const String _quotesTable = 'quotes_table';
  static const String _colId = 'id';
  static const String _colQuote = 'quote';

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

    print(databasesPath);

    final quoteListDb = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE quotes_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            quote TEXT,
          )
        ''');

        List<Quote> initialQuotes = [
          Quote(id: 1, quote: 'apple'),
          Quote(id: 2, quote: 'school'),
          Quote(id: 3, quote: 'study'),
        ];

        Batch batch = db.batch();
        initialQuotes.forEach((quote) {
          batch.insert('quotes_table', quote.toMap());
        });

        await batch.commit();
      },
    );
    return quoteListDb;
  }

  //copyWith, toMap error?? : sqflite: ^2.0.0+3 : sqflite version problem
  Future<Quote> insert(Quote quote) async {
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
