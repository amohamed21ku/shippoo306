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
CREATE TABLE Orders (
    OrderId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    SenderId INTEGER REFERENCES Customer(CustomerID),
    SenderLoc TEXT,
    ReceiverId INTEGER REFERENCES Customer(CustomerID),
    ReceiverLoc Text,
    DriverId INTEGER,
    Status VARCHAR(50),
    ShipmentDate Text,
    DeliveryDate Text,
    FOREIGN KEY (DriverId) REFERENCES Vehicle(DriverId)
);
    ''');

    await db.execute('''
CREATE TABLE Vehicle (
    DriverId INTEGER,
    VehicleID INTEGER,
    LicensePlate VARCHAR(20),
    Model VARCHAR(255),
    Capacity INTEGER,
    PRIMARY KEY (DriverId, VehicleID),
    FOREIGN KEY (DriverId) REFERENCES Driver(DriverId)
);
''');

    await db.execute('''
CREATE TABLE Driver (
    DriverId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Firstname VARCHAR(255),
    Lastname VARCHAR(255),
    Phone INTEGER,
    Status VARCHAR(20)
);
''');

    await db.execute('''
CREATE TABLE Cargo (
    OrderId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Description VARCHAR(255),
    Weight DECIMAL(10, 2),
    Type VARCHAR(255),
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);

    ''');


    await db.execute('''
