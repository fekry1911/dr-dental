import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_dental/data/models/patient_model.dart';
import 'package:dr_dental/featuers/home/screens/patients/data/rebo/add_patiemt/add_patient.dart';

class BookingPatientImpl extends BookingPatient {
  FirebaseFirestore firebaseFirestore;

  BookingPatientImpl(this.firebaseFirestore);

  @override
  Future bookingPatient(Set<PatientModel> patientModels, String date) async {
    final dateDoc = firebaseFirestore.collection('booking').doc(date);

    for (final patient in patientModels) {
      print(patient);
      await dateDoc.collection('bookings').doc(patient.id).set(patient.toMap());
    }
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