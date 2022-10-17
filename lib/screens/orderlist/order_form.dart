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

  Future<void> _pSelectTime(BuildContext context) async {
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
        pickTimeController.text = _time!;
        pickTimeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  Future<void> _dSelectTime(BuildContext context) async {
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
        deliverTimeController.text = _time!;
        deliverTimeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  @override
  void initState() {
    pickDateController.text = DateFormat.yMd().format(DateTime.now());
    deliverDateController.text = DateFormat.yMd().format(DateTime.now());

    pickTimeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    deliverTimeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  var type;
  FirebaseServices services = FirebaseServices();

  /// textEditing controller
  TextEditingController brandController = TextEditingController();
  TextEditingController orderForController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController pickDateController = TextEditingController();
  TextEditingController deliverDateController = TextEditingController();
  TextEditingController pickTimeController = TextEditingController();
  TextEditingController deliverTimeController = TextEditingController();
  TextEditingController descController = TextEditingController();

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
          'Order List',
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
                   orderName: brandController.text,
                   orderQuantity: quantityController.text,
                   orderUrl: orderProvider.urlList,
                   pickTime: pickTimeController.text,
                   pickupDate: pickDateController.text,
                   deliverTime: deliverTimeController.text,
                   deliverDate: deliverDateController.text,
                   orderFor: orderForController.text,
                   orderStatus: 'Submit',
                   orderPlacerId:services.user!.uid,
                   orderTime: DateTime.now().microsecondsSinceEpoch,
                   description: descController.text,
                 );
                 orderProvider.addOrderStep(
                   collectionReference: services.orderStep1,
                   orderName: brandController.text,
                   orderQuantity: quantityController.text,
                   pickTime: pickTimeController.text,
                   pickupDate: pickDateController.text,
                   deliverTime: deliverTimeController.text,
                   deliverDate: deliverDateController.text,
                   orderFor: orderForController.text,
                   orderStatus: 'Submit',
                   orderPlacerId:services.user!.uid,
                   orderTime: DateTime.now().microsecondsSinceEpoch,
                   description: descController.text,
                 );

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
                    Text(
                      "Schedule Date & Time",
                      style: TextStyle(
                          color: const Color(0xff381568),
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp),
                    ),
                    Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            _pSelectDate(context);
                          },
                          child: Container(
                            width: 20.h,
                            height: 4.h,
                            margin: const EdgeInsets.only(top: 15),
                            alignment: Alignment.center,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: pickDateController,
                              onSaved: (val) {
                                _setDate = val;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/pick.png',
                                      height: 2.h,
                                    ),
                                  ),
                                  labelText: 'Pickup Date',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  // disabledBorder:
                                  // UnderlineInputBorder(borderSide: BorderSide.none),
                                  // labelText: 'Time',
                                  contentPadding:
                                      const EdgeInsets.only(top: 0.0)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _pSelectTime(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 15),
                            width: 20.h,
                            height: 4.h,
                            alignment: Alignment.center,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                              onSaved: (val) {
                                _setTime = val;
                              },
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: pickTimeController,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/pick.png',
                                      height: 2.h,
                                    ),
                                  ),
                                  labelText: 'Pickup Time',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
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
                    Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            _dSelectDate(context);
                          },
                          child: Container(
                            width: 20.h,
                            height: 4.h,
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: deliverDateController,
                              onSaved: (val) {
                                _setDate = val;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/deliver.png',
                                      height: 2.h,
                                    ),
                                  ),
                                  labelText: 'Deliver Date',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  // disabledBorder:
                                  // UnderlineInputBorder(borderSide: BorderSide.none),
                                  // labelText: 'Time',
                                  contentPadding:
                                      const EdgeInsets.only(top: 0.0)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _dSelectTime(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 20.h,
                            height: 4.h,
                            alignment: Alignment.center,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                              onSaved: (val) {
                                _setTime = val;
                              },
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: deliverTimeController,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/deliver.png',
                                      height: 2.h,
                                    ),
                                  ),
                                  labelText: 'Deliver Time',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
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
                ),
                SizedBox(
                  height: 1.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Items Type',
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    InkWell(
                      onTap: () {
                        smalBottomSheet(
                            // fieldValue: 'Choose Area',
                            list: brand(context),
                            textController: brandController);
                      },
                      child: Container(
                        height: 6.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: const Color(0xff27C1F9).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: TextFormField(
                          enabled: false,
                          controller: brandController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            hintText: 'Choose Item Type',
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order For',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        InkWell(
                          onTap: () {
                            smalBottomSheet(
                                // fieldValue: 'Choose Area',
                                list: orderFor(context),
                                textController: orderForController);
                          },
                          child: Container(
                            height: 6.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                              color: const Color(0xff27C1F9).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextFormField(
                              enabled: false,
                              controller: orderForController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'required';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8),
                                hintText: 'Order For',
                                hintStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please Enter Quantity ',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          height: 6.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff27C1F9).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextFormField(
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                              hintText: 'Items Quantity',
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Add Photos',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
                Container(height: 18.h, child: AddImage()),
                SizedBox(
                  height: 1.h,
                ),
                const PickUpAddress(),
                SizedBox(
                  height: 1.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('description',
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      height: 10.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: const Color(0xff27C1F9).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        maxLength: 200,
                        minLines: 3,
                        maxLines: 10,
                        controller: descController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          hintText: 'description',
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
