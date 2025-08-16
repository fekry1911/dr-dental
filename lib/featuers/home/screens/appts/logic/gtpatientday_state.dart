part of 'gtpatientday_cubit.dart';

@immutable
sealed class GetpatientdayState extends Equatable {
  const GetpatientdayState();

  @override
  List<Object?> get props => [];
}

final class GtpatientdayInitial extends GetpatientdayState {}

final class AddPatientSelectionChanged extends GetpatientdayState {}

final class ChangeDate extends GetpatientdayState {
  final DateTime? date;
  const ChangeDate(this.date);
  @override
  List<Object?> get props => [date];
}

final class GtpatientdayLoading extends GetpatientdayState {}

final class GtpatientdaySuccess extends GetpatientdayState {
  final List<PatientModel> patients;
  const GtpatientdaySuccess(this.patients);

  @override
  List<Object?> get props => [patients];
}

final class GtpatientdayFailure extends GetpatientdayState {
  final String error;
  const GtpatientdayFailure(this.error);

  @override
  List<Object?> get props => [error];
}
