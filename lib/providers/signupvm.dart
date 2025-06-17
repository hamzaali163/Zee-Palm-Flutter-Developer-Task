import 'package:assesment_project/utils/generalutils.dart';
import 'package:assesment_project/utils/routenames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signupvm with ChangeNotifier {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;

  Future signup(context) async {
    try {
      auth.createUserWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((
        value,
      ) async {
        FirebaseFirestore.instance.collection('user data').doc(auth.currentUser!.uid).set({
          'id': auth.currentUser!.uid,
          'name': namecontroller.text.toString(),
          'email': emailcontroller.text,
        });
        Generalutils().showSuccessSnackBar(context, 'Sign up successful');
        emailcontroller.clear();
        passwordcontroller.clear();
        Navigator.pushNamed(context, RouteNames.bottomnab);
      });
    } on FirebaseAuthException catch (e) {
      Generalutils().showErrorSnackBar(context, e.toString());
    }
  }
}
