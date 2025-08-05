import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../core/theme/text_style_helper.dart';
import '../../widgets/custom_image_view.dart';
import './bloc/login_bloc.dart';
import 'models/login_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(LoginState(
        loginModel: LoginModel(),
      ))
        ..add(LoginInitialEvent()),
      child: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.showSuccessMessage ?? false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login successful')),
            );
          }
          if (state.showErrorMessage ?? false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login failed')),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(maxWidth: 400.h),
                child: _buildLoginCard(context, state),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context, LoginState state) {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSecurityIcon(),
          SizedBox(height: 24.h),
          _buildWelcomeText(),
          SizedBox(height: 32.h),
          _buildTabNavigation(context, state),
          SizedBox(height: 24.h),
          _buildLoginForm(context, state),
          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),
          _buildSocialLoginButtons(context),
        ],
      ),
    );
  }

  Widget _buildSecurityIcon() {
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

  Widget _buildWelcomeText() {
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

  Widget _buildTabNavigation(BuildContext context, LoginState state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context
                      .read<LoginBloc>()
                      .add(TabSwitchEvent(isLoginTab: true));
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: (state.loginModel?.isLoginTab ?? true)
                            ? Color(0xFF2563EB)
                            : Colors.transparent,
                        width: 2.h,
                      ),
                    ),
                  ),
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyleHelper.instance.body14MediumPoppins
                        .copyWith(
                            color: (state.loginModel?.isLoginTab ?? true)
                                ? Color(0xFF2563EB)
                                : Color(0xFF6B7280)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context
                      .read<LoginBloc>()
                      .add(TabSwitchEvent(isLoginTab: false));
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: !(state.loginModel?.isLoginTab ?? true)
                            ? Color(0xFF2563EB)
                            : Colors.transparent,
                        width: 2.h,
                      ),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyleHelper.instance.body14MediumPoppins
                        .copyWith(
                            color: !(state.loginModel?.isLoginTab ?? true)
                                ? Color(0xFF2563EB)
                                : Color(0xFF6B7280)),
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

  Widget _buildLoginForm(BuildContext context, LoginState state) {
    return Column(
      children: [
        _buildEmailField(context, state),
        SizedBox(height: 16.h),
        _buildPasswordField(context, state),
        SizedBox(height: 16.h),
        _buildForgotPassword(context),
        SizedBox(height: 16.h),
        _buildLoginButton(context, state),
      ],
    );
  }

  Widget _buildEmailField(BuildContext context, LoginState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyleHelper.instance.body14MediumPoppins
              .copyWith(color: Color(0xFF374151)),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: state.emailController,
          keyboardType: TextInputType.emailAddress,
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
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChangedEvent(email: value));
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context, LoginState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyleHelper.instance.body14MediumPoppins
              .copyWith(color: Color(0xFF374151)),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: state.passwordController,
          obscureText: !(state.loginModel?.isPasswordVisible ?? false),
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
                context.read<LoginBloc>().add(TogglePasswordVisibilityEvent());
              },
              child: Padding(
                padding: EdgeInsets.all(12.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgDivBlueGray30050x30,
                  height: 24.h,
                  width: 24.h,
                ),
              ),
            ),
          ),
          style: TextStyleHelper.instance.bodyPoppins
              .copyWith(color: Color(0xFF9CA3AF)),
          onChanged: (value) {
            context
                .read<LoginBloc>()
                .add(PasswordChangedEvent(password: value));
          },
        ),
      ],
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          context.read<LoginBloc>().add(ForgotPasswordEvent());
        },
        child: Text(
          'Forgot password?',
          style: TextStyleHelper.instance.body14MediumPoppins
              .copyWith(color: Color(0xFF2563EB)),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, LoginState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (state.isLoading ?? false)
            ? null
            : () {
                context.read<LoginBloc>().add(LoginButtonPressedEvent());
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2563EB),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
        ),
        child: (state.isLoading ?? false)
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.h,
                ),
              )
            : Text(
                'Login',
                style: TextStyleHelper.instance.title16MediumPoppins
                    .copyWith(color: Colors.white),
              ),
      ),
    );
  }

  Widget _buildDivider() {
    return Text(
      'or continue with',
      style: TextStyleHelper.instance.body14Poppins
          .copyWith(color: Color(0xFF9CA3AF)),
    );
  }

  Widget _buildSocialLoginButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildSocialButton(
            context,
            'Google',
            ImageConstant.img,
            () {
              context.read<LoginBloc>().add(GoogleLoginEvent());
            },
          ),
        ),
        SizedBox(width: 12.h),
        Expanded(
          child: _buildSocialButton(
            context,
            'Facebook',
            ImageConstant.img2,
            () {
              context.read<LoginBloc>().add(FacebookLoginEvent());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
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
}
