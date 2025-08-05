import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';

class LoginModel extends Equatable {
  String? email;
  String? password;
  bool? isLoginTab;
  bool? isPasswordVisible;

  LoginModel({
    this.email,
    this.password,
    this.isLoginTab,
    this.isPasswordVisible,
  }) {
    email = email ?? '';
    password = password ?? '';
    isLoginTab = isLoginTab ?? true;
    isPasswordVisible = isPasswordVisible ?? false;
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isLoginTab,
        isPasswordVisible,
      ];

  LoginModel copyWith({
    String? email,
    String? password,
    bool? isLoginTab,
    bool? isPasswordVisible,
  }) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoginTab: isLoginTab ?? this.isLoginTab,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
