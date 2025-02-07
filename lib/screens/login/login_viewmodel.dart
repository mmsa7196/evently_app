import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_c13_sun/base.dart';
import 'package:todo_c13_sun/screens/login/login_connector.dart';

class LoginViewModel extends BaseViewModel<LoginConnector> {
  Future<void> login(String email, String password) async {
    try {
      connector!.showLoadingDialog();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      connector!.goToHome();
    } on FirebaseAuthException catch (e) {
      connector!.showErrorDialog(message: "Wrong mail or password".tr());
    }
  }
}
