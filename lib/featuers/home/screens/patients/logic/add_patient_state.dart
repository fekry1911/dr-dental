part of 'add_patient_cubit.dart';

@immutable
sealed class BookPatientState extends Equatable {}

final class AddPatientInitial extends BookPatientState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
final class GetAllPatientsLoading extends BookPatientState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
final class GetAllPatientsSucc extends BookPatientState {
  List<PatientModel> patients;
  GetAllPatientsSucc(this.patients);
  @override
  // TODO: implement props
  List<Object?> get props => [patients];
}
final class GetAllPatientsFAil extends BookPatientState {
  String error;
  GetAllPatientsFAil(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

final class AddPatientSelectionChanged extends BookPatientState {
  final Set<int> selectedPatients;
  final bool selectionMode;

  AddPatientSelectionChanged(this.selectedPatients, this.selectionMode);

  @override
  List<Object?> get props => [selectedPatients, selectionMode];
}


