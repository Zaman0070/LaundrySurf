import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:laundry_app/provider/order_provider.dart';
import 'package:laundry_app/screens/orderlist/pickup_address.dart';
import 'package:laundry_app/services/firbaseservice.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widget/add_images.dart';
import '../home/main_screen.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({Key? key}) : super(key: key);

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> with TickerProviderStateMixin {
  double? _height;
  double? _width;

  String? _setTime, _setDate;

  String? _hour, _minute, _time;

  String? dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  Future<void> _pSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        pickDateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  Future<void> _dSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        deliverDateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }
  Future<void> _orderPostingSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        deliverDateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  Future<void> _pFSelectTime(BuildContext context) async {
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
        pickFromTimeController.text = _time!;
        pickFromTimeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }
  Future<void> _pTSelectTime(BuildContext context) async {
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
        pickToTimeController.text = _time!;
        pickToTimeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  Future<void> _dFSelectTime(BuildContext context) async {
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
        deliverFromTimeController.text = _time!;
        deliverFromTimeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }
  Future<void> _dTSelectTime(BuildContext context) async {
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
        deliverToTimeController.text = _time!;
        deliverToTimeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  @override
  void initState() {
    orderPlaceDateController.text = DateFormat.yMd().format(DateTime.now());
    pickDateController.text = DateFormat.yMd().format(DateTime.now());
    deliverDateController.text = DateFormat.yMd().format(DateTime.now());

    pickFromTimeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    pickToTimeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    deliverFromTimeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    deliverToTimeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  var type;
  FirebaseServices services = FirebaseServices();

  /// textEditing controller
  TextEditingController orderPlaceDateController = TextEditingController();
  TextEditingController pickDateController = TextEditingController();
  TextEditingController deliverDateController = TextEditingController();
  TextEditingController pickFromTimeController = TextEditingController();
  TextEditingController deliverFromTimeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController pickToTimeController = TextEditingController();
  TextEditingController deliverToTimeController = TextEditingController();

  List<String> orderFor(BuildContext context) =>
      ['wash', 'ironing', 'fold', 'dry', 'cleaner'];

  List<String> brand(BuildContext context) => [
        'Skirt',
        'Shirt',
        'Polo',
        'T-Shirt',
        'Suit',
        'Jean',
        'Sleeveless',
      ];

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    Widget _appBar(fieldValue) {
      return AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor == Colors.white
            ? Colors.white.withOpacity(0.8)
            : Colors.black,
        automaticallyImplyLeading: false,
        //centerTitle: true,
        title: Text(
          fieldValue,
          style: TextStyle(fontSize: 15.sp),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      );
    }

    Widget? bottomSheet({fieldValue, list, textController}) {
      showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        context: context,
        builder: (context) {
          return Scaffold(
            body: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ListTile(
                      onTap: () {
                        /// return back
                        Navigator.pop(context);
                        textController.text = list[index];
                      },
                      title: Row(
                        children: [
                          CircleAvatar(
                            radius: 7,
                            backgroundColor: Colors.grey[700]!.withOpacity(0.6),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(list[index]),
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
      );
    }

    Widget? smalBottomSheet({list, textController}) {
      showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        context: context,
        builder: (context) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListTile(
                    onTap: () {
                      /// return back
                      Navigator.pop(context);
                      textController.text = list[index];
                    },
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.grey[700]?.withOpacity(0.6),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(list[index]),
                      ],
                    ),
                  ),
                );
              });
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'New Order',
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              if(formKey.currentState!.validate())
             {
                 orderProvider.addOrderData(
                   orderUrl: orderProvider.urlList,
                   pickupDate: pickDateController.text,
                   deliverDate: deliverDateController.text,
                   orderPostingDate: pickDateController.text,
                   orderStatus: 'Submit',
                   orderPlacerId:services.user!.uid,
                   orderTime: DateTime.now().microsecondsSinceEpoch,
                   description: descController.text,
                   pickTimeFrom: pickFromTimeController.text,
                   pickTimeTo: pickToTimeController.text,
                   deliverTimeFrom: deliverFromTimeController.text,
                   deliverTimeTo: deliverToTimeController.text,
                 );
                 services.orderStep1.doc().set({
                   'orderUrl': orderProvider.urlList,
                   'pickupDate': pickDateController.text,
                   'deliverDate': deliverDateController.text,
                   'orderPostingDate': pickDateController.text,
                   'orderStatus': 'Submit',
                   'orderPlacerId':services.user!.uid,
                   'orderTime': DateTime.now().microsecondsSinceEpoch,
                   'description': descController.text,
                   'pickTimeFrom': pickFromTimeController.text,
                   'pickTimeTo': pickToTimeController.text,
                   'deliverTimeFrom': deliverFromTimeController.text,
                   'deliverTimeTo': deliverToTimeController.text,
                 });
             }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order has been successfully Placed !'),
                ),
              );
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const MainScreen()));
            },
            child: Container(
              height: 5.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: const Color(0xff27C1F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                  child: Text(
                'Confirm Order',
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ),
      body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Schedule Date & Time",

                    SizedBox(height: 1.h,),
                     Text('Pick Date & Time',style: TextStyle(
                        color:  Color(0xff381568),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                    ),
                    SizedBox(height: 1.h,),
                    Container(
                      height: 6.2.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                _pSelectDate(context);
                              },
                              child: Container(
                                height: 6.h,
                                width: 42.w,
                                alignment: Alignment.center,
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  controller: pickDateController,
                                  onSaved: (val) {
                                    _setDate = val;
                                  },
                                  decoration: const InputDecoration(


                                      labelStyle:
                                      TextStyle(color: Colors.black),
                                      border:  InputBorder.none,
                                      // disabledBorder:
                                      // UnderlineInputBorder(borderSide: BorderSide.none),
                                      // labelText: 'Time',
                                      contentPadding:
                                      EdgeInsets.only(top: 0.0)),
                                ),
                              ),
                            ),
                            SizedBox(width: 3.w,),

                            Container(
                              height: 6.h,
                              width: 42.w,

                              child: Column(
                                children: [
                                  SizedBox(height: 0.4.h,),
                                  InkWell(
                                    onTap: () {
                                      _pFSelectTime(context);
                                    },
                                    child: Container(
                                      height: 2.7.h,
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 12),
                                       // textAlign: TextAlign.center,
                                        onSaved: (val) {
                                          _setTime = val;
                                        },
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        controller: pickFromTimeController,
                                        decoration:  const InputDecoration(
                                          prefixIcon: Text(' From:'),
                                            contentPadding: EdgeInsets.only(top: -11),
                                            border: InputBorder.none,
                                            // labelText: 'Time',
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _pFSelectTime(context);
                                    },
                                    child: Container(
                                      height: 2.7.h,
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 12),
                                       // textAlign: TextAlign.center,
                                        onSaved: (val) {
                                          _setTime = val;
                                        },
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        controller: pickFromTimeController,
                                        decoration:  const InputDecoration(
                                            prefixIcon: Text(' To:'),
                                          contentPadding: EdgeInsets.only(top: -11),
                                            // labelText: 'TO',
                                            labelStyle:
                                            TextStyle(color: Colors.black),
                                            border:InputBorder.none,
                                            // labelText: 'Time',
                                           ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h,),
                     Text('Deliver Date & Time',style: TextStyle(
                        color:  Color(0xff381568),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),),
                    SizedBox(height: 1.h,),
                    Container(
                      height: 6.2.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                _pSelectDate(context);
                              },
                              child: Container(
                                height: 6.h,
                                width: 42.w,
                                alignment: Alignment.center,
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  controller: pickDateController,
                                  onSaved: (val) {
                                    _setDate = val;
                                  },
                                  decoration: const InputDecoration(


                                      labelStyle:
                                      TextStyle(color: Colors.black),
                                      border:  InputBorder.none,
                                      // disabledBorder:
                                      // UnderlineInputBorder(borderSide: BorderSide.none),
                                      // labelText: 'Time',
                                      contentPadding:
                                      EdgeInsets.only(top: 0.0)),
                                ),
                              ),
                            ),
                            SizedBox(width: 3.w,),

                            Container(
                              height: 6.h,
                              width: 42.w,

                              child: Column(
                                children: [
                                  SizedBox(height: 0.4.h,),
                                  InkWell(
                                    onTap: () {
                                      _pFSelectTime(context);
                                    },
                                    child: Container(
                                      height: 2.7.h,
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 12),
                                        // textAlign: TextAlign.center,
                                        onSaved: (val) {
                                          _setTime = val;
                                        },
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        controller: pickFromTimeController,
                                        decoration:  const InputDecoration(
                                          prefixIcon: Text(' From:'),
                                          contentPadding: EdgeInsets.only(top: -11),
                                          border: InputBorder.none,
                                          // labelText: 'Time',
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _pFSelectTime(context);
                                    },
                                    child: Container(
                                      height: 2.7.h,
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 12),
                                        // textAlign: TextAlign.center,
                                        onSaved: (val) {
                                          _setTime = val;
                                        },
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        controller: pickFromTimeController,
                                        decoration:  const InputDecoration(
                                          prefixIcon: Text(' To:'),
                                          contentPadding: EdgeInsets.only(top: -11),
                                          // labelText: 'TO',
                                          labelStyle:
                                          TextStyle(color: Colors.black),
                                          border:InputBorder.none,
                                          // labelText: 'Time',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),


                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text('Order Details'
                    ,style: TextStyle(
                    color:  Color(0xff381568),
              fontWeight: FontWeight.w500,
              fontSize: 16.sp),),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 20.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: const Color(0xff27C1F9).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey)
                  ),
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    maxLength: 200,
                    minLines: 6,
                    maxLines: 10,
                    controller: descController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      // hintText: 'description',
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Add Photos',style: TextStyle(
                    color:  Color(0xff381568),
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp),
                ),
                Container(height: 18.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: AddImage()),
                SizedBox(
                  height: 1.h,
                ),
                const PickUpAddress(),
                SizedBox(
                  height: 2.h,
                ),

              ],
            ),
          )),
    );
  }
}
