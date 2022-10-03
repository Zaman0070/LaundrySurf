import 'package:flutter/material.dart';
import 'package:laundry_app/widget/cleaner.dart';
import 'package:laundry_app/widget/dry.dart';
import 'package:laundry_app/widget/fold.dart';
import 'package:laundry_app/widget/ironing.dart';
import 'package:laundry_app/widget/wash.dart';
import 'package:sizer/sizer.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList>with TickerProviderStateMixin {
  late TabController _controller;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
//Assign here
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
          'Order List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body:   Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 3.5.h,
            child: TabBar(
              unselectedLabelColor: Colors.black,
              isScrollable: true,
              indicatorWeight: 0,
              indicator:BoxDecoration(
                border: Border.all(
                    color: selectedIndex == 0
                        ? const Color(0xff27C1F9)
                        : const Color(0xff381568)),
                color: selectedIndex == 0
                    ? const Color(0xff27C1F9)
                    : Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
              controller: _controller,
              indicatorColor: Colors.amberAccent,
              tabs:  const [
                Tab(text: 'Wash',),
                Tab(text: 'Ironing',),
                Tab(text: 'Fold',),
                Tab(text: 'Dry',),
                Tab(text: 'Cleaner',),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: const [
               Wash(),
                Ironing(),
                Fold(),
                Dry(),
               Cleaner(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
