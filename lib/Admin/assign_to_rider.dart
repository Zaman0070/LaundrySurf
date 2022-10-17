import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/Admin/about_rider/search_rider.dart';
import 'package:laundry_app/Admin/admin_screen.dart';
import 'package:laundry_app/provider/user_provider.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../provider/order_provider.dart';


class AssignToRider extends StatefulWidget {
  int? index;
   AssignToRider({Key? key,required this.index}) : super(key: key);


  @override
  State<AssignToRider> createState() => _AssignToRiderState();
}

class _AssignToRiderState extends State<AssignToRider> {
  RiderSearchService riderSearchService = RiderSearchService();
  FirebaseServices services = FirebaseServices();
  static List<Rider> users = [];


  @override
  void initState() {
    services.users.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        setState(() {
          users.add(
            Rider(
              documentSnapshot: doc,
              uid: doc['uid'],
              email: doc['email'],
              image: doc['url'],
            ),
          );
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    var orderData = orderProvider.orderData;
    var provider = Provider.of<UserProvider>(context, listen: false);
    bool check = Theme.of(context).primaryColor == Colors.white ? true : false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text('List of All Rider',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:const  Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
      ),
      body: Container(
        width: 100.w,

        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 6.h,
                //alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.w),
                    color: const Color(0xffCCC6DA),
                    boxShadow: [
                      BoxShadow(
                        color: check ? Colors.grey : Colors.transparent,
                        blurRadius: 10.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: const Offset(
                          0.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ]),
                child: InkWell(
                  splashColor: const Color(0xff8E7FC0),
                  onTap: () {
                    setState(() {
                      riderSearchService.search(context: context, userList: users,);
                    });
                  },
                  child: const TextField(
                    style: TextStyle(color: Colors.black),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      enabled: false,
                      hintText:'search users',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: services.users.where('type',isEqualTo: 'rider').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
                      child: const Center(child: CircularProgressIndicator())
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int index) {
                      var indexSelect ;
                      var data = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      height: 20.h,
                                      child: Column(
                                        // mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Are you sure to assign this rider?',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('No'),
                                              ),
                                              SizedBox(width: 5.w),
                                              ElevatedButton(
                                                onPressed: () async{
                                                  orderData!.reference.update({
                                                    'orderName': orderData['orderName'],
                                                    'orderQuantity': orderData['orderQuantity'],
                                                    'orderUrl': orderData['orderUrl'],
                                                    'pickTime':  orderData['pickTime'],
                                                    'pickupDate': orderData['pickupDate'],
                                                    'deliverTime':  orderData['deliverTime'],
                                                    'deliverDate':  orderData['deliverDate'],
                                                    'orderFor':  orderData['orderFor'],
                                                    'orderStatus':widget.index==0? 'assignToRiderForPick':'assignToRiderForDeliver',
                                                    'orderPlacerId': orderData['orderPlacerId'],
                                                    'orderTime': orderData['orderTime'],
                                                    'price': orderData['price'],
                                                    'riderAssign':snapshot.data!.docs[index].id
                                                  });
                                                  if(widget.index==0){
                                                    services.orderStep3.doc().set({
                                                      'orderName': orderData['orderName'],
                                                      'orderQuantity': orderData['orderQuantity'],
                                                      'orderUrl': orderData['orderUrl'],
                                                      'pickTime':  orderData['pickTime'],
                                                      'pickupDate': orderData['pickupDate'],
                                                      'deliverTime':  orderData['deliverTime'],
                                                      'deliverDate':  orderData['deliverDate'],
                                                      'orderFor':  orderData['orderFor'],
                                                      'orderStatus': 'assignToRiderForPick',
                                                      'orderPlacerId': orderData['orderPlacerId'],
                                                      'orderTime': orderData['orderTime'],
                                                      'price': orderData['price'],
                                                      'riderAssign':snapshot.data!.docs[index].id
                                                    });
                                                  }else{
                                                    services.orderStep8.doc().set({
                                                      'orderName': orderData['orderName'],
                                                      'orderQuantity': orderData['orderQuantity'],
                                                      'orderUrl': orderData['orderUrl'],
                                                      'pickTime':  orderData['pickTime'],
                                                      'pickupDate': orderData['pickupDate'],
                                                      'deliverTime':  orderData['deliverTime'],
                                                      'deliverDate':  orderData['deliverDate'],
                                                      'orderFor':  orderData['orderFor'],
                                                      'orderStatus': 'assignToRiderForDeliver',
                                                      'orderPlacerId': orderData['orderPlacerId'],
                                                      'orderTime': orderData['orderTime'],
                                                      'price': orderData['price'],
                                                      'riderAssign':snapshot.data!.docs[index].id
                                                    });
                                                  }

                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const AdminScreen()));
                                                },
                                                child: const Text('Yes'),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                           },
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                    height: 6.h,
                                    width: 6.h,
                                    child: Image.network(
                                      data['url'],
                                      fit: BoxFit.cover,
                                    ))),
                            title: Text( data['email']),
                            subtitle: Text( data['name']),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  indexSelect = data;
                                });

                              },
                              icon:  Icon(Icons.check,color: indexSelect ==data ?Colors.greenAccent:Colors.white),
                            )

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
  Future<void> deleteUser(String userId) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(userId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
