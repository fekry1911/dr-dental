import 'package:bloc/bloc.dart';
import 'package:dr_dental/featuers/user/data/rebo/get_patient_data.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../core/app_export.dart';
import '../../../data/models/patient_model.dart';
import '../../home/screens/patients/data/model/booking_model.dart';
import '../data/models/last_Session.dart';

part 'patient_data_state.dart';

class PatientDataCubit extends Cubit<PatientDataState> {
  GetPatientData getPatientData;
  TextEditingController note=TextEditingController();
  TextEditingController reason=TextEditingController();
  TextEditingController cost=TextEditingController();
  TextEditingController paid=TextEditingController();


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
  Future<void> addBookingToPatient(String date,String time,timeStamp,PatientModel patientModel) async {
    emit(PatientDataLoading());
    try {
      await getPatientData.addBookingToPatient(date,time,timeStamp,patientModel);
      bookings=[];
      bookings=await getPatientData.getPatientAppointments(patientModel.id!);
      emit(PatientAppoinmentsAdd());}
        catch(e){
      emit(PatientDataFAil(e.toString()));
        }
  }
  Future<void> noteTheSession(id,bookID) async {
    emit(PatientDataLoading());
    try {
      BookingUpdateModel bookingUpdateModel=BookingUpdateModel(
        note: note.text,
        reason: reason.text,
        cost: int.parse(cost.text),
        paid: int.parse(paid.text),);
      await getPatientData.noteTheSession(bookingUpdateModel,id,bookID);
      bookings=[];
      bookings=await getPatientData.getPatientAppointments(id);
      emit(PatientDataNote());
    }
    catch(e){
      emit(PatientDataFAil(e.toString()));
    }
  }
}
