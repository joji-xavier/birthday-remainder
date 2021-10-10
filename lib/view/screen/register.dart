import 'dart:io';
import 'package:birthday_reminder/view/screen/user_screen.dart';
import 'package:birthday_reminder/view/widget/button.dart';
import 'package:birthday_reminder/view/widget/image_selector.dart';
import 'package:birthday_reminder/view/widget/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      // ),
      body: UserInfo(),
    );
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _dateofbirthController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? formattedDate;

  File? _userimage;

  void _pickedImage(File image) {
    _userimage = image;
  }

  bool isLoading = false;

  String _selectedDate = DateFormat('dd:MM:yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ImageSelector(_pickedImage),
              InputField(
                controller: _firstnameController,
                hint: 'John',
                title: 'First Name',
              ),
              InputField(
                controller: _lastnameController,
                hint: 'Honai',
                title: 'Last Name',
              ),
              InputField(
                controller: _usernameController,
                hint: 'John Honai',
                title: 'User Name',
              ),
              InputField(
                controller: _emailController,
                hint: 'abcd@gmail.com',
                title: 'Email',
                keybordType: TextInputType.emailAddress,
              ),
              InputField(
                controller: _passwordController,
                hint: '*******',
                title: 'Password',
                hide: true,
              ),
              InputField(
                controller: _phonenumberController,
                hint: '123456789',
                title: 'Phone Number',
                keybordType: TextInputType.number,
              ),
              InputField(
                controller: _addressController,
                hint: 'Your Address',
                title: 'Address',
              ),
              InputField(
                controller: _stateController,
                hint: 'Kerala',
                title: 'State',
              ),
              InputField(
                controller: _cityController,
                hint: 'Kochi',
                title: 'City',
              ),
              InputField(
                controller: _pinController,
                hint: '688007',
                title: 'Pin',
                keybordType: TextInputType.number,
              ),
              InputField(
                controller: _dateofbirthController,
                hint: _selectedDate,
                title: 'Date of birth',
                widget: IconButton(
                  icon: (const Icon(
                    Icons.date_range,
                    color: Colors.grey,
                  )),
                  onPressed: () {
                    _dateSelector();
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (isLoading) const CircularProgressIndicator(),
              if (!isLoading)
                Button(
                    onTap: () async {
                      if (_userimage == null) {
                        Get.snackbar(
                            'user image missing', 'pleace select a user image',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                        return;
                      }
                      if (_phonenumberController.text.isEmpty ||
                          _firstnameController.text.isEmpty ||
                          _lastnameController.text.isEmpty ||
                          _usernameController.text.isEmpty ||
                          _addressController.text.isEmpty ||
                          _stateController.text.isEmpty ||
                          _cityController.text.isEmpty ||
                          _pinController.text.isEmpty ||
                          _userimage == null) {
                        Get.snackbar('Required', 'All fields',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      } else {
                        try {
                          setState(() {
                            isLoading = true;
                          });

                          final authresult =
                              await _auth.createUserWithEmailAndPassword(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim());
                          final user = FirebaseAuth.instance.currentUser;
                          final ref = FirebaseStorage.instance
                              .ref()
                              .child('user_image')
                              .child(authresult.user!.uid + '.jpg');
                          await ref.putFile(_userimage!);
                          final url = await ref.getDownloadURL();

                          await FirebaseFirestore.instance
                              .collection('user')
                              .doc(authresult.user!.uid)
                              .set({
                            "First_name": _firstnameController.text,
                            "Last_name": _lastnameController.text,
                            'user_name': _usernameController.text,
                            'Email': _emailController.text,
                            'Password': _passwordController.text,
                            "Phone_number": _phonenumberController.text,
                            "Date_of_birth": formattedDate,
                            "Address": _addressController.text,
                            "State": _stateController.text,
                            "City": _cityController.text,
                            "Pin": _pinController.text,
                            "image_url": url,
                            "time_stamp": Timestamp.now(),
                            "userId": user!.uid,
                          });

                          Get.to(const UserScreen());
                        } on FirebaseException catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          Get.snackbar('Error', e.toString());
                        }
                      }
                    },
                    label: 'Register')
            ],
          ),
        ),
      ),
    );
  }

  _dateSelector() async {
    final DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (_pickedDate != null) {
      formattedDate = DateFormat('dd:MM:yyyy').format(_pickedDate);
      setState(() {
        _selectedDate = formattedDate!;
      });
    }
  }
}
