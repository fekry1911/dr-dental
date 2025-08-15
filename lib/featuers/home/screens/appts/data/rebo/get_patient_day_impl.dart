import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_dental/data/models/patient_model.dart';

import 'get_patient_day.dart';

class GetPatientsDayImpl extends GetPatientsDay {
  final FirebaseFirestore firestore;

  GetPatientsDayImpl(this.firestore);

  @override
  Future<List<PatientModel>> getPatientsOfDay(String day) async {
    List<PatientModel> patientList = [];

    var response = await firestore
        .collection('patients')
        .doc(day)
        .collection('list') // اسم الـ sub-collection للمرضى
        .get();

    for (var doc in response.docs) {
      patientList.add(PatientModel.fromMap(doc.data()));
    }

    return patientList;
  }
}
