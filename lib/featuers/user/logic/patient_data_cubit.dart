import 'package:bloc/bloc.dart';
import 'package:dr_dental/featuers/user/data/rebo/get_patient_data.dart';
import 'package:meta/meta.dart';

import '../../../core/app_export.dart';
import '../../../data/models/patient_model.dart';
import '../../home/screens/patients/data/model/booking_model.dart';

part 'patient_data_state.dart';

class PatientDataCubit extends Cubit<PatientDataState> {
  GetPatientData getPatientData;
  PatientDataCubit(this.getPatientData) : super(PatientDataInitial());
  PatientModel? patientModel;
  List<BookingModel> bookings=[];
  Future<void> getPatientDataFunc(String id) async {
    emit(PatientDataLoading());
    try {
      patientModel = await getPatientData.getPatientData(id);
      bookings=await getPatientData.getPatientAppointments(id);
      emit(PatientDataSucc(patientModel!,bookings));
    } catch (e) {
      emit(PatientDataFAil(e.toString()));
    }
  }
  Future<void> deletePatient(String id) async {
    emit(PatientDataLoading());
    try {
      await getPatientData.deletePatient(id);
      emit(PatientDataDelete());
    } catch (e) {
      emit(PatientDataFAil(e.toString()));
    }
  }
  Future<void> deletePatientAppointments(String patientId,String bookID) async {
    emit(PatientDataLoading());
    try {
      await getPatientData.deletePatientAppointments(patientId,bookID);
      bookings=[];
      bookings=await getPatientData.getPatientAppointments(patientId);
      emit(PatientAppoinmentsDelete());
    } catch (e) {
      emit(PatientDataFAil(e.toString()));
    }
  }
}
