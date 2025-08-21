part of 'patient_data_cubit.dart';

@immutable
sealed class PatientDataState extends Equatable  {}

final class PatientDataInitial extends PatientDataState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class PatientDataLoading extends PatientDataState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class PatientDataSucc extends PatientDataState {
  final PatientModel patientModel;
  final List<BookingModel> bookings;
  PatientDataSucc(this.patientModel,this.bookings);
  @override
  // TODO: implement props
  List<Object?> get props =>[patientModel.id];

}
class PatientDataFAil extends PatientDataState {
  final String error;

  PatientDataFAil(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
class PatientDataDelete extends PatientDataState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class PatientAppoinmentsDelete extends PatientDataState {

  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class PatientAppoinmentsAdd extends PatientDataState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}


