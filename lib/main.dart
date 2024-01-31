import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodie/views/auth-ui/splash-screen.dart';
import 'package:foodie/views/user-panel/main_screens.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );
  //mobile auto rotate setting
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()),
  );
  runApp(const MyApp(

  ));

}

class MyApp extends StatelessWidget {


  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User? user;
    void initState(){
      user=FirebaseAuth.instance.currentUser;
      print(user?.uid.toString());
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodies',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
//user == null?const MainScreens():