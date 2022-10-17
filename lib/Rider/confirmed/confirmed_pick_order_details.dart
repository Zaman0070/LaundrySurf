import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:laundry_app/rider/rider_screen.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:geocoding/geocoding.dart' as geo;

import '../../provider/order_provider.dart';

class ConfirmPickOrderDetails extends StatefulWidget {
  int? index;
   ConfirmPickOrderDetails({Key? key,required this.index}) : super(key: key);


  @override
  State<ConfirmPickOrderDetails> createState() => _ConfirmPickOrderDetailsState();
}

class _ConfirmPickOrderDetailsState extends State<ConfirmPickOrderDetails> {
  TextEditingController DateController = TextEditingController();
  TextEditingController TimeController = TextEditingController();
  FirebaseServices services = FirebaseServices();
  double? _height;
  double? _width;

  String? _setTime, _setDate;

  String? _hour, _minute, _time;

  String? dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);


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
        DateController.text = DateFormat.yMd().format(selectedDate);
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
        TimeController.text = _time!;
        TimeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    var data = orderProvider.orderData;

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            Image.asset('assets/images/truck.png',height: 16.h,),
            Center(child: Text(widget.index==0?'Pick the order':"Deliver the order",style: TextStyle(color: const Color(0xff381568),fontSize: 15.sp,fontWeight: FontWeight.bold),)),
            SizedBox(height: 1.h,),
            Center(child: Text(widget.index==0?'After pickup the order so confirmed its.':'After Deliver the order so confirmed its.',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Colors.grey.shade500),)),
            SizedBox(height: 2.h,),
            Column(
          children: [
            Container(
              height: 35.h,
              width: 100.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Order #${data!['orderNumber']}',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.bold,fontSize: 14.sp),),
                        Text(' (${data['orderQuantity']} ${data['orderName']})',style: TextStyle(color: Colors.grey.shade600,fontSize: 10.sp),),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Text('${data['pickupDate']}-  To  -${data['deliverDate']}',style: TextStyle(color: Colors.grey.shade600,fontSize: 10.sp),),
                    const Divider(),
                    Text(data['orderFor'],style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.bold,fontSize: 13.sp),),
                    SizedBox(height: 0.7.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(text:  TextSpan(text: '${data['orderQuantity']} x ${data['orderName']}  ',style: TextStyle(color: Colors.grey.shade900,fontSize: 11.sp),
                        ),
                        ),
                        Text('\$${data['price']}',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 12.sp),),
                      ],
                    ),
                    SizedBox(height: 0.7.h,),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w400,fontSize: 12.sp),),
                        Text('\$${data['price']}',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 12.sp),),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Text',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w400,fontSize: 12.sp),),
                        Text('\0.00',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 12.sp),),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w400,fontSize: 12.sp),),
                        Text('\$${data['price']}',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 14.sp),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _dSelectDate(context);
                  },
                  child: Container(
                    width: 20.h,
                    height: 5.h,
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: TextFormField(
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: DateController,
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
                          labelText: widget.index==0?'Pick Date':'Deliver Time',
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
                    margin: const EdgeInsets.only(top: 10),
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
                      controller: TimeController,
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/icons/deliver.png',
                              height: 2.h,
                            ),
                          ),
                          labelText: widget.index==0?'Pick Time':'Deliver Time',
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
            SizedBox(height: 1.h,),

            SizedBox(height: 1.h,),
            InkWell(
              onTap: () async {
                data.reference.update({
                  'orderName': data['orderName'],
                  'orderQuantity': data['orderQuantity'],
                  'orderUrl': data['orderUrl'],
                  'pickTime':  data['pickTime'],
                  'pickupDate': data['pickupDate'],
                  'deliverTime': TimeController.text,
                  'deliverDate':  DateController.text,
                  'orderFor':  data['orderFor'],
                  'orderStatus':widget.index ==0?"ConfirmedForPick":"ConfirmedDeliver",
                 // 'orderStatus': widget.index==0?'RiderPickOrder & DeliverToLaundryHub':"Delivered",
                  'orderPlacerId': data['orderPlacerId'],
                  'orderTime': data['orderTime'],
                  'price': data['price'],
                  'riderAssign':data['riderAssign']
                });
                if(widget.index==0){
                  services.orderStep4.doc().set({
                    'orderName': data['orderName'],
                    'orderQuantity': data['orderQuantity'],
                    'orderUrl': data['orderUrl'],
                    'pickTime':  data['pickTime'],
                    'pickupDate': data['pickupDate'],
                    'deliverTime':  data['deliverTime'],
                    'deliverDate':  data['deliverDate'],
                    'orderFor':  data['orderFor'],
                    'orderStatus': 'ConfirmedForPick',
                    'orderPlacerId': data['orderPlacerId'],
                    'orderTime': data['orderTime'],
                    'price': data['price'],
                    'riderAssign':data['riderAssign']
                  });
                }else{
                  services.orderStep9.doc().set({
                    'orderName': data['orderName'],
                    'orderQuantity': data['orderQuantity'],
                    'orderUrl': data['orderUrl'],
                    'pickTime':  data['pickTime'],
                    'pickupDate': data['pickupDate'],
                    'deliverTime':  data['deliverTime'],
                    'deliverDate':  data['deliverDate'],
                    'orderFor':  data['orderFor'],
                    'orderStatus': 'ConfirmedDeliver',
                    'orderPlacerId': data['orderPlacerId'],
                    'orderTime': data['orderTime'],
                    'price': data['price'],
                    'riderAssign':data['riderAssign']
                  });
                }


                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                    content: Text(widget.index==0?'Order has been successfully Picked!':'Order has been successfully Delivered!'),
                  ),
                );
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const RiderScreen()));

              },
              child: Container(
                height: 5.5.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xff27C1F9)
                ),
                child: Center(
                  child: Text(widget.index==0?'Confirmed Pick':"Confirmed Delivered",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),

            // SizedBox(height: 1.h,),
            // Container(
            //   height: 10.5.h,
            //   width: 100.w,
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey.shade300),
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //
            //           children: [
            //             Image.asset('assets/icons/pay.png',height: 2.h,),
            //             SizedBox(width: 2.w,),
            //             Text('Payment Method',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.bold,fontSize: 14.sp),),
            //           ],
            //         ),
            //         SizedBox(height: 1.h,),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 20.0),
            //           child: Text('Visa/Master Card ***********1234',style: TextStyle(color: Colors.grey,fontSize: 10.sp),),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // const PickUpAddress(),
            SizedBox(height: 1.h,),

            SizedBox(height: 4.h,),


          ],
        ),
      ),
    );
  }
}
