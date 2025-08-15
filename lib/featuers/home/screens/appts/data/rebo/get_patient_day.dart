import 'package:dr_dental/data/models/patient_model.dart';

abstract class GetPatientsDay{
  Future<List<PatientModel>> getPatientsOfDay(String day);
}