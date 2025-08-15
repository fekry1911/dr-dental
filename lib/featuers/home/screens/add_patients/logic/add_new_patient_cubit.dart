import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../data/models/patient_model.dart';
import '../data/rebo/add_new_patient.dart';

part 'add_new_patient_state.dart';

class AddNewPatientCubit extends Cubit<AddNewPatientState> {
  AddNewPatient addNewPatient;
  AddNewPatientCubit(this.addNewPatient) : super(AddNewPatientInitial());
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController phone = TextEditingController();
  String? selectedGender;
  bool isSelectedGender = false;

  void changeGender(String gender) {
    selectedGender = gender;
    print(selectedGender);
    isSelectedGender = true;
    emit(StudentGenderChanged());
  }

  Future<void> addPatient() async {
    try {
      emit(AddPatientLoading());
      await addNewPatient.addNewPatient(
        PatientModel(name: name.text, age:age.text, address: address.text, gender: selectedGender!, phone: phone.text),
      );
      name.clear();
      age.clear();
      address.clear();
      phone.clear();
      selectedGender = null;
      emit(AddPatientSuccess());
    } catch (e) {
      emit(AddPatientFailure());
    }
  }

}
