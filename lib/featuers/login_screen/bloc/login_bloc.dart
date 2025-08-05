import 'package:flutter/material.dart';
import '../models/login_model.dart';
import '../../../core/app_export.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState) {
    on<LoginInitialEvent>(_onInitialize);
    on<TabSwitchEvent>(_onTabSwitch);
    on<EmailChangedEvent>(_onEmailChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<LoginButtonPressedEvent>(_onLoginButtonPressed);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<GoogleLoginEvent>(_onGoogleLogin);
    on<FacebookLoginEvent>(_onFacebookLogin);
  }

  _onInitialize(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      loginModel: LoginModel(),
    ));
  }

  _onTabSwitch(
    TabSwitchEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      loginModel: state.loginModel?.copyWith(
        isLoginTab: event.isLoginTab,
      ),
    ));
  }

  _onEmailChanged(
    EmailChangedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      loginModel: state.loginModel?.copyWith(
        email: event.email,
      ),
    ));
  }

  _onPasswordChanged(
    PasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      loginModel: state.loginModel?.copyWith(
        password: event.password,
      ),
    ));
  }

  _onTogglePasswordVisibility(
    TogglePasswordVisibilityEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      loginModel: state.loginModel?.copyWith(
        isPasswordVisible: !(state.loginModel?.isPasswordVisible ?? false),
      ),
    ));
  }

  _onLoginButtonPressed(
    LoginButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Simulate login process
    await Future.delayed(Duration(seconds: 2));

    // Validate credentials
    String email = state.loginModel?.email ?? '';
    String password = state.loginModel?.password ?? '';

    if (email.isNotEmpty && password.isNotEmpty) {
      emit(state.copyWith(
        isLoading: false,
        showSuccessMessage: true,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        showErrorMessage: true,
      ));
    }
  }

  _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    // Handle forgot password logic
  }

  _onGoogleLogin(
    GoogleLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Simulate Google login
    await Future.delayed(Duration(seconds: 1));

    emit(state.copyWith(
      isLoading: false,
      showSuccessMessage: true,
    ));
  }

  _onFacebookLogin(
    FacebookLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Simulate Facebook login
    await Future.delayed(Duration(seconds: 1));

    emit(state.copyWith(
      isLoading: false,
      showSuccessMessage: true,
    ));
  }
}
