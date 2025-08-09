import 'package:bloc/bloc.dart';
import 'package:dr_dental/featuers/login_screen/data/models/login_model.dart';
import 'package:dr_dental/featuers/login_screen/data/rebo/login_rebo.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../core/helpers/cache_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRebo) : super(LoginInitial());
  LoginRebo loginRebo;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isSecure = true;

  void toggleSecure() {
    isSecure = !isSecure;
    print(isSecure);
    emit(ToggleSecure(isSecure: isSecure));
  }
  Future<void> logIN() async {
    emit(LoginLoading());
    try {
      await loginRebo
          .signInWithEmail(
        LoginModel(
          email: emailController.text,
          password: passwordController.text,
        ),
      )
          .then((value) async {
            print("done");
        await CacheHelper.putString(key: "uid", value: value.user!.uid);
        emit(LoginSucc());

      });
    } catch (e) {
      print(e.toString());
      print("sdhfdsjdfsdjfjksdjfdsffsdf");

      emit(LoginFail(error: e.toString()));
    }
  }

}
