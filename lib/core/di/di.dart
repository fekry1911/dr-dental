import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_dental/featuers/login_screen/data/rebo/login_rebo.dart';
import 'package:dr_dental/featuers/login_screen/data/rebo/login_rebo_impl.dart';
import 'package:dr_dental/featuers/login_screen/logic/login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../featuers/home/logic/home_cubit.dart';
import '../../featuers/home/screens/add_patients/data/rebo/add_new_patient.dart';
import '../../featuers/home/screens/add_patients/data/rebo/add_new_patient_impl.dart';
import '../../featuers/home/screens/add_patients/logic/add_new_patient_cubit.dart';
import '../../featuers/home/screens/patients/data/rebo/add_patiemt/add_patient.dart';
import '../../featuers/home/screens/patients/data/rebo/add_patiemt/add_patient_impl.dart';
import '../../featuers/home/screens/patients/logic/add_patient_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  //rebo
  sl.registerLazySingleton<LoginRebo>(() => LoginReboImpl(sl()));
  sl.registerLazySingleton<BookingPatient>(() => BookingPatientImpl(sl()));
  sl.registerLazySingleton<AddNewPatient>(() => AppPatientImpl(sl()));


  // cubits
  sl.registerFactory<LoginCubit>(()=>LoginCubit(sl<LoginRebo>()));
  sl.registerFactory<HomeCubit>(()=>HomeCubit());
  sl.registerFactory<BookPatientCubit>(()=>BookPatientCubit(sl<BookingPatient>()));
  sl.registerFactory<AddNewPatientCubit>(()=>AddNewPatientCubit(sl<AddNewPatient>()));



}
