import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_dental/data/models/patient_model.dart';
import 'package:dr_dental/featuers/home/screens/patients/data/model/booking_model.dart';
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
      var patient = PatientModel.fromMap(doc.data()..['id'] = doc.id);



      patientList.add(patient);
    }

    return patientList;
  }

  @override
  Future addBookingToPatient(Set<PatientModel> patientModels, date) async {
    final patientsCollection = firebaseFirestore.collection("patients");

    for (final patient in patientModels) {
      // استخدم date كـ doc id
      var bookingDocRef = patientsCollection
          .doc(patient.id)
          .collection('bookings')
          .doc(date); // 🔹 doc id = date

      BookingModel booking = BookingModel(
        "note",
        0,
        0,
        id: date, // خلي id = date
        day: date,
        reason: "reason",
        createdAt: Timestamp.fromDate(DateTime.now()), // ✅ تحويل
        time: date,
      );

      await bookingDocRef.set(booking.toMap());
    }
  }

  @override
  @override
  Future deletePatients(Set<PatientModel> patientModel) async {
    final patientsCollection = firebaseFirestore.collection("patients");

    for (final patient in patientModel) {
      final bookingsSnapshot =
      await patientsCollection.doc(patient.id).collection("bookings").get();

      for (final doc in bookingsSnapshot.docs) {
        await doc.reference.delete();
      }

      await patientsCollection.doc(patient.id).delete();

      print("🗑 Deleted patient ${patient.id} and all their bookings");
    }
  }


  @override
  Future deletePatientsBookings(Set<PatientModel> patientModel) async {
    final bookingsCollection = firebaseFirestore.collection("booking");
    final patientsCollection = firebaseFirestore.collection("patients");
    for (final patient in patientModel) {
      List<String> bookingIds=[];
      var data= await patientsCollection.doc(patient.id).collection("bookings").get();
      bookingIds = data.docs.map((doc) => doc.id).toList();
      for (final bookingId in bookingIds) {
        print(bookingId);
        await bookingsCollection.doc(bookingId).collection("bookings").doc(patient.id).delete();
        print("🗑 Deleted booking $bookingId from bookings");
      }

    }



  }
}
