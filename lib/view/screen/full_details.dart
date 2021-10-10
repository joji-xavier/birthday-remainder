import 'package:birthday_reminder/view/widget/theme.dart';
import 'package:flutter/material.dart';

class FullDeatiles extends StatelessWidget {
  
  String firstname;
  String lastname;
  String username;
  String email;
  String phone;
  String state;
  String city;
  String date;
  String pin;
  String url;
  String address;
  FullDeatiles(
      {Key? key,
      required this.firstname,
      required this.lastname,
      required this.username,
      required this.email,
      required this.phone,
      required this.state,
      required this.city,
      required this.date,
      required this.address,
      required this.pin,
      required this.url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: [
                      Hero(
                        tag: username,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(url),
                         
                        ),
                      ),
                      Text(email,style: headingTextStyle,),
                      const SizedBox(
                        height: 20,
                      ),
                      row(head: 'First Name ', info: firstname),
                      const SizedBox(
                        height: 10,
                      ),
                      row(head: 'Last Name ', info: lastname),
                      const SizedBox(
                        height: 10,
                      ),
                      row(head: 'User Name  ', info: username),
                      const SizedBox(
                        height: 10,
                      ),
                      row(head: 'Date Of Birth  ', info: date),
                      const SizedBox(
                        height: 10,
                      ),
                      row(head: 'address  ', info: address),
                       const SizedBox(
                        height: 10,
                       ),
                      row(head: 'Phone No  ', info: phone),
                      const SizedBox(
                        height: 10,
                      ),
                      row(head: 'State  ', info: state),
                      const SizedBox(
                        height: 10,
                      ),
                      row(head: 'City  ', info: city),
                      const SizedBox(
                        height: 10,
                      ),
                      row(head: 'Pin   ', info: pin),
                      const SizedBox(
                        height: 10,
                      ),
                      // Text(address,style: subTitleTextStle,)
                    ],
                  ),
                ),
                color: primaryClr,elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget row({required String head, required String info}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            head,
            style: subHeadingTextStyle,
          ),
          Text(info,style: titleTextStle,),
        ],
      ),
    );
  }
}
