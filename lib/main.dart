import 'package:assesment_project/providers/homevm.dart';
import 'package:assesment_project/providers/login_vm.dart';
import 'package:assesment_project/providers/signupvm.dart';
import 'package:assesment_project/utils/routenames.dart';
import 'package:assesment_project/utils/routes.dart';
import 'package:assesment_project/view/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDSuUBMeDZilB_DDWoyI0ggU5v0FvVAm3E",
        authDomain: "zeepalm-task.firebaseapp.com",
        projectId: "zeepalm-task",
        storageBucket: "zeepalm-task.firebasestorage.app",
        messagingSenderId: "460729468355",
        appId: "1:460729468355:web:06ffdee9748a2636dd6976",
        measurementId: "G-KRHM3JNPN9",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginVm()),
        ChangeNotifierProvider(create: (_) => Signupvm()),
        ChangeNotifierProvider(create: (_) => Homevm()),

        // Add more providers here
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: Generateroutes().generateroutes,

        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.signupscreen,
      ),
    );
  }
}
