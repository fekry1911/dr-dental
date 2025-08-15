class PatientModel {
  String name;
  String age;
  String address;
  String gender;
  String phone;
  String? id;

  PatientModel({
    required this.name,
    required this.age,
    required this.address,
    required this.gender,
    required this.phone,
    this.id,
  });

  // تحويل الكائن إلى Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'address': address,
      'gender': gender,
      'phone': phone,
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
    );
  }
}
