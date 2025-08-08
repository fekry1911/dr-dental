import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_dental/featuers/login_screen/data/rebo/login_rebo.dart';
import 'package:dr_dental/featuers/login_screen/data/rebo/login_rebo_impl.dart';
import 'package:dr_dental/featuers/login_screen/logic/login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  //rebo
  sl.registerLazySingleton<LoginRebo>(() => LoginReboImpl(sl()));
  // cubits
  sl.registerFactory<LoginCubit>(()=>LoginCubit(sl<LoginRebo>()));
}
