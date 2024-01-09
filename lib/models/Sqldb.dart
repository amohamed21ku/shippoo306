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
      String databasepath = await getDatabasesPath();
      String path = join(databasepath, 'shippo.db'); // databasepath/shippo.db
      print(path);
      return _db;
    }


  }

  intialDB() async{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'shippo.db'); // databasepath/shippo.db
    print(path);
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 1 , onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db , int old_version , int new_version ){

  }


// called only once when intializing the database
  _onCreate(Database db , int version) async{
    await db.execute('''
    CREATE TABLE Employee (
    EmployeeId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Firstname VARCHAR(255),
    Lastname VARCHAR(255),
    Position VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20)
);
    ''');

    await db.execute('''
CREATE TABLE Customer (
    CustomerID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Firstname VARCHAR(255),
    Lastname VARCHAR(255),
    Phone VARCHAR(20)
);
    ''');

    await db.execute('''
CREATE TABLE Shipment (
    ShipmentId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    SenderId INTEGER REFERENCES Customer(CustomerID),
    ReceiverId INTEGER REFERENCES Customer(CustomerID),
    DriverId INTEGER,
    VehicleId INTEGER,
    Status VARCHAR(50),
    ShipmentDate DATE,
    DeliveryDate DATE,
    FOREIGN KEY (DriverId, VehicleId) REFERENCES Employee(EmployeeId, EmployeeId)
);
    ''');

    await db.execute('''
CREATE TABLE Vehicle (
    VehicleId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    LicensePlate VARCHAR(20),
    Model VARCHAR(255),
    Capacity INTEGER
);
    ''');
    await db.execute('''
CREATE TABLE Address (
    AddressId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    CustomerID INTEGER REFERENCES Customer(CustomerID),
    Name VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    Country VARCHAR(255),
    ZipCode VARCHAR(20),
    UNIQUE (AddressId, CustomerID)
);

    ''');
    await db.execute('''
CREATE TABLE Cargo (
    CargoId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    ShipmentId INTEGER REFERENCES Shipment(ShipmentId),
    Description VARCHAR(255),
    Weight DECIMAL(10, 2),
    Type VARCHAR(255)
);
    ''');


    await db.execute('''
CREATE TABLE User (
    UserId INTEGER PRIMARY KEY AUTOINCREMENT,
    Username VARCHAR(50),
    Password VARCHAR(255),
);

    ''');
    await db.execute('''
    INSERT INTO Employee ( Firstname, Lastname, Position, Email, Phone)
VALUES
('John', 'Doe', 'Manager', 'john.doe@example.com', '123-456-7890'),
( 'Jane', 'Smith', 'Developer', 'jane.smith@example.com', '987-654-3210'),
( 'Bob', 'Johnson', 'Designer', 'bob.johnson@example.com', '456-789-0123'),
( 'Alice', 'Jones', 'Admin', 'alice.jones@example.com', '789-012-3456'),
( 'Charlie', 'Brown', 'User', 'charlie.brown@example.com', '012-345-6789');

''');
    await db.execute('''

    INSERT INTO User (EmployeeId , Username, Password)
    VALUES
    (1, 'john_doe', 'password123'),
    (2, 'jane_smith', 'pass456'),
    (3, 'bob_johnson', 'secret'),
    (4, 'alice_jones', 'admin_pass'),
    (5, 'charlie_brown', 'user_pass');
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
