import 'package:bloc/bloc.dart';
import 'package:dr_dental/data/models/patient_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/app_export.dart';
import '../data/rebo/add_patiemt/add_patient.dart';

part 'add_patient_state.dart';

class BookPatientCubit extends Cubit<BookPatientState> {
  BookingPatient bookingPatient;

  BookPatientCubit(this.bookingPatient) : super(AddPatientInitial());

  // لوجيك الاختيار
  bool selectionMode = false; // هل في وضع التحديد؟
  Set<int> selectedPatients = {}; // index المرضى المختارين

  List<PatientModel> patients=[];
  Future<void> getAllPatients() async {
    print("asdasdasdasdasdasdasdasdasdasdasdasdasdas");
    patients=[];
    emit(GetAllPatientsLoading());
    try{
      patients = await bookingPatient.getAllPatients();
      emit(GetAllPatientsSucc(patients));
    }
    catch(e){
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

  void togglePatientSelection(int index) {
    if (selectedPatients.contains(index)) {
      selectedPatients.remove(index);

      // لو بعد الحذف مفيش حد متعلم عليه → اقفل وضع التحديد
      if (selectedPatients.isEmpty) {
        selectionMode = false;
      }
    } else {
      selectedPatients.add(index);
      selectionMode = true; // اتأكد إنه شغّال لو حد اتعلم عليه
    }

    emit(AddPatientSelectionChanged({...selectedPatients}, selectionMode));
  }
}
