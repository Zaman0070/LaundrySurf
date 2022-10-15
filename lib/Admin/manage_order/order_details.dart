import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/Admin/admin_screen.dart';
import 'package:laundry_app/provider/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    var data = orderProvider.orderData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Order Details',
          style: TextStyle(color: Colors.black, fontSize: 18.sp),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: () async {
            data!.reference.update({
              'orderName': data['orderName'],
              'orderQuantity': data['orderQuantity'],
              'orderUrl': data['orderUrl'],
              'pickTime':  data['pickTime'],
              'pickupDate': data['pickupDate'],
              'deliverTime':  data['deliverTime'],
              'deliverDate':  data['deliverDate'],
              'orderFor':  data['orderFor'],
              'orderStatus': 'acceptThis',
              'orderPlacerId': data['orderPlacerId'],
              'orderTime': data['orderTime'],
              'price': priceController.text,
            });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order has been successfully Placed !'),
                  ),
                );
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const AdminScreen()));

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
              height: 18.h,
              width: 100.w,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    data!['orderUrl'][0],
                    fit: BoxFit.fill,
                  )),
            ),
            SizedBox(height: 1.h,),
            Container(
              height: 20.h,
              width: 100.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          data['orderName'],
                          style: TextStyle(
                              color: const Color(0xff381568),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp),
                        ),
                        Text(
                          "(${data['orderQuantity']}) items for ${data['orderFor']}",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 11.sp),
                        ),
                      ],
                    ),
                    const Divider(),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              text:"(${data['orderQuantity']}) items for ${data['orderFor']}",
                              style: TextStyle(
                                  color: Colors.grey.shade900, fontSize: 11.sp),
                             ),
                        ),
                        Container(
                          height: 6.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff27C1F9).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextFormField(
                            controller: priceController,
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
                              hintText: 'Enter Price',
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Divider(),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
