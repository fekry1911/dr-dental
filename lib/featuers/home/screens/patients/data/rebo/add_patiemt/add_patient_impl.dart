import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_dental/data/models/patient_model.dart';
import 'package:dr_dental/featuers/home/screens/patients/data/model/booking_model.dart';
import 'package:dr_dental/featuers/home/screens/patients/data/rebo/add_patiemt/add_patient.dart';

class BookingPatientImpl extends BookingPatient {
  FirebaseFirestore firebaseFirestore;

  BookingPatientImpl(this.firebaseFirestore);

  @override

  @override
  Future<List<PatientModel>> getAllPatients() async {
    List<PatientModel> patientList = [];

    var response = await firebaseFirestore.collection('patients').get();

    for (var doc in response.docs) {
      var patient = PatientModel.fromMap(doc.data()..['id'] = doc.id);



      patientList.add(patient);
    }

    return patientList;
  }

}
