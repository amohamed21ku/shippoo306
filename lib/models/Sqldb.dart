import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb{
  static Database? _db;
  // singleton pattern
  Future<Database?> get db async{
    if (_db == null){
      _db = await intialDB();
      return _db;
    }
    else{
      return _db;
    }


  }

  intialDB() async{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'shippo.db'); // databasepath/shippo.db
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 1 , onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db , int old_version , int new_version ){

  }


// called only once when intializing the database
  _onCreate(Database db , int version) async{
    await db.execute('''
    CREATE TABLE Employee (
    EmployeeID INTEGER PRIMARY KEY,
    FirstName TEXT,
    LastName TEXT,
    Position TEXT,
    Email TEXT,
    Phone TEXT
);
    ''');

    await db.execute('''
   INSERT INTO Employee (EmployeeID, FirstName, LastName, Position, Email, Phone)
VALUES (1, 'Ahmed', 'Samir', 'Manager', 'bodysamir2003new@gmail.com', '05528957541');
);
    ''');


    print("Database Created");
  }
  // Function to read mydb
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  // Function to inset into mydb
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  // Function to update into mydb
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }


  // Function to delete in mydb
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
