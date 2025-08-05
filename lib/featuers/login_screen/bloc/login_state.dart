part of 'login_bloc.dart';

class LoginState extends Equatable {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final LoginModel? loginModel;
  final bool? isLoading;
  final bool? showSuccessMessage;
  final bool? showErrorMessage;

  const LoginState({
    this.emailController,
    this.passwordController,
    this.loginModel,
    this.isLoading,
    this.showSuccessMessage,
    this.showErrorMessage,
  });

  @override
  List<Object?> get props => [
        emailController,
        passwordController,
        loginModel,
        isLoading,
        showSuccessMessage,
        showErrorMessage,
      ];

  LoginState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    LoginModel? loginModel,
    bool? isLoading,
    bool? showSuccessMessage,
    bool? showErrorMessage,
  }) {
    return LoginState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      loginModel: loginModel ?? this.loginModel,
      isLoading: isLoading ?? this.isLoading,
      showSuccessMessage: showSuccessMessage ?? this.showSuccessMessage,
      showErrorMessage: showErrorMessage ?? this.showErrorMessage,
    );
  }
}
