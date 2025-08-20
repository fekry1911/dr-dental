import 'package:dr_dental/featuers/home/screens/patients/data/model/booking_model.dart';

import '../../core/app_export.dart';

class PatientModel extends Equatable {
  String name;
  String age;
  String address;
  String gender;
  String phone;
  String? id;
  List<BookingModel>? bookings;

  PatientModel({
    required this.name,
    required this.age,
    required this.address,
    required this.gender,
    required this.phone,
    this.id,
    this.bookings,
  });

  @override
  List<Object?> get props => [id];

  // تحويل الكائن إلى Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'address': address,
      'gender': gender,
      'phone': phone,
      'bookings': bookings?.map((b) => b.toMap()).toList(), // 🟢
    };
  }

  // إنشاء كائن من Map
  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      name: map['name'] as String,
      age: map['age'] as String,
      address: map['address'] as String,
      gender: map['gender'] as String,
      phone: map['phone'] as String,
      id: map['id'] as String?,
      bookings:
          (map['bookings'] as List<dynamic>?)
              ?.map(
                (b) => BookingModel.fromMap(b, b['id']),
              ) // 🟢 مررت الـ id كمان
              .toList(),
    );
  }
}
