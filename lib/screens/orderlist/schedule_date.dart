import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class ScheduleDate extends StatefulWidget {
  const ScheduleDate({Key? key}) : super(key: key);

  @override
  State<ScheduleDate> createState() => _ScheduleDateState();
}

class _ScheduleDateState extends State<ScheduleDate> {
  double? _height;
  double? _width;

  String? _setTime, _setDate;

  String? _hour, _minute, _time;

  String? dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = '${_hour!} : ${_minute!}';
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h,),
        Text("Schedule Date & Time",style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 16.sp),),
        Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                width: 20.h,
                height: 5.h,
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: TextFormField(
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _dateController,
                  onSaved: (val) {
                    _setDate = val;
                  },
                  decoration:  InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/icons/pick.png',height: 2.h,),
                    ),
                    labelText: 'Pickup Date',
                      labelStyle: const TextStyle(color: Colors.black),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      // disabledBorder:
                      // UnderlineInputBorder(borderSide: BorderSide.none),
                      // labelText: 'Time',
                      contentPadding: const EdgeInsets.only(top: 0.0)),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _selectTime(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                width: 20.h,
                height: 5.h,
                alignment: Alignment.center,
                child: TextFormField(
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                  onSaved: (val) {
                    _setTime = val;
                  },
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _timeController,
                  decoration:  InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/pick.png',height: 2.h,),
                      ),
                      labelText: 'Pickup Time',
                      labelStyle: const TextStyle(color: Colors.black),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      // labelText: 'Time',
                      contentPadding: EdgeInsets.all(5)),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                width: 20.h,
                height: 5.h,
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: TextFormField(
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _dateController,
                  onSaved: (val) {
                    _setDate = val;
                  },
                  decoration:  InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/deliver.png',height: 2.h,),
                      ),
                      labelText: 'Deliver Date',
                      labelStyle: const TextStyle(color: Colors.black),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      // disabledBorder:
                      // UnderlineInputBorder(borderSide: BorderSide.none),
                      // labelText: 'Time',
                      contentPadding: const EdgeInsets.only(top: 0.0)),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _selectTime(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                width: 20.h,
                height: 5.h,
                alignment: Alignment.center,
                child: TextFormField(
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                  onSaved: (val) {
                    _setTime = val;
                  },
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _timeController,
                  decoration:  InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/deliver.png',height: 2.h,),
                      ),
                      labelText: 'Deliver Time',
                      labelStyle: const TextStyle(color: Colors.black),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      // labelText: 'Time',
                      contentPadding: const EdgeInsets.all(5)),
                ),
              ),
            ),
          ],
        ),





      ],
    );
  }
}
