import 'package:dr_dental/featuers/login_screen/data/models/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRebo{
  Future<UserCredential> signInWithEmail(LoginModel loginModel);

  Future<void> signOut();

}