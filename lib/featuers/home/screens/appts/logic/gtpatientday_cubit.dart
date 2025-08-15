import 'package:bloc/bloc.dart';
import 'package:dr_dental/core/app_export.dart';
import 'package:meta/meta.dart';

part 'gtpatientday_state.dart';

class GetpatientdayCubit extends Cubit<GetpatientdayState> {
  GetpatientdayCubit() : super(GtpatientdayInitial());

}
