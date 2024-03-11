class Product {
  final int? orderID;
  final String? customerID;
  final int? employeeID;
  final DateTime? orderDate;
  final DateTime? shippedDate;
  final double? freight;
  final String? shipName;
  final String? shipAddress;
  final String? shipCity;
  final int? shipPostelCode;
  final String? shipCountry;


  Product(
      {required this.orderID,
        required this.customerID,
        required this.employeeID,
        required this.orderDate,
        required this.shippedDate,
        required this.freight,
        required this.shipName,
        required this.shipAddress,
        required this.shipCity,
        required this.shipPostelCode,
        required this.shipCountry,
      });


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        orderID: json['OrderID'],
        customerID: json['CustomerID'],
        employeeID: json['EmployeeID'],
        orderDate: DateTime.parse(json['OrderDate']),
        shippedDate: DateTime.parse(json['ShippedDate']),
        freight: json['Freight'],
        shipName: json['ShipName'],
        shipAddress: json['ShipAddress'],
        shipCity: json['ShipCity'],
        shipPostelCode: json['ShipPostelCode'],
        shipCountry: json['ShipCountry']);
  }


  static List<String> getFieldNames() {
    return ['orderID', 'customerID', 'orderDate', 'freight'];

    // return ['ID', 'Name', 'Designation', 'Salary'];
  }

}