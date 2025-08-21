class BookingUpdateModel {
  final String? note;
  final String? reason;
  final int? cost;
  final int? paid;

  BookingUpdateModel({
    this.note,
    this.reason,
    this.cost,
    this.paid,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};

    if (note != null) data['note'] = note;
    if (reason != null) data['reason'] = reason;
    if (cost != null) data['cost'] = cost;
    if (paid != null) data['paid'] = paid;

    return data;
  }
}
