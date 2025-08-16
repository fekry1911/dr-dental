import '../../../../../../../data/models/patient_model.dart';

abstract class BookingPatient{
  Future bookingPatient(Set<PatientModel> patientModel,String date);
  Future<List<PatientModel>> getAllPatients();
}