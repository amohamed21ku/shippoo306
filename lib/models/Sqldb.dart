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
CREATE TABLE Vehicle (
    VehicleID INT PRIMARY KEY,
    LicensePlate TEXT,
    Model TEXT,
    Capacity INTEGER
);
    ''');

    await db.execute('''
CREATE TABLE Customer (
    CustomerID INTEGER PRIMARY KEY,
    FirstName TEXT,
    LastName TEXT,
    Email TEXT,
    Phone TEXT
);
    ''');

    await db.execute('''
CREATE TABLE Location (
    LocationID INTEGER PRIMARY KEY,
    Name TEXT,
    Address TEXT,
    City TEXT,
    CountryTEXT
);
    ''');
    await db.execute('''
CREATE TABLE Shipment (
    ShipmentID INTEGER PRIMARY KEY,
    EmployeeID INTEGER,
    CustomerID INTEGER,
    VehicleID INTEGER,
    StartingLocationID INTEGER,
    DestinationLocationID INTEGER,
    Status TEXT,
    ShipmentDate DATE,
    DeliveryDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID),
    FOREIGN KEY (StartingLocationID) REFERENCES Location(LocationID),
    FOREIGN KEY (DestinationLocationID) REFERENCES Location(LocationID)
);
    ''');
    await db.execute('''
CREATE TABLE Cargo (
    CargoID INTEGER PRIMARY KEY,
    ShipmentID INEGERT,
    Description TEXT,
    Weight REAL,
    Type TEXT,
    FOREIGN KEY (ShipmentID) REFERENCES Shipment(ShipmentID)
);
    ''');


    await db.execute('''
CREATE TABLE User (
    UserID INTEGER PRIMARY KEY,
    Username TEXT,
    Password TEXT,
    FirstName TEXT,
    LastName TEXT,
    Type TEXT,
    Phone TEXT
);
    ''');
    await db.execute('''

    INSERT INTO User (UserID, Username, Password, FirstName, LastName, Type, Phone)
    VALUES
    (1, 'john_doe', 'password123', 'John', 'Doe', 'Admin', '555-1234'),
    (2, 'jane_smith', 'pass456', 'Jane', 'Smith', 'User', '555-5678'),
    (3, 'bob_johnson', 'secret', 'Bob', 'Johnson', 'User', '555-9012'),
    (4, 'alice_jones', 'admin_pass', 'Alice', 'Jones', 'Admin', '555-3456'),
    (5, 'charlie_brown', 'user_pass', 'Charlie', 'Brown', 'User', '555-7890');

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
