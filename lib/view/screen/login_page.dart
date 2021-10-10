import 'package:birthday_reminder/view/screen/user_screen.dart';
import 'package:birthday_reminder/view/widget/button.dart';
import 'package:birthday_reminder/view/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
     backgroundColor: Colors.white,
      body: UserLogin(),
    );
  }
}

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  bool isLoading = false;
  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passwordcontroller = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InputField(
            hint: 'abcd@gmail.com',
            title: 'Email',
            controller: _emailcontroller,
          ),
          InputField(
            hint: '******',
            title: 'Password',
            controller: _passwordcontroller,
            hide: true,
          ),
          const SizedBox(
            height: 50,
          ),
          if (isLoading) const CircularProgressIndicator(),
          if (!isLoading)
            Button(
                onTap: () async {
                  try {
                    setState(() {
                      isLoading = true;
                    });
                    final user = await _auth.signInWithEmailAndPassword(
                        email: _emailcontroller.text.trim(),
                        password: _passwordcontroller.text.trim());
                    Get.to(const UserScreen());

                   
                  } on FirebaseAuthException catch (e) {
                     setState(() {
                      isLoading = false;
                    });
                   Get.snackbar('Error', e.toString());
                    
                  }
                },
                label: 'Login'),
        ],
      ),
    );
  }
}
