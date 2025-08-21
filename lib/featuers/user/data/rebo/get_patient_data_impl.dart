import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_dental/data/models/patient_model.dart';
import 'package:dr_dental/featuers/home/screens/patients/data/model/booking_model.dart';
import 'package:dr_dental/featuers/user/data/rebo/get_patient_data.dart';

class GetPatientDataImpl extends GetPatientData {
  final FirebaseFirestore firebaseFirestore;

  GetPatientDataImpl(this.firebaseFirestore);

  @override
  Future<List<BookingModel>> getPatientAppointments(String id) async {
    List<BookingModel> bookingsModels = [];
    var bookings =
        await firebaseFirestore
            .collection("patients")
            .doc(id)
            .collection("bookings")
            .orderBy(FieldPath.documentId, descending: true)
            .get();
    bookingsModels =
        bookings.docs.map((e) => BookingModel.fromMap(e.data(), e.id)).toList();
    return bookingsModels;
  }

  @override
  Future<PatientModel> getPatientData(String id) async {
    PatientModel patientModel;
    var patient = await firebaseFirestore.collection("patients").doc(id).get();
    patientModel = PatientModel.fromMap(patient.data()!);
    return patientModel;
  }

  @override
  Future deletePatient(String id) async {
    List<String> bookingIds = [];
    var bookings =
        await firebaseFirestore
            .collection("patients")
            .doc(id)
            .collection("bookings")
            .get();
    bookingIds = bookings.docs.map((doc) => doc.id).toList();
    bookingIds.forEach((element) async {
      await firebaseFirestore
          .collection("booking")
          .doc(element)
          .collection("bookings")
          .doc(id)
          .delete();
    });
    await firebaseFirestore.collection("patients").doc(id).delete();
  }

  @override
  Future deletePatientAppointments(String patientId, String bookID) async {
    await firebaseFirestore
        .collection("patients")
        .doc(patientId)
        .collection("bookings")
        .doc(bookID)
        .delete();
    await firebaseFirestore
        .collection("booking")
        .doc(bookID)
        .collection("bookings")
        .doc(patientId)
        .delete();
  }

  @override
  Future addBookingToPatient(date, time,timeStamp, PatientModel patientModel) async {
    patientModel.bookings = time;
    BookingModel bookingModel = BookingModel(
      id: date,
      day: date,
      reason: "reason",
      createdAt: timeStamp,
      time: time,
    );
    await firebaseFirestore
        .collection("patients")
        .doc(patientModel.id)
        .collection("bookings")
        .doc(date)
        .set({...bookingModel.toMap()});
    await firebaseFirestore
        .collection("booking")
        .doc(date)
        .collection("bookings")
        .doc(patientModel.id)
        .set({"createdAt":bookingModel.createdAt,"id":patientModel.id,...patientModel.toMap()});
  }
}
