import 'package:shippoo306/models/ShowingOrders.dart';

class Details{
  final int activeButton;
  Details({required this.activeButton});

    choosing_details(){
    if(this.activeButton == 0){return ShowingOrders(sql:'''
    SELECT 
  o.ShipmentDate,
  o.DeliveryDate,
  sender.Firstname AS SenderFirstname,
  sender.Lastname AS SenderLastname,
  receiver.Firstname AS ReceiverFirstname,
  receiver.Lastname AS ReceiverLastname
FROM 
  Orders o
JOIN 
  Customer sender ON o.SenderId = sender.CustomerID
JOIN 
  Customer receiver ON o.ReceiverId = receiver.CustomerID;
        ''' );}
    else if(this.activeButton ==1){return ShowingOrders(sql: '''
    SELECT 
  o.ShipmentDate,
  o.DeliveryDate,
  sender.Firstname AS SenderFirstname,
  sender.Lastname AS SenderLastname,
  receiver.Firstname AS ReceiverFirstname,
  receiver.Lastname AS ReceiverLastname
FROM 
  Orders o
JOIN 
  Customer sender ON o.SenderId = sender.CustomerID
JOIN 
  Customer receiver ON o.ReceiverId = receiver.CustomerID
WHERE 
  o.Status = 'InProcess';
''');}
    else if(this.activeButton ==2){return ShowingOrders(sql: '''
    SELECT 
  o.ShipmentDate,
  o.DeliveryDate,
  sender.Firstname AS SenderFirstname,
  sender.Lastname AS SenderLastname,
  receiver.Firstname AS ReceiverFirstname,
  receiver.Lastname AS ReceiverLastname
FROM 
  Orders o
JOIN 
  Customer sender ON o.SenderId = sender.CustomerID
JOIN 
  Customer receiver ON o.ReceiverId = receiver.CustomerID
WHERE 
  o.Status = 'Delivered';

    ''');}
    else if(this.activeButton ==3){return ShowingOrders(sql: '''
    SELECT 
  o.ShipmentDate,
  o.DeliveryDate,
  sender.Firstname AS SenderFirstname,
  sender.Lastname AS SenderLastname,
  receiver.Firstname AS ReceiverFirstname,
  receiver.Lastname AS ReceiverLastname
FROM 
  Orders o
JOIN 
  Customer sender ON o.SenderId = sender.CustomerID
JOIN 
  Customer receiver ON o.ReceiverId = receiver.CustomerID
WHERE 
  o.Status = 'Canceled';

    ''');}



  }




}