CREATE TABLE User (
    UserId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Username VARCHAR(50),
    Password VARCHAR(255)
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
    INSERT INTO User (Username, Password)
    VALUES
    ('john_doe', 'password123'),
    ('jane_smith', 'pass456'),
    ('bob_johnson', 'secret'),
    ('alice_jones', 'admin_pass'),
    ('charlie_brown', 'user_pass');
    ''');

    await db.execute('''
INSERT INTO Customer (Firstname, Lastname, Phone) VALUES
  ('David', 'Smith', '111-222-3333'),
  ('Emily', 'Johnson', '444-555-6666'),
  ('Michael', 'Davis', '777-888-9999'),
  ('Sophia', 'Miller', '111-222-3333'),
  ('Daniel', 'Brown', '444-555-6666'),
  ('Olivia', 'Garcia', '777-888-9999'),
  ('William', 'Jones', '111-222-3333'),
  ('Emma', 'Anderson', '444-555-6666'),
  ('Alexander', 'Taylor', '777-888-9999'),
  ('Grace', 'Martin', '111-222-3333'),
  ('Benjamin', 'White', '444-555-6666'),
  ('Ava', 'Thompson', '777-888-9999'),
  ('Christopher', 'Wilson', '111-222-3333'),
  ('Mia', 'Moore', '444-555-6666'),
  ('Ethan', 'Lee', '777-888-9999'),
  ('Sofia', 'Perez', '111-222-3333'),
  ('Andrew', 'Hernandez', '444-555-6666'),
  ('Madison', 'Turner', '777-888-9999'),
  ('Liam', 'Wright', '111-222-3333');
''');



    await db.execute('''
  INSERT INTO Vehicle (DriverId, VehicleID, LicensePlate, Model, Capacity)
  VALUES
    (1, 1, 'ABC123', 'Sedan', 5),
    (2, 2, 'XYZ456', 'SUV', 7),
    (3, 3, 'DEF789', 'Truck', 10),
    (4, 4, 'GHI234', 'Compact', 4),
    (5, 5, 'JKL567', 'Van', 8),
    (6, 6, 'MNO890', 'Coupe', 2),
    (7, 7, 'PQR123', 'Motorcycle', 1),
    (8, 8, 'STU456', 'Pickup', 6),
    (9, 9, 'VWX789', 'Convertible', 2),
    (10, 10, 'YZA123', 'Truck', 10);

''');

    await db.execute('''
  INSERT INTO Driver ( Firstname, Lastname, Phone , Status)
  VALUES
    ( 'John', 'Doe', '1234567890','Unavailable'),
    ( 'Jane', 'Smith', '9876543210','Available'),
    ( 'Bob', 'Johnson', '4567890123','Available'),
    ( 'Alice', 'Jones', '7890123456','Available'),
    ( 'Charlie', 'Brown', '1234567890' , 'Unavailable'),
    ( 'David', 'Williams', '9876543210', 'Available'),
    ( 'Emily', 'Taylor', '4567890123','Unavailable'),
    ( 'Frank', 'Clark', '7890123456','Available'),
    ('Grace', 'Martin', '1234567890','Unavailable'),
    ('Henry', 'Davis', '9876543210','Available');
  
''');

    await db.execute('''
INSERT INTO Orders (SenderId, SenderLoc, ReceiverId, ReceiverLoc, DriverId, Status, ShipmentDate, DeliveryDate)
VALUES
  (1, 'Location1', 2, 'Location2', 1, 'InProcess', '2024-01-15', '2024-01-20'),
  (3, 'Location3', 4, 'Location4', 2, 'Canceled', '2024-01-16', '2024-01-21'),
  (5, 'Location5', 6, 'Location6', 3, 'InProcess', '2024-01-17', '2024-01-22'),
  (7, 'Location7', 8, 'Location8', 4, 'Delivered', '2024-01-18', '2024-01-23'),
  (9, 'Location9', 10, 'Location10', 5, 'InProcess', '2024-01-19', '2024-01-24'),
  (11, 'Location11', 12, 'Location12', 6, 'Delivered', '2024-01-20', '2024-01-25'),
  (13, 'Location13', 14, 'Location14', 7, 'InProcess', '2024-01-21', '2024-01-26'),
  (15, 'Location15', 16, 'Location16', 8, 'Delivered', '2024-01-22', '2024-01-27'),
  (17, 'Location17', 18, 'Location18', 9, 'InProcess', '2024-01-23', '2024-01-28'),
  (19, 'Location19', 20, 'Location20', 10, 'Delivered', '2024-01-24', '2024-01-29'),
  (2, 'Location2', 1, 'Location1', 1, 'InProcess', '2024-01-25', '2024-01-30'),
  (4, 'Location4', 3, 'Location3', 2, 'Canceled', '2024-01-26', '2024-01-31'),
  (6, 'Location6', 5, 'Location5', 3, 'InProcess', '2024-01-27', '2024-02-01'),
  (8, 'Location8', 7, 'Location7', 4, 'Canceled', '2024-01-28', '2024-02-02'),
  (10, 'Location10', 9, 'Location9', 5, 'InProcess', '2024-01-29', '2024-02-03'),
  (12, 'Location12', 11, 'Location11', 6, 'Delivered', '2024-01-30', '2024-02-04'),
  (14, 'Location14', 13, 'Location13', 7, 'InProcess', '2024-01-31', '2024-02-05'),
  (16, 'Location16', 15, 'Location15', 8, 'Delivered', '2024-02-01', '2024-02-06'),
  (18, 'Location18', 17, 'Location17', 9, 'InProcess', '2024-02-02', '2024-02-07');

    ''');

    await db.execute('''
  INSERT INTO Cargo (Description, Weight, Type)
  VALUES
    ( 'Electronics', 10.5, 'Fragile'),
    ('Clothing', 5.2, 'Apparel'),
    ( 'Books', 8.0, 'Printed Material'),
    ( 'Furniture', 15.7, 'Furniture'),
    ( 'Toys', 3.3, 'Toys'),
    ( 'Electrical Appliances', 12.0, 'Appliances'),
    ( 'Sports Equipment', 7.8, 'Sports'),
    ( 'Perishables', 4.5, 'Food'),
    ( 'Artwork', 9.2, 'Art'),
    ( 'Tools', 6.1, 'Hardware'),
    ( 'Gadgets', 11.5, 'Electronics'),
    ( 'Jewelry', 2.0, 'Precious Items'),
    ( 'Stationery', 8.7, 'Office Supplies'),
    ( 'Baby Products', 5.9, 'Baby Care'),
    ( 'Musical Instruments', 13.4, 'Music'),
    ( 'Home Decor', 7.0, 'Decor'),
    ( 'Medical Supplies', 4.8, 'Healthcare'),
    ( 'Outdoor Gear', 10.3, 'Outdoor'),
    ( 'Automotive Parts', 6.5, 'Automotive'),
    ( 'Pet Supplies', 3.7, 'Pet Care');
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

  Future<int?> TotalOrders() async {
    Database? mydb = await db;
    return Sqflite.firstIntValue(await readData('SELECT COUNT(*) FROM Orders;'));
  }

  Future<void> updateDriverStatus() async {
    String sql = '''
    UPDATE Driver
    SET Status = 'Unavailable'
    WHERE DriverId IN (
      SELECT DriverId
      FROM Orders
      WHERE Status = 'InProcess'
      GROUP BY DriverId
      HAVING COUNT(DISTINCT OrderId) >= 2
    );
  ''';

    int result = await updateData(sql);

    if (result > 0) {
      print('Driver status updated successfully.');
    } else {
      print('Error updating driver status.');
    }
  }

  Future<int?> countInProcessOrders() async {
    Database? mydb = await db;
    return Sqflite.firstIntValue(await readData("SELECT COUNT(*) FROM Orders WHERE Status = 'InProcess';"));
  }

  Future<int?> countDeliveredOrders() async {
    Database? mydb = await db;
    return Sqflite.firstIntValue(await readData("SELECT COUNT(*) FROM Orders WHERE Status = 'Delivered';"));
  }

  Future<int?> countCanceledOrders() async {
    Database? mydb = await db;
    return Sqflite.firstIntValue(await readData("SELECT COUNT(*) FROM Orders WHERE Status = 'Canceled';"));
  }

  Future<double?> findAverageCargoWeight() async {
    try {
      Database? mydb = await db;
      List<Map<String, dynamic>> result = await mydb!.rawQuery('SELECT AVG(Weight) AS AverageWeight FROM Cargo;');
      double? averageWeight = result.isNotEmpty ? result.first['AverageWeight'] : null;
      return averageWeight;
    } catch (e) {
      print('Error finding average cargo weight: $e');
      return null;
    }
  }




}
