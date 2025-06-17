import 'package:assesment_project/components/reusable_text_field.dart';
import 'package:assesment_project/components/round_button.dart';
import 'package:assesment_project/providers/signupvm.dart';
import 'package:assesment_project/utils/generalutils.dart';
import 'package:assesment_project/utils/routenames.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Signupvm>(
        builder: (context, vm, child) {
          return Padding(
            padding: EdgeInsets.only(top: 70, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),

                Text("Sign up to continue", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 25),
                Text("Enter your email and password to login", style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Text("Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),

                CustomTextFormField(controller: vm.namecontroller, labelText: "Name"),
                SizedBox(height: 20),

                Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),

                CustomTextFormField(controller: vm.emailcontroller, labelText: "Email"),
                SizedBox(height: 20),
                Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),

                CustomTextFormField(controller: vm.passwordcontroller, labelText: "Password"),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Text('Already have an account'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.loginscreen);
                        },
                        child: Text("Login"),
                      ),
                    ],
                  ),
                ),
                RoundButton(
                  isLoading: vm.loading,
                  title: 'Sign Up',
                  onPressed: () {
                    if (vm.emailcontroller.text.isNotEmpty && vm.passwordcontroller.text.isNotEmpty) {
                      vm.signup(context);
                    } else {
                      Generalutils().showErrorSnackBar(context, "Enter email and password");
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
