import 'package:assesment_project/utils/generalutils.dart';
import 'package:assesment_project/utils/routenames.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginVm with ChangeNotifier {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  void setloadingvalue(bool loadvalue) {
    loading = loadvalue;
    notifyListeners();
  }

  Future login(context) async {
    setloadingvalue(true);
    try {
      await auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((
        value,
      ) {
        Generalutils().showSuccessSnackBar(context, 'Success');
        emailcontroller.clear();
        passwordcontroller.clear();
        Navigator.pushNamed(context, RouteNames.bottomnab);
      });
      setloadingvalue(false);
    } on FirebaseAuthException catch (e) {
      setloadingvalue(false);
      Generalutils().showErrorSnackBar(context, e.toString());
    }
  }
}
