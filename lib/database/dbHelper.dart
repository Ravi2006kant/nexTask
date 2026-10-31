import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper _instance = DbHelper._();
  static DbHelper getInstance() => _instance;
  static const String DBNAME = 'notes.db';
  static const String TABLENAME = 'todo';
  static const String ID = 'id';
  static const String TASK = 'task';
  static const String DATE = 'date';
  static const String PRIORITY = 'priority';
  static const String TIME = 'time';
  static const String STATUS = 'status';

  Database? mDb;

  //check db
  Future<Database> initdb() async {
    mDb ??= await openDb();
    return mDb!;
  }

  //if not there open db
  Future<Database> openDb() async {
    final Directory app = await getApplicationDocumentsDirectory();
    final String mPath = join(app.path, DBNAME);
    return openDatabase(
      mPath,
      version:1,
      onCreate: (db, version) async {
      await  db.execute('''create table if not exists $TABLENAME (
  $ID INTEGER PRIMARY KEY AUTOINCREMENT,
 $TASK TEXT not null,
 $DATE TEXT ,
 $PRIORITY INTEGER not null,
  $STATUS INTEGER NOT NULL DEFAULT 0
  )
  ''');
      },
    );
  }
  // $TIME REAL ,
  //adding task
  Future<void> addTask({
    required String taskInput,
    required int priorityInput,
    required String dateInput,
    required bool statusInput,
  }) async {
    final db = await initdb();
    await db.insert(TABLENAME, {
      TASK: taskInput,
      DATE: dateInput,
      STATUS: statusInput ? 1:0,
      PRIORITY:priorityInput
    });


    }
    // Future<List<Map<String,dynamic>>> fetchTask() async{
Future<void> fetchTask() async{
final db = await initdb();
final data = await db.query(TABLENAME);
print(data);
// return data;

  }
}
