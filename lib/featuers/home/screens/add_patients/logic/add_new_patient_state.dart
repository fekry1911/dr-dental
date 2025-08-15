part of 'add_new_patient_cubit.dart';

@immutable
sealed class AddNewPatientState {}

final class AddNewPatientInitial extends AddNewPatientState {}
final class AddPatientLoading extends AddNewPatientState {}
final class AddPatientSuccess extends AddNewPatientState {}
final class AddPatientFailure extends AddNewPatientState {}
final class StudentGenderChanged extends AddNewPatientState {}



