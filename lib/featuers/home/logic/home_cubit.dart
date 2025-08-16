import 'package:flutter/cupertino.dart';

import '../../../core/app_export.dart';
import '../../../core/di/di.dart';
import '../screens/add_patients/logic/add_new_patient_cubit.dart';
import '../screens/add_patients/presentation/add_patient.dart';
import '../screens/appts/logic/gtpatientday_cubit.dart';
import '../screens/appts/presentation/appts_screen.dart';
import '../screens/patients/logic/add_patient_cubit.dart';
import '../screens/patients/presentation/all_patients.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  int index = 0;

  void changeIndex(int i) {
    index = i;
    print(index);
    print(screens[index]);
    emit(ChangeBottomNav(index));
  }

  List<String> titles = ["Appointments", "patients", "Add Patient"];

  List<Widget> screens = [
    BlocProvider(
      create:
          (context) =>
              sl<GetpatientdayCubit>()..getPatientsOfDay(
                "${DateTime.now()!.year}-${DateTime.now()!.month.toString().padLeft(2, '0')}-${DateTime.now()!.day.toString().padLeft(2, '0')}",
              ),
      child: AppptsScreen(),
    ),
    BlocProvider(
      create: (context) => sl<BookPatientCubit>()..getAllPatients(),
      child: AllPatients(),
    ),
    BlocProvider(
      create: (context) => sl<AddNewPatientCubit>(),
      child: AddPatientScreen(),
    ),
  ];
}
