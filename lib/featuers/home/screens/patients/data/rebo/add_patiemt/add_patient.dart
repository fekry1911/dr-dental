import '../../../../../../../data/models/patient_model.dart';

abstract class BookingPatient{
  Future bookingPatient(PatientModel patientModel,date);
  Future<List<PatientModel>> getAllPatients();
}