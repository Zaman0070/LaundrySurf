import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/screens/orderlist/payment.dart';
import 'package:laundry_app/screens/orderlist/pickup_address.dart';
import 'package:laundry_app/screens/orderlist/schedule_date.dart';
import 'package:sizer/sizer.dart';

class SchedulePickUp extends StatefulWidget {
  const SchedulePickUp({Key? key}) : super(key: key);

  @override
  State<SchedulePickUp> createState() => _SchedulePickUpState();
}

class _SchedulePickUpState extends State<SchedulePickUp> {
  int itemCount = 0;
  int index = 0;

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Card Number',style: TextStyle(fontSize: 14.sp),),
        SizedBox(height: 1.h,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).splashColor,
          ),
          height: 50.0,
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                size: 20,
                color: Color(0xff27C1F9),
              ),
              hintText: 'Enter your Email',
              //  hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget cardName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Name on Card',style: TextStyle(fontSize: 14.sp),),
        SizedBox(height: 1.h,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).splashColor,
          ),
          height: 50.0,
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                size: 20,
                color: Color(0xff27C1F9),
              ),
              hintText: 'Please your name on card',
              //  hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _monthYear() {
    return

        Column(
          children: [
            SizedBox(height: 1.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text('Card Number',style: TextStyle(fontSize: 14.sp),),
                    SizedBox(width: 2.w,),
                    Text('(Month + Year)',style: TextStyle(fontSize: 10.sp,color: Colors.grey.shade400),),
                    SizedBox(width: 15.w,),
                    Text('CVC',style: TextStyle(fontSize: 14.sp),),
                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30.w,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).splashColor,
                      ),
                      height: 50.0,
                      child: const TextField(

                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0,left: 10),
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                            color: Color(0xff27C1F9),
                          ),
                          hintText: 'mm',
                          //  hintStyle: kHintTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      width: 30.w,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).splashColor,
                      ),
                      height: 50.0,
                      child: const TextField(

                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0,left: 10),
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                            color: Color(0xff27C1F9),
                          ),
                          hintText: 'yyyy',
                          //  hintStyle: kHintTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      width: 30.w,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).splashColor,
                      ),
                      height: 50.0,
                      child: const TextField(

                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10),

                          hintText: 'CVC',
                          //  hintStyle: kHintTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );


  }

  Widget paypal(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
            controller: scrollController,
            shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add Paypal',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 16.sp),),
                IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(CupertinoIcons.multiply,color: Colors.grey,)),
              ],
            ),
            const Divider(thickness: 1,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _buildEmailTF(),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: (){},
                child: Container(
                  height: 5.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: const Color(0xff27C1F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:const Center(child: Text('Save & Continuous ',style: TextStyle(color: Colors.white),)),
                ),
              ),
            ),
            SizedBox(height: 4.h,),
          ],
        ),
      ),
    );
  }
  Widget visa(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    return Material(
      child: Container(
        child: ListView(
          controller: scrollController,
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Add Visa/Master Card',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 16.sp),),
                ),
                IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(CupertinoIcons.multiply,color: Colors.grey,)),
              ],
            ),
            const Divider(thickness: 1,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _buildEmailTF(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _monthYear(),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: cardName(),
            ),

            SizedBox(height: 2.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: (){},
                child: Container(
                  height: 5.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: const Color(0xff27C1F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:const Center(child: Text('Save & Continuous ',style: TextStyle(color: Colors.white),)),
                ),
              ),
            ),
            SizedBox(height: 4.h,),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Schedule A Pickup',
          style: TextStyle(color: Colors.black),
        ),
      ),
        bottomNavigationBar: Container(
          height: 15.h,
          decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(offset: Offset(3, 3),blurRadius: 6,spreadRadius: 2,color: Colors.grey.shade400)
              ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children:  [
                        CircleAvatar(
                          backgroundColor:const Color(0xff27C1F9).withOpacity(0.3),
                          radius: 23,
                          child: Image.asset('assets/wash/total.png',height: 3.5.h,color: const Color(0xff27C1F9),),
                        ),
                        SizedBox(width: 3.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w300),),
                            Text('${itemCount} items',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold),),

                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Cost',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w300),),
                        Text('\$${259}',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: const Color(0xff27C1F9)),),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
                InkWell(
                  onTap: () {
                    if (index == 0) {
                      showFlexibleBottomSheet(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minHeight: 0,
                        isCollapsible: true,
                        initHeight: 0.8,
                        maxHeight: 0.8,
                        context: context,
                        builder: paypal,
                        isExpand: false,
                        isDismissible: true
                      );
                    }
                    else if (index == 1) {
                      showFlexibleBottomSheet(
                        minHeight: 0,
                        initHeight: 0.8,
                        maxHeight: 0.8,
                        context: context,
                        builder: visa,
                        isExpand: false,
                      );
                    }else if(index == 2){
                      showFlexibleBottomSheet(
                        minHeight: 0,
                        initHeight: 0.8,
                        maxHeight: 0.8,
                        context: context,
                        builder: visa,
                        isExpand: false,
                      );
                    }
                  },
                  child: Container(
                    height: 5.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: const Color(0xff27C1F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:const Center(child: Text('Confirm Order',style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ],
            ),
          ),

        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            Text('Price Details',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 16.sp),),
            SizedBox(height: 2.h,),
            Container(
              height: 13.5.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal',style: TextStyle(fontSize: 12.sp),),
                        Text('\$220.00',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 14.sp),),
                      ],
                    ),
                    SizedBox(height: 0.5.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tax',style: TextStyle(fontSize: 12.sp),),
                        Text('\$10.0',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 14.sp),),
                      ],
                    ),
                    SizedBox(height: 0.5.h,),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',style: TextStyle(fontSize: 12.sp),),
                        Text('\$230.00',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 14.sp),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const ScheduleDate(),
             Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h,),
              Text("Payment Methode",style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 16.sp),),
              SizedBox(height: 1.h,),
              Container(
                height: 19.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200)
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          index= 0;
                        });
                      },
                      child: Container(
                        height: 6.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(index == 0 ?'assets/icons/ok.png': 'assets/icons/circle.png'),
                                  ),
                                  SizedBox(width: 5.w,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 1.h,),
                                      Text('Pay Via Paypal',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500,color:const Color(0xff381568)),),
                                      Text('+ Add account',style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color:Colors.red),),
                                    ],
                                  ),

                                ],
                              ),
                              Image.asset('assets/icons/paypal.png',height: 4.h,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          index= 1;
                        });
                      },
                      child: Container(
                        height: 6.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(index == 1 ?'assets/icons/ok.png': 'assets/icons/circle.png'),
                                  ),
                                  SizedBox(width: 5.w,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 1.h,),
                                      Text('Visa/Master Card',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500,color:const Color(0xff381568)),),
                                      Text('**** **** ****123',style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color:Colors.grey),),
                                    ],
                                  ),

                                ],
                              ),
                              Image.asset('assets/icons/visaa.png',height: 2.h,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          index= 2;
                        });
                      },
                      child: Container(
                        height: 6.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(index == 2 ?'assets/icons/ok.png': 'assets/icons/circle.png'),
                                  ),
                                  SizedBox(width: 5.w,),
                                  Text('Cash on Delivery',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500,color:const Color(0xff381568)),),

                                ],
                              ),
                              Image.asset('assets/icons/cashon.png',height: 7.h,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
            const PickUpAddress(),
          ],
        ),
      ),
    );
  }
}
