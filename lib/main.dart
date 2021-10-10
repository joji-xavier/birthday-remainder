import 'package:birthday_reminder/controllers/services/theme_services.dart';
import 'package:birthday_reminder/view/screen/home_page.dart';
import 'package:birthday_reminder/view/screen/user_screen.dart';
import 'package:birthday_reminder/view/widget/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: AnimatedSplashScreen(
        splashTransition: SplashTransition.fadeTransition,
        duration: 8,
        splash: const Text("Welcome",style:TextStyle(color: primaryClr,fontSize: 50,fontWeight: FontWeight.w800),),
        nextScreen: 
         StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges() ,builder: (ctx, userSnapshot){
               if(userSnapshot.hasData){
                 return  const UserScreen();
               }return const HomePage();
          },),
      ),
      
    );
    
  }
}

