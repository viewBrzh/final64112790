class User {
  final int uID;
  final String uTelephone;
  final String name;  

  User({
    required this.uID,
    required this.uTelephone,
    required this.name
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uID: int.parse(json['uID']),
      uTelephone: json['uTelephone'],
      name: json['uName'],
    );
  }
}

class Car {
  final int cID;
  final String cName;
  final String cBrand;
  final String cType;
  final int cPassengers;
  final String? cImage;
  final int cPrice;  

  Car({
    required this.cID,
    required this.cName,
    required this.cBrand,
    required this.cType,
    required this.cPassengers,
    required this.cImage,
    required this.cPrice,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      cID: int.parse(json['cID'] ?? '0'),
      cName: json['cName'] ?? 'No Name',
      cBrand: json['cBrand'] ?? 'No Brand',
      cType: json['cType'] ?? 'No Type',
      cPassengers: int.parse(json['cPassengers'] ?? '0'),
      cImage: json['cImage'] ?? 'D:/Mobile/car/flutter_car/lib/handleError/image/error_car.png',
      cPrice: int.parse(json['cPrice'] ?? '0'),
    );
  }
}

class Booking {
  final int bID;
  final int uID;
  final int cID;
  final DateTime uDateFrom; // Change to DateTime type
  final DateTime uDateTo; // Change to DateTime type

  Booking({
    required this.bID,
    required this.uID,
    required this.cID,
    required this.uDateFrom,
    required this.uDateTo,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bID: int.parse(json['bID'].toString() ?? '0'),
      uID: int.parse(json['uID'].toString() ?? '0'),
      cID: int.parse(json['cID'].toString() ?? '0'),
      uDateFrom: DateTime.parse(json['uDateFrom']), // Parse as DateTime
      uDateTo: DateTime.parse(json['uDateTo']), // Parse as DateTime
    );
  }
}

