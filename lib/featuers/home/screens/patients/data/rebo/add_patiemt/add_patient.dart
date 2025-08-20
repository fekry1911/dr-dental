import '../../../../../../../data/models/patient_model.dart';
import '../../model/booking_model.dart';

abstract class BookingPatient{
  Future bookingPatient(Set<PatientModel> patientModel,String date);
  Future addBookingToPatient(Set<PatientModel> patientModels,date);
  Future<List<PatientModel>> getAllPatients();
  Future deletePatients(Set<PatientModel> patientModel);
  Future deletePatientsBookings(Set<PatientModel> patientModel);

}