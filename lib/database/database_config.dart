import 'package:path/path.dart';
import 'package:investment_quotes_app_v2/model/quote.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConfig{
  static final DatabaseConfig _database = DatabaseConfig._internal();
  late Future<Database> database;
  factory DatabaseConfig() => _database;

  DatabaseConfig._internal() {
    databaseInit();
  }

  Future<bool> databaseInit() async {
    try {
      database = openDatabase(
        join(await getDatabasesPath(), 'quote_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE quotes(id INTEGER PRIMARY KEY, quote TEXT, isLiked INTEGER)',
          );
        },
        version: 1,
      );

      print('database Init!!');
      print(getDatabasesPath());

      return true;
    } catch (err) {
      print(err.toString());

      return false;
    }
  }

  Future<List<Quote>> selectQuotes() async {
    final Database db = await database;

    final List<Map<String, dynamic>> data = await db.query('quotes');

    return List.generate(data.length, (i) {
      return Quote(
        id: data[i]['id'],
        quote: data[i]['quote'],
        isLiked: data[i]['isLiked'],
      );
    });
  }

  Future<Quote> selectQuote(int isLiked) async {
    final Database db = await database;

    final List<Map<String, dynamic>> data =
    await db.query('quotes', where: "isLiked = ?", whereArgs: [isLiked]);

    return Quote(
        id: data[0]['id'], quote: data[0]['quote'], isLiked: data[0]['isLiked']);
  }
}

/////////////////// ChatGPT 참고 : batch() 이용
// class DBHelper {
//   static Database? _database;
//
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//
//     // If _database is null, initialize it
//     _database = await initDatabase();
//     return _database!;
//   }
//
//   Future<Database> initDatabase() async {
//     // Get the directory path for both Android and iOS to store the database.
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'word_database.db');
//
//     // Open the database
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }
//
//   Future<void> _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE words(
//         id INTEGER PRIMARY KEY,
//         name TEXT,
//         meaning TEXT
//       )
//     ''');
//
//     // Insert initial data
//     List<Word> initialWords = [
//       Word(id: 1, name: 'apple', meaning: '사과'),
//       Word(id: 2, name: 'school', meaning: '학교'),
//       Word(id: 3, name: 'study', meaning: '공부하다'),
//     ];
//
//     Batch batch = db.batch();
//     initialWords.forEach((word) {
//       batch.insert('words', word.toMap());
//     });
//
//     await batch.commit();
//   }
//
//   Future<void> insertWord(Word word) async {
//     final Database db = await database;
//     await db.insert('words', word.toMap());
//   }
// }





