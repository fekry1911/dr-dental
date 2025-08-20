import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String day;
  final String reason;
  final String createdAt;
  String? id;

  BookingModel({
    this.id,
    required this.day,
    required this.reason,
    required this.createdAt,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map, String docId) {
    return BookingModel(
      id: docId,
      day: map['day'],
      reason: map['reason'] ?? '',
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "day":day,
      "reason": reason,
      "createdAt": createdAt,
    };
  }
}
