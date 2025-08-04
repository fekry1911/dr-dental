
class SessionModel {
  final String id;
  final String patientId;
  final DateTime date;
  final String description;
  final double cost;

  SessionModel({
    required this.id,
    required this.patientId,
    required this.date,
    required this.description,
    required this.cost,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json, String docId) {
    return SessionModel(
      id: docId,
      patientId: json['patientId'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      cost: json['cost'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'date': date.toIso8601String(),
      'description': description,
      'cost': cost,
    };
  }
}
