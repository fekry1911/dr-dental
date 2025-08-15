

import '../../../../../../../data/models/patient_model.dart';

abstract class AddNewPatient{
  Future<void> addNewPatient(PatientModel patientModel);
}