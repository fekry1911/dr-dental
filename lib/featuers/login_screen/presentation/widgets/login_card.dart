import 'dart:ui';

import 'package:dr_dental/core/app_export.dart';
import 'package:dr_dental/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/text_style_helper.dart';
import '../../../../widgets/awesome_loading.dart';
import '../../../../widgets/custom_image_view.dart';
import '../../logic/login_cubit.dart';

Widget buildLoginCard(BuildContext context, LoginCubit cubit) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.h),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(26),
          blurRadius: 10.h,
          offset: Offset(0, 4.h),
        ),
      ],
    ),
    padding: EdgeInsets.all(24.h),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildSecurityIcon(),
          SizedBox(height: 24.h),
          buildWelcomeText(),
          SizedBox(height: 32.h),
          buildTabNavigation(context),
          SizedBox(height: 24.h),
          buildLoginForm(context, cubit),

        ],
      ),
    ),
  );
}

Widget buildSecurityIcon() {
  return Container(
    width: 64.h,
    height: 64.h,
    decoration: BoxDecoration(
      color: Color(0xFFF0F9FF),
      borderRadius: BorderRadius.circular(32.h),
    ),
    child: Center(
      child: CustomImageView(
        imagePath: ImageConstant.imgI,
        height: 32.h,
        width: 32.h,
      ),
    ),
  );
}

Widget buildWelcomeText() {
  return Column(
    children: [
      Text(
        'Welcome Back',
        style: TextStyleHelper.instance.title24BoldPoppins
            .copyWith(color: Color(0xFF1F2937)),
      ),
      SizedBox(height: 8.h),
      Text(
        'Sign in to continue to your account',
        style: TextStyleHelper.instance.body14Poppins
            .copyWith(color: Color(0xFF6B7280)),
      ),
    ],
  );
}

Widget buildTabNavigation(BuildContext context) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {

              },
              child: Container(
                padding: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color:Color(0xFF2563EB),

                      width: 2.h,
                    ),
                  ),
                ),
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyleHelper.instance.body14MediumPoppins
                      .copyWith(
                      color:Color(0xFF2563EB)

                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      Container(
        height: 1.h,
        color: Color(0xFFE5E7EB),
      ),
    ],
  );
}

Widget buildLoginForm(BuildContext context, LoginCubit cubit) {
  return Column(
    children: [
      buildEmailField(context, cubit),
      SizedBox(height: 16.h),
      buildPasswordField(context, cubit),
      SizedBox(height: 16.h),
      buildForgotPassword(context),
      SizedBox(height: 16.h),
      buildLoginButton(context, cubit),
    ],
  );
}

Widget buildEmailField(BuildContext context, LoginCubit cubit) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Email', style: TextStyleHelper.instance.body14MediumPoppins.copyWith(color: Color(0xFF374151))),
      SizedBox(height: 8.h),
      TextFormField(
        controller: cubit.emailController,
        keyboardType: TextInputType.emailAddress,
        // ...
        decoration: InputDecoration(
          hintText: 'example@email.com',
          hintStyle: TextStyleHelper.instance.bodyPoppins
              .copyWith(color: Color(0xFF9CA3AF)),
          filled: true,
          fillColor: Color(0xFFF9FAFB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(color: Color(0xFFD1D5DB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(color: Color(0xFFD1D5DB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2.h),
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
        ),
        style: TextStyleHelper.instance.bodyPoppins
            .copyWith(color: Color(0xFF9CA3AF)),

      ),

    ],
  );
}

Widget buildPasswordField(BuildContext context, LoginCubit cubit) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Password', style: TextStyleHelper.instance.body14MediumPoppins.copyWith(color: Color(0xFF374151))),
      SizedBox(height: 8.h),
      TextFormField(
        controller: cubit.passwordController,
        obscureText: cubit.isSecure,
        decoration: InputDecoration(
          hintText: '••••••••',
          hintStyle: TextStyleHelper.instance.bodyPoppins
              .copyWith(color: Color(0xFF9CA3AF)),
          filled: true,
          fillColor: Color(0xFFF9FAFB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(color: Color(0xFFD1D5DB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(color: Color(0xFFD1D5DB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2.h),
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
          suffixIcon: GestureDetector(
            onTap: () {
              context.read<LoginCubit>().toggleSecure();
            },
            child: Icon(cubit.isSecure?Icons.visibility:Icons.visibility_off,size: 18,),
          ),
        ),
        style: TextStyleHelper.instance.bodyPoppins
            .copyWith(color: Color(0xFF9CA3AF)),
      ),

    ],
  );
}

Widget buildForgotPassword(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: GestureDetector(
      onTap: () {
      },
      child: Text(
        'Forgot password?',
        style: TextStyleHelper.instance.body14MediumPoppins
            .copyWith(color: Color(0xFF2563EB)),
      ),
    ),
  );
}

Widget buildLoginButton(BuildContext context, LoginCubit cubit) {
  return SizedBox(
    width: double.infinity,
    height: 60.h,
    child:cubit.state is LoginLoading?LoadingWidget(): ElevatedButton(
      onPressed: (){
        cubit.logIN();

      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF2563EB),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
      ),
      child:Text(
      'Login',
      style: TextStyleHelper.instance.title16MediumPoppins
          .copyWith(color: Colors.white),
    ),
    ),
  );
}

Widget buildDivider() {
  return Text(
    'or continue with',
    style: TextStyleHelper.instance.body14Poppins
        .copyWith(color: Color(0xFF9CA3AF)),
  );
}

Widget buildSocialLoginButtons(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: buildSocialButton(
          context,
          'Google',
          ImageConstant.img,
              () {
          },
        ),
      ),
      SizedBox(width: 12.h),
      Expanded(
        child: buildSocialButton(
          context,
          'Facebook',
          ImageConstant.img2,
              () {
          },
        ),
      ),
    ],
  );
}

Widget buildSocialButton(
    BuildContext context, String text, String iconPath, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFD1D5DB)),
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: iconPath,
            height: 20.h,
            width: 20.h,
          ),
          SizedBox(width: 8.h),
          Text(
            text,
            style: TextStyleHelper.instance.body14MediumPoppins
                .copyWith(color: Color(0xFF374151)),
          ),
        ],
      ),
    ),
  );
}

