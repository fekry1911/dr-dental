import '../../../../../../../data/models/patient_model.dart';
import '../../model/booking_model.dart';

abstract class BookingPatient{
  Future<List<PatientModel>> getAllPatients();

}