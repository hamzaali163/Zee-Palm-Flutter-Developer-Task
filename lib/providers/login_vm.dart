import 'package:assesment_project/utils/generalutils.dart';
import 'package:assesment_project/utils/routenames.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginVm with ChangeNotifier {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  Future login(context) async {
    try {
      await auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((
        value,
      ) {
        Generalutils().showSuccessSnackBar(context, 'Success');
        emailcontroller.clear();
        passwordcontroller.clear();
        Navigator.pushNamed(context, RouteNames.bottomnab);
      });
    } on FirebaseAuthException catch (e) {
      Generalutils().showErrorSnackBar(context, e.toString());
    }
  }
}
