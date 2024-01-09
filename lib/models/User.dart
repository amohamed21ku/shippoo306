class User {
  String Firstname;
  String Lastname;
  int EmployeeId;
  String Position;
  String Email;
  String Phone;


  // Named constructor
  User({required this.Firstname,required this.Lastname,required this.EmployeeId,required this.Position,required this.Email,required this.Phone });

  static User currentuser = User(EmployeeId: 0, Email: '', Firstname: '', Lastname: '', Position: '', Phone: '');

}
