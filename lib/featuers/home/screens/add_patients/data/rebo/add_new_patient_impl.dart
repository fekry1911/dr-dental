import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../../data/models/patient_model.dart';
import 'add_new_patient.dart';

class AppPatientImpl extends AddNewPatient {
  final FirebaseFirestore firestore;
  AppPatientImpl(this.firestore);

  @override
  Future<void> addNewPatient(PatientModel patientModel) async {
    final docRef = firestore.collection('patients').doc();



    await firestore.collection('patients').doc(docRef.id).set({
      "id": docRef.id,
      ...patientModel.toMap(),
    });
    // دمج بيانات المريض مع الـ id
   /* final patientData = {
      ...patientModel.toMap(),
      'id': docRef.id,
    };

    await docRef.set(patientData);*/
  }
}
