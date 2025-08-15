import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_dental/data/models/patient_model.dart';
import 'package:dr_dental/featuers/home/screens/patients/data/rebo/add_patiemt/add_patient.dart';

class BookingPatientImpl extends BookingPatient {
  FirebaseFirestore firebaseFirestore;

  BookingPatientImpl(this.firebaseFirestore);

  @override
  Future bookingPatient(PatientModel patientModel, date) async {
    await firebaseFirestore.collection('patients').doc(date).set(
        patientModel.toMap());
  }

  @override
  Future<List<PatientModel>> getAllPatients() async {
    List<PatientModel> patientList = [];
    var response = await firebaseFirestore.collection('patients').get();

    for (var doc in response.docs) {
      patientList.add(PatientModel.fromMap(doc.data()));
    }

    return patientList;
  }
}