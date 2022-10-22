import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseServices services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: FutureBuilder<DocumentSnapshot>(
            future: services.getUserData(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.data == null) {
                return Container();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ));
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        radius: 2.6.h,
                        child: CircleAvatar(
                          radius: 2.5.h,
                          backgroundImage: NetworkImage(
                            snapshot.data!['url'],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!['name'],
                            style: TextStyle(
                                color: const Color(0xff381568),
                                fontSize: 15.sp),
                          ),
                          Text(
                            'Gold member ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/icons/bell.png',
                        height: 3.5.h,
                      ))
                ],
              );
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            SizedBox(
              height: 1.5.h,
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).splashColor,
              ),
              height: 50.0,
              child: const TextField(
                obscureText: true,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: 'Search services',
                  //  hintStyle: kHintTextStyle,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Services',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xff381568),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              height: 13.h,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Image.asset('assets/images/wash.png'),
                    Image.asset('assets/images/fold.png'),
                    Image.asset('assets/images/iron.png'),
                    Image.asset('assets/images/dry.png'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Image.asset('assets/images/banner.png'),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Last Order',
              style: TextStyle(color: const Color(0xff381568), fontSize: 15.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            FutureBuilder<QuerySnapshot>(
              future: services.order
                  .where('orderPlacerId', isEqualTo: services.user!.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }
                return ListView.builder(
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 20.9.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(0.5.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          data['orderStatus'] == 'Submit'
                                              ? 'assets/icons/clock.png'
                                              : data['orderStatus'] ==
                                              'acceptThis'
                                              ? 'assets/icons/hand.png'
                                              : 'assets/icons/click.png',
                                          height: 3.h,
                                        ),SizedBox(width: 2.w,),
                                        Text(
                                          'Order # ${data['orderNumber']} ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),

                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        data['orderStatus'] == 'forUpdate'
                                            ? ''
                                            : data['orderStatus'] ==
                                                    'acceptThis'
                                                ? "AED ${data['price']}"
                                                : 'AED ${data['price']}',
                                        style: TextStyle(
                                            color: const Color(0xff27C1F9),
                                            fontSize: 15.sp),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(

                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.0, left: 8),
                                          child: Text('Picked Date : ')
                                        ),
                                        Text(data['pickupDate']),

                                      ],
                                    ),
                                    Row(

                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.0, left: 8),
                                          child: Text('Deliver date : '),
                                        ),
                                        Text(data['deliverDate']),
                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    'Order Status',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            'assets/icons/address.png',
                                            height: 1.5.h,
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Image.asset(
                                            'assets/icons/dot.png',
                                            color: data['orderStatus'] ==
                                                    'acceptThis'
                                                ? Colors.black
                                                : data['orderStatus'] ==
                                                        'RiderPickOrder'
                                                    ? Colors.black
                                                    : data['orderStatus'] ==
                                                            'AdminPickOrder'
                                                        ? Colors.black
                                                        : data['orderStatus'] ==
                                                                'ReadyToDeliver'
                                                            ? Colors.black
                                                            : data['orderStatus'] ==
                                                                    'ConfirmedDeliver'
                                                                ? Colors.black
                                                                : data['orderStatus'] ==
                                                                        'Delivered'
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                            height: 0.11.h,
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Image.asset(
                                            'assets/icons/pik.png',
                                            height: 1.5.h,
                                            color: data['orderStatus'] ==
                                                    'RiderPickOrder'
                                                ? Colors.red
                                                : data['orderStatus'] ==
                                                        'AdminPickOrder'
                                                    ? Colors.red
                                                    : data['orderStatus'] ==
                                                            'ReadyToDeliver'
                                                        ? Colors.red
                                                        : data['orderStatus'] ==
                                                                'ConfirmedDeliver'
                                                            ? Colors.red
                                                            : data['orderStatus'] ==
                                                                    'Delivered'
                                                                ? Colors.red:
                                            data['orderStatus'] ==
                                                'assignToRiderForDeliver'
                                                ? Colors.red
                                                                : Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Image.asset(
                                            'assets/icons/dot.png',
                                            height: 0.11.h,
                                            color:  data['orderStatus'] ==
                                                'AdminPickOrder'
                                                ? Colors.black
                                                : data['orderStatus'] ==
                                                'ReadyToDeliver'
                                                ? Colors.black
                                                : data['orderStatus'] ==
                                                'ConfirmedDeliver'
                                                ? Colors.black
                                                : data['orderStatus'] ==
                                                'Delivered'
                                                ? Colors.black:
                                            data['orderStatus'] ==
                                                'assignToRiderForDeliver'
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Image.asset(
                                            'assets/icons/clock.png',
                                            height: 1.5.h,
                                            color:  data['orderStatus'] ==
                                                'AdminPickOrder'
                                                ? Colors.red
                                                : data['orderStatus'] ==
                                                'ReadyToDeliver'
                                                ? Colors.red
                                                : data['orderStatus'] ==
                                                'ConfirmedDeliver'
                                                ? Colors.red:
                                            data['orderStatus'] ==
                                                'assignToRiderForDeliver'
                                                ? Colors.red
                                                : data['orderStatus'] ==
                                                'Delivered'
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Image.asset(
                                            'assets/icons/dot.png',
                                            height: 0.11.h,
                                            color: data['orderStatus'] ==
                                                'ReadyToDeliver'
                                                ? Colors.black
                                                : data['orderStatus'] ==
                                                'ConfirmedDeliver'
                                                ? Colors.black
                                                : data['orderStatus'] ==
                                                'Delivered'
                                                ? Colors.black:
                                            data['orderStatus'] ==
                                                'assignToRiderForDeliver'
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Image.asset(
                                            'assets/images/ready.png',
                                            height: 1.5.h,
                                            color: data['orderStatus'] ==
                                                'ConfirmedDeliver'
                                                ? Colors.red:
                                            data['orderStatus'] ==
                                                'assignToRiderForDeliver'
                                                ? Colors.red
                                                : data['orderStatus'] ==
                                                'Delivered'
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                          Image.asset(
                                            'assets/icons/dot.png',
                                            height: 0.11.h,
                                            color: data['orderStatus'] ==
                                                'ConfirmedDeliver'
                                                ? Colors.black:
                                            data['orderStatus'] ==
                                                'assignToRiderForDeliver'
                                                ? Colors.black
                                                : data['orderStatus'] ==
                                                'Delivered'
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Image.asset(
                                            'assets/icons/hand.png',
                                            height: 1.5.h,
                                            color: data['orderStatus'] ==
                                                    'Delivered'
                                                ? const Color(0xff27C1F9)
                                                : Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Confirmed',
                                            style: TextStyle(
                                                color: const Color(0xff381568),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 8.sp),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text(
                                            'Picked up',
                                            style: TextStyle(
                                                color: data['orderStatus'] ==
                                                        'RiderPickOrder & DeliverToLaundryHub'
                                                    ? const Color(0xff381568)
                                                    : Colors.grey,
                                                // color: const Color(0xff381568),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 8.sp),
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Divider(),
                                          ),
                                          Text(
                                            'In Progress',
                                            style: TextStyle(
                                                color: data['orderStatus'] ==
                                                        'RiderPickOrder & DeliverToLaundryHub'
                                                    ? const Color(0xff381568)
                                                    : Colors.grey,
                                                //color: const Color(0xff381568),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 8.sp),
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Divider(),
                                          ),
                                          Text(
                                            'Ready To deliver',
                                            style: TextStyle(
                                                color: data['orderStatus'] ==
                                                        'RiderPickOrder & DeliverToLaundryHub'
                                                    ? const Color(0xff381568)
                                                    : Colors.grey,
                                                //color: const Color(0xff381568),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 8.sp),
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Divider(),
                                          ),
                                          Text(
                                            'Delivered',
                                            style: TextStyle(
                                                color: data['orderStatus'] ==
                                                        'Delivered'
                                                    ? const Color(0xff381568)
                                                    : Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 8.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
