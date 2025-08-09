import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dr_dental/core/helpers/extentions/context_extention.dart';
import 'package:dr_dental/featuers/login_screen/logic/login_cubit.dart';
import 'package:dr_dental/featuers/login_screen/presentation/widgets/login_card.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../core/const/const.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFail) {
          CherryToast.error(
            description: Text(
              (state.error).split('] ').last,
              style: TextStyle(color: Colors.black),
            ),
            toastDuration: Duration(milliseconds: 3000),
            toastPosition: Position.bottom,

            animationType: AnimationType.fromRight,

            animationDuration: Duration(milliseconds: 1000),

            autoDismiss: true,
          ).show(context);
        }
        if (state is LoginSucc) {
          CherryToast.success(
            title: Text(
              "Login  successfully",
              style: TextStyle(color: Colors.black),
            ),
          ).show(context);
          context.pushNamed(liquidBottomNavExample);
        }
      },
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();
        return Scaffold(
          backgroundColor: Color(0xFFF3F4F6),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: Container(
                width: double.infinity,
                child: buildLoginCard(context, cubit),
              ),
            ),
          ),
        );
      },
    );
  }
}
