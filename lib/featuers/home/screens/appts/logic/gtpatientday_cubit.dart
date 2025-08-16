import 'package:dr_dental/core/app_export.dart';
import 'package:meta/meta.dart';

import '../../../../../data/models/patient_model.dart';
import '../data/rebo/get_patient_day.dart';

part 'gtpatientday_state.dart';

class GetpatientdayCubit extends Cubit<GetpatientdayState> {
  final GetPatientsDay getPatientsDay;

  GetpatientdayCubit(this.getPatientsDay) : super(GtpatientdayInitial());
  DateTime currentDate = DateTime.now();
  List<PatientModel> patients = [];
  void changeDate(DateTime? date) {
    if (date != null) {
      print(date);
      currentDate = date;
      emit(ChangeDate(date));
    }
  }


  Future<void> getPatientsOfDay(String day) async {
    try {
      emit(GtpatientdayLoading());
      patients = await getPatientsDay.getPatientsOfDay(day);
      emit(GtpatientdaySuccess(patients));
    } catch (e) {
      emit(GtpatientdayFailure(e.toString()));
    }
  }
}
