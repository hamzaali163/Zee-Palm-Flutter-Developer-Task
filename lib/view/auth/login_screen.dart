import 'package:assesment_project/components/reusable_text_field.dart';
import 'package:assesment_project/components/round_button.dart';
import 'package:assesment_project/providers/login_vm.dart';
import 'package:assesment_project/utils/generalutils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginVm>(
      builder: (context, vm, child) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 100, left: 13, right: 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),

                Text("Login to continue", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 25),
                Text("Enter your email and password to login", style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),

                CustomTextFormField(controller: vm.emailcontroller, labelText: "Email"),
                SizedBox(height: 20),
                Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),

                CustomTextFormField(controller: vm.passwordcontroller, labelText: "Password"),
                SizedBox(height: 30),
                RoundButton(
                  title: 'Login',
                  onPressed: () {
                    if (vm.emailcontroller.text.isNotEmpty && vm.passwordcontroller.text.isNotEmpty) {
                      vm.login(context);
                    } else {
                      Generalutils().showErrorSnackBar(context, "Enter email and password");
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
