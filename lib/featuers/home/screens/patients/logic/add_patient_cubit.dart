import 'package:dr_dental/data/models/patient_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/app_export.dart';
import '../data/model/booking_model.dart';
import '../data/rebo/add_patiemt/add_patient.dart';

part 'add_patient_state.dart';

class BookPatientCubit extends Cubit<BookPatientState> {
  BookingPatient bookingPatient;

  BookPatientCubit(this.bookingPatient) : super(AddPatientInitial());

  bool selectionMode = false;
  Set<PatientModel> selectedPatients = {};
  List<PatientModel> patients = [];
  List<BookingModel> bookings = [];

  Future<void> getAllPatients() async {
    patients = [];
    bookings = [];
    emit(GetAllPatientsLoading());
    try {
      patients = await bookingPatient.getAllPatients();

      emit(GetAllPatientsSucc(patients));
    } catch (e) {
      emit(GetAllPatientsFAil(e.toString()));
    }
  }

  Future<void> deletePatients() async {
    try {
      await bookingPatient.deletePatientsBookings(selectedPatients);
      await bookingPatient.deletePatients(selectedPatients);
      selectedPatients.clear();
      selectionMode = false;
      getAllPatients();
    } catch (e) {
      emit(GetAllPatientsFAil(e.toString()));
    }
  }

  Future<void> bookPatient(String date) async {
    emit(GetAllPatientsLoading());
    try {
      // await bookingPatient.bookingPatient(selectedPatients, date);
      // await bookingPatient.addBookingToPatient(selectedPatients, date);
      getAllPatients();
      selectedPatients.clear();
      selectionMode = false;

      emit(GetAllPatientsSucc(patients));
    } catch (e) {
      emit(GetAllPatientsFAil(e.toString()));
    }
  }

  void toggleSelectionMode(bool enable) {
    selectionMode = enable;
    if (!enable) {
      selectedPatients.clear();
    }
    emit(AddPatientSelectionChanged({...selectedPatients}, selectionMode));
  }

  void clearSelection() {
    selectedPatients.clear();
    selectionMode = false;
    emit(AddPatientSelectionChanged({...selectedPatients}, selectionMode));
  }

  void togglePatientSelection(PatientModel patient) {
    if (selectedPatients.contains(patient)) {
      selectedPatients.remove(patient);
      if (selectedPatients.isEmpty) {
        selectionMode = false;
      }
    } else {
      selectedPatients.add(patient);
      selectionMode = true;
    }
    emit(AddPatientSelectionChanged({...selectedPatients}, selectionMode));
  }
}
