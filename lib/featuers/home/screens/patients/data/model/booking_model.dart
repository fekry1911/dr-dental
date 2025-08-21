import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String day;
  final String reason;
  final String time;
  final Timestamp createdAt; // Firestore expects Timestamp
  String? id;

  BookingModel({
    this.id,
    required this.day,
    required this.reason,
    required this.createdAt,
    required this.time,
  });

  // تحويل من Map (Firestore document) لـ BookingModel
  factory BookingModel.fromMap(Map<String, dynamic> map, String docId) {
    return BookingModel(
      id: docId,
      day: map['day'] ?? '',
      reason: map['reason'] ?? '',
      createdAt: map['createdAt'] as Timestamp, // ✅ تأكد من النوع
      time: map['time'] ?? '',
    );
  }

  // تحويل من BookingModel لـ Map عشان تخزن في Firestore
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "day": day,
      "reason": reason,
      "createdAt": createdAt, // Timestamp جاهز
      "time": time,
    };
  }
}
