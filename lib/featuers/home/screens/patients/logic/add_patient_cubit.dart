import 'package:dr_dental/data/models/patient_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/app_export.dart';
import '../data/model/booking_model.dart';
import '../data/rebo/add_patiemt/add_patient.dart';

part 'add_patient_state.dart';

class BookPatientCubit extends Cubit<BookPatientState> {
  BookingPatient bookingPatient;

  BookPatientCubit(this.bookingPatient) : super(AddPatientInitial());

  List<PatientModel> allPatients = [];
  List<PatientModel> patients = [];

  Future<void> getAllPatients() async {
    emit(GetAllPatientsLoading());
    try {
      allPatients = await bookingPatient.getAllPatients();
      patients = allPatients;
      emit(GetAllPatientsSucc(patients));
    } catch (e) {
      emit(GetAllPatientsFAil(e.toString()));
    }
  }

  void searchPatients(String query) {
    if (query.isEmpty) {
      patients = allPatients;
    } else {
      patients = allPatients.where((patient) {
        return patient.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    emit(GetAllPatientsSucc(patients));
  }


}
