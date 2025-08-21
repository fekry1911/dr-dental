import '../../../../data/models/patient_model.dart';
import '../../../home/screens/patients/data/model/booking_model.dart';
import '../models/last_Session.dart';

abstract class GetPatientData{
  Future<PatientModel> getPatientData(String id);
  Future<List<BookingModel>> getPatientAppointments(String id);
  Future deletePatient(String id);
  Future deletePatientAppointments(String patientId,String bookID);
  Future addBookingToPatient(date,time,timeStamp,PatientModel patientModel);
  Future noteTheSession(BookingUpdateModel bookingModel,id,bookingID);
}