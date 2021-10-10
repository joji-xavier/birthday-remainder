import 'package:birthday_reminder/controllers/services/notification_services.dart';
import 'package:birthday_reminder/view/screen/full_details.dart';
import 'package:birthday_reminder/view/widget/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class BithDayOfTheDay extends StatelessWidget {
  final String date;
  final NotifyHelper notifyHelper = NotifyHelper();
  BithDayOfTheDay({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: FutureBuilder(
        
          future: Future.value(FirebaseAuth.instance.currentUser),
          builder: (context, futureSnapShot) {
            if (futureSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('user').snapshots(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final userDocs = userSnapshot.data!.docs;
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final User? user = auth.currentUser;
                   final uid = user!.uid;
                   final box =GetStorage();
                  return ListView.builder(
                    itemCount: userDocs.length,
                    itemBuilder: (context, index) {
                      String username = userDocs[index]["user_name"];
                      String dateOfBirth = userDocs[index]["Date_of_birth"];
                      String firstname = userDocs[index]["First_name"];
                      String lastname = userDocs[index]["Last_name"];
                      String email = userDocs[index]["Email"];
                      String phone = userDocs[index]["Phone_number"];
                      String address = userDocs[index]["Address"];
                      String state = userDocs[index]["State"];
                      String city = userDocs[index]["City"];
                      String pin = userDocs[index]["Pin"];
                      String url = userDocs[index]["image_url"];
                      String userid = userDocs[index]['userId'];
                      String today =
                          DateFormat('dd:MM:yyyy').format(DateTime.now());
                      String day = today.split(":")[0];
                      String month = today.split(":")[1];
                      String birthDay = dateOfBirth.split(":")[0];
                      String birthMonth = dateOfBirth.split(":")[1];
                      String selectedDay = date.split(":")[0];
                      String selectedMonth = date.split(":")[1];
                     
                      if (day == birthDay && month == birthMonth) {
                        notifyHelper.scheduledNotification(
                            note: "wish him a Happy Birthday",
                            title: "today is $username's Birthday");
                      }
                      if(uid==userid){
                        box.write('username', username);
                        box.write('userImage', url);
                      }
                      if (userid!=uid){
                      if (selectedDay == birthDay &&
                          selectedMonth == birthMonth) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(FullDeatiles(
                                    address: address,
                                    city: city,
                                    date: dateOfBirth,
                                    email: email,
                                    firstname: firstname,
                                    lastname: lastname,
                                    phone: phone,
                                    pin: pin,
                                    state: state,
                                    url: url,
                                    username: username));
                              },
                              child: Container(
                                height: 100,
                                margin: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20,),
                                decoration: BoxDecoration(
                                    color: primaryClr,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Hero(
                                      tag:  username,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(url),
                                        radius: 40,
                                        backgroundColor: white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          username,
                                          style: headingTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          dateOfBirth,
                                          style: titleTextStle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }
                      return const SizedBox();
                    },
                  );
                });
          }),
    );
  }
}
