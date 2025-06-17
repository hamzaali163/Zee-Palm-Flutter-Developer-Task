import 'package:assesment_project/components/reusable_text_field.dart';
import 'package:assesment_project/components/round_button.dart';
import 'package:assesment_project/providers/homevm.dart';
import 'package:assesment_project/utils/generalutils.dart';
import 'package:assesment_project/utils/routenames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Homevm>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text('Upload Video'),
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, RouteNames.signupscreen);
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),

          body: Padding(
            padding: EdgeInsets.only(top: 70, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Video title", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                CustomTextFormField(controller: vm.titlecontroller, labelText: 'Enter title'),
                SizedBox(height: 30),

                InkWell(
                  onTap: () {
                    if (vm.titlecontroller.text.isNotEmpty) {
                      vm.pickAndUploadVideo(context);
                    } else {
                      Generalutils().showErrorSnackBar(context, 'Choose a video title');
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey),
                    child: Center(
                      child: Text('Select Video from phone', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                vm.filechosen == true
                    ? LinearProgressIndicator(value: vm.uploadProgress, minHeight: 10, color: Colors.green)
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
