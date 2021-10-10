import 'package:birthday_reminder/controllers/services/theme_services.dart';
import 'package:birthday_reminder/view/screen/home_page.dart';
import 'package:birthday_reminder/view/widget/all_user_screen.dart';
import 'package:birthday_reminder/view/widget/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
final space = const SizedBox(height: 30,);
 final box = GetStorage();
 bool value = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 200,
                child: Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                       CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        backgroundImage: NetworkImage(box.read('userImage')),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        box.read('username'),
                        style: subHeadingTextStyle,
                      ),
                    ],
                  ),
                  decoration: const BoxDecoration(
                      color: primaryClr,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                )),
           space,
           items(icon: Icons.account_circle_outlined, text: 'My Account',onpress: (){Get.to( AllUserScreen(isMe: true,date:'15:15:15',));}),
            space,
            items(icon: Icons.celebration, text: "All BirthDay's", onpress: (){Get.to( AllUserScreen(isMe: false,date: '15:15:15',));}),
            space,
           
             items(icon: Get.isDarkMode?Icons.toggle_on:Icons.toggle_off, text: "Dark Mode", onpress: (){ThemeService().switchTheme(); Get.back();}),
            space,
            items(icon: Icons.logout, text: "Logout", onpress: (){signOut();}),
            space,
          ],
        ),
      ),
    );
  }

  items({required IconData icon, required String text, required VoidCallback onpress}) {

    return Row(children: [
      IconButton(onPressed: onpress, icon: Icon(icon)),
      Text(text)
    ]);
  }
   signOut()async{
   await FirebaseAuth.instance.signOut();
    Get.to(const HomePage());
  }
}
