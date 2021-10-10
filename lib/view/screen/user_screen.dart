import 'package:birthday_reminder/controllers/services/notification_services.dart';
import 'package:birthday_reminder/view/screen/birthday_of_the_day.dart';
import 'package:birthday_reminder/view/widget/drawer.dart';
import 'package:birthday_reminder/view/widget/theme.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:google_fonts/google_fonts.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override

  NotifyHelper notifyHelper = NotifyHelper();
  @override
  void initState() {
    super.initState();
    notifyHelper.initializeNotification();
    
  }

  DateTime _selectedDate = DateTime.now();
  String? formattedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context){
          return GestureDetector(onTap: ()=>Scaffold.of(context).openDrawer(),
          child: Icon(Icons.menu,color: Get.isDarkMode?Colors.white:Colors.black,));
        }),
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        title: const Text(''),
      ),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Text(
                'Today',
                style: headingTextStyle,
              ),
            ],
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: DatePicker(
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: primaryClr,
                  selectedTextColor: Colors.white,
                  dateTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  monthTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  dayTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  onDateChange: (date) {
                    _selectedDate = date;
                    formattedDate =
                        DateFormat('dd:MM:yyyy').format(_selectedDate);
                    Get.to(BithDayOfTheDay(
                      date: formattedDate!,
                    ));
                  },
                ),
              ),
            ],
          ),
           Expanded(child: BithDayOfTheDay(date:  DateFormat('dd:MM:yyyy').format(_selectedDate),),)
           
        ],
      ),
    );
  }
}

