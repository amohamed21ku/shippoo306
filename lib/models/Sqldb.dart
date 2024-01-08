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
    EmployeeId INT AUTO_INCREMENT PRIMARY KEY,
    Firstname VARCHAR(255),
    Lastname VARCHAR(255),
    Position VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20)
);
    ''');

    await db.execute('''
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Firstname VARCHAR(255),
    Lastname VARCHAR(255),
    Phone VARCHAR(20)
);

    ''');

    await db.execute('''
CREATE TABLE Shipment (
    ShipmentId INT AUTO_INCREMENT PRIMARY KEY,
    SenderId INT REFERENCES Customer(CustomerID),
    ReceiverId INT REFERENCES Customer(CustomerID),
    DriverId INT,
    VehicleId INT,
    Status VARCHAR(50),
    ShipmentDate DATE,
    DeliveryDate DATE,
    FOREIGN KEY (DriverId, VehicleId) REFERENCES Employee(EmployeeId, EmployeeId)
);
    ''');

    await db.execute('''
CREATE TABLE Vehicle (
    VehicleId INT AUTO_INCREMENT PRIMARY KEY,
    LicensePlate VARCHAR(20),
    Model VARCHAR(255),
    Capacity INT
);
    ''');
    await db.execute('''
CREATE TABLE Address (
    AddressId INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT REFERENCES Customer(CustomerID),
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
    CargoId INT AUTO_INCREMENT PRIMARY KEY,
    ShipmentId INT REFERENCES Shipment(ShipmentId),
    Description VARCHAR(255),
    Weight DECIMAL(10, 2),
    Type VARCHAR(255)
);
    ''');


    await db.execute('''
CREATE TABLE User (
    EmployeeId  INT,
    Username VARCHAR(50),
    Password VARCHAR(255),
    PRIMARY KEY (Username, EmployeeId),
    FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId)
);

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
