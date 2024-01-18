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
    ReceiverId INTEGER REFERENCES Customer(CustomerID),
    DriverId INTEGER,
    VehicleId INTEGER,
    Status VARCHAR(50),
    ShipmentDate DATE,
    DeliveryDate DATE,
    AddressFrom Text,
    AddressTo Text,
    FOREIGN KEY (DriverId, VehicleId) REFERENCES Vehicle(DriverId, VehicleID)
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
    Firstname VARCHAR(20),
    Lastname VARCHAR(255),
    Phone INTEGER
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


//     await db.execute('''
//   INSERT INTO Address (CustomerID, Address, City, Country)
//   VALUES
//     (1, '123 Main St', 'City1', 'Country1'),
//     (2, '456 Oak St', 'City2', 'Country2'),
//     (3, '789 Elm St', 'City3', 'Country3'),
//     (4, '101 Pine St', 'City4', 'Country4'),
//     (5, '202 Maple St', 'City5', 'Country5'),
//     (6, '303 Cedar St', 'City6', 'Country6'),
//     (7, '404 Birch St', 'City7', 'Country7'),
//     (8, '505 Willow St', 'City8', 'Country8'),
//     (9, '606 Spruce St', 'City9', 'Country9'),
//     (10, '707 Fir St', 'City10', 'Country10'),
//     (11, '808 Redwood St', 'City11', 'Country11'),
//     (12, '909 Sequoia St', 'City12', 'Country12'),
//     (13, '1010 Pine St', 'City13', 'Country13'),
//     (14, '1111 Oak St', 'City14', 'Country14'),
//     (15, '1212 Maple St', 'City15', 'Country15'),
//     (16, '1313 Cedar St', 'City16', 'Country16'),
//     (17, '1414 Birch St', 'City17', 'Country17'),
//     (18, '1515 Willow St', 'City18', 'Country18'),
//     (19, '1616 Spruce St', 'City19', 'Country19');
// ''');


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
    (10, 10, 'YZA123', 'Truck', 10),
    (11, 11, 'BCD456', 'Sedan', 5),
    (12, 12, 'EFG789', 'SUV', 7),
    (13, 13, 'HIJ012', 'Van', 8),
    (14, 14, 'KLM345', 'Compact', 4),
    (15, 15, 'NOP678', 'Coupe', 2),
    (16, 16, 'QRS901', 'Motorcycle', 1),
    (17, 17, 'TUV234', 'Pickup', 6),
    (18, 18, 'WXY567', 'Convertible', 2),
    (19, 19, 'ZAB890', 'Truck', 10),
    (20, 20, 'BCD123', 'Sedan', 5);
''');

    await db.execute('''
  INSERT INTO Driver (Firstname, Lastname, Phone)
  VALUES
    ('John', 'Doe', 1234567890),
    ('Jane', 'Smith', 9876543210),
    ('Bob', 'Johnson', 4567890123),
    ('Alice', 'Jones', 7890123456),
    ('Charlie', 'Brown', 1234567890),
    ('David', 'Williams', 9876543210),
    ('Emily', 'Taylor', 4567890123),
    ('Frank', 'Clark', 7890123456),
    ('Grace', 'Martin', 1234567890),
    ('Henry', 'Davis', 9876543210),
    ('Ivy', 'Garcia', 4567890123),
    ('Jack', 'Hernandez', 7890123456),
    ('Kate', 'Turner', 1234567890),
    ('Leo', 'Wright', 9876543210),
    ('Mia', 'Moore', 4567890123),
    ('Noah', 'Lee', 7890123456),
    ('Olivia', 'Perez', 1234567890),
    ('Peter', 'Wilson', 9876543210),
    ('Quinn', 'Anderson', 4567890123),
    ('Riley', 'Brown', 7890123456);
''');

    await db.execute('''
  INSERT INTO Orders (SenderId, ReceiverId, DriverId, VehicleId, Status, ShipmentDate, DeliveryDate)
  VALUES
    (1, 2, 1, 1, 'InProcess', '2024-01-15', '2024-01-20'),
    (3, 4, 2, 2, 'Canceled', '2024-01-16', '2024-01-21'),
    (5, 6, 3, 3, 'InProcess', '2024-01-17', '2024-01-22'),
    (7, 8, 4, 4, 'Delivered', '2024-01-18', '2024-01-23'),
    (9, 10, 5, 5, 'InProcess', '2024-01-19', '2024-01-24'),
    (11, 12, 6, 6, 'Delivered', '2024-01-20', '2024-01-25'),
    (13, 14, 7, 7, 'InProcess', '2024-01-21', '2024-01-26'),
    (15, 16, 8, 8, 'Delivered', '2024-01-22', '2024-01-27'),
    (17, 18, 9, 9, 'InProcess', '2024-01-23', '2024-01-28'),
    (19, 20, 10, 10, 'Delivered', '2024-01-24', '2024-01-29'),
    (2, 1, 11, 11, 'InProcess', '2024-01-25', '2024-01-30'),
    (4, 3, 12, 12, 'Canceled', '2024-01-26', '2024-01-31'),
    (6, 5, 13, 13, 'InProcess', '2024-01-27', '2024-02-01'),
    (8, 7, 14, 14, 'Canceled', '2024-01-28', '2024-02-02'),
    (10, 9, 15, 15, 'InProcess', '2024-01-29', '2024-02-03'),
    (12, 11, 16, 16, 'Delivered', '2024-01-30', '2024-02-04'),
    (14, 13, 17, 17, 'InProcess', '2024-01-31', '2024-02-05'),
    (16, 15, 18, 18, 'Delivered', '2024-02-01', '2024-02-06'),
    (18, 17, 19, 19, 'InProcess', '2024-02-02', '2024-02-07'),
    (20, 19, 20, 20, 'Canceled', '2024-02-03', '2024-02-08');
''');

    await db.execute('''
  INSERT INTO Cargo (ShipmentId, Description, Weight, Type)
  VALUES
    (1, 'Electronics', 10.5, 'Fragile'),
    (2, 'Clothing', 5.2, 'Apparel'),
    (3, 'Books', 8.0, 'Printed Material'),
    (4, 'Furniture', 15.7, 'Furniture'),
    (5, 'Toys', 3.3, 'Toys'),
    (6, 'Electrical Appliances', 12.0, 'Appliances'),
    (7, 'Sports Equipment', 7.8, 'Sports'),
    (8, 'Perishables', 4.5, 'Food'),
    (9, 'Artwork', 9.2, 'Art'),
    (10, 'Tools', 6.1, 'Hardware'),
    (11, 'Gadgets', 11.5, 'Electronics'),
    (12, 'Jewelry', 2.0, 'Precious Items'),
    (13, 'Stationery', 8.7, 'Office Supplies'),
    (14, 'Baby Products', 5.9, 'Baby Care'),
    (15, 'Musical Instruments', 13.4, 'Music'),
    (16, 'Home Decor', 7.0, 'Decor'),
    (17, 'Medical Supplies', 4.8, 'Healthcare'),
    (18, 'Outdoor Gear', 10.3, 'Outdoor'),
    (19, 'Automotive Parts', 6.5, 'Automotive'),
    (20, 'Pet Supplies', 3.7, 'Pet Care');
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
