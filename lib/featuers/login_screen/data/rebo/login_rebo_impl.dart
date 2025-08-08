import 'package:dr_dental/featuers/login_screen/data/models/login_model.dart';
import 'package:dr_dental/featuers/login_screen/data/rebo/login_rebo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginReboImpl extends LoginRebo{

  FirebaseAuth firebaseAuth;
  LoginReboImpl(this.firebaseAuth);
  @override
  Future<UserCredential> signInWithEmail(LoginModel loginModel) async {
    var resposnse=await firebaseAuth.signInWithEmailAndPassword(email: loginModel.email!, password: loginModel.password!);
    return resposnse;
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();

  }
}