import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_dental/data/models/patient_model.dart';

import 'get_patient_day.dart';

class GetPatientsDayImpl extends GetPatientsDay {
  final FirebaseFirestore firestore;

  GetPatientsDayImpl(this.firestore);

  @override
  @override
  Future<List<PatientModel>> getPatientsOfDay(String day) async {
    final response = await firestore
        .collection('booking')
        .doc(day)
        .collection('bookings').orderBy("createdAt", descending: false)
        .get();

    return response.docs
        .map((doc) => PatientModel.fromMap(doc.data()))
        .toList();
  }

}
