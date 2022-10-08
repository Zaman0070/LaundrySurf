import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/screens/orderlist/order_list.dart';
import 'package:laundry_app/search/search_screen.dart';
import 'package:sizer/sizer.dart';

import '../../order/order.dart';
import '../profile/profile_screen.dart';
import 'home_screen.dart';


class MainScreen extends StatefulWidget {


  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget currentScreen = const Home();

  int index = 0;

  final PageStorageBucket _bucket = PageStorageBucket();


  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).splashColor;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: (){
          return Future.value(false);
        },
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: const Color(0xff675492),
            child: PageStorage(
              bucket: _bucket,
              child: currentScreen,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff27C1F9),
        child: const Icon(CupertinoIcons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>const  OrderList()));
        },),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).canvasColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 9.h,
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: 38.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                      minWidth:20,
                        onPressed: () {
                          setState(() {
                            index = 0;
                            currentScreen = const Home();
                          });
                        },
                        child: Icon(
                           CupertinoIcons.house_alt,
                          color: index == 0 ? const Color(0xff27C1F9) : Colors.grey,
                        ),
                      ),
                      MaterialButton(
                        minWidth:20,
                        onPressed: () {
                          setState(() {
                            index = 1;
                            currentScreen =const SearchScreen();
                          });
                        },
                        child: Icon(
                         CupertinoIcons.search,
                          color: index == 1 ? const Color(0xff27C1F9) : Colors.grey,
                        ),
                      ),


                    ],
                  ),
                ),
              ),
              Container(
                width: 38.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                        minWidth: 20,
                        onPressed: () {
                          setState(() {
                            index = 2;
                            currentScreen =const OrderScreen();
                          });
                        },
                        child:Image.asset('assets/icons/details.png',height: 3.h,color: index == 2 ? const Color(0xff27C1F9) : Colors.grey[700],)
                    ),
                    MaterialButton(
                      minWidth: 20,
                      onPressed: () {
                        setState(() {
                          index = 3;
                          currentScreen =const Profile();
                        });
                      },
                      child: Icon(
                        CupertinoIcons.settings,
                        color: index == 3 ? const Color(0xff27C1F9) : Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
