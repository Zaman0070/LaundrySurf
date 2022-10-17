import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laundry_app/provider/user_provider.dart';
import 'package:laundry_app/screens/auth/sign_up.dart';
import 'package:laundry_app/screens/home/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:sizer/sizer.dart';

import '../../services/firbaseservice.dart';
import '../home/home_screen.dart';
import 'forget_passwod.dart';
import 'google.dart';

class AdminLoginScreen extends StatefulWidget {

  const AdminLoginScreen({Key? key,}) : super(key: key);

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {


  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  FirebaseServices services = FirebaseServices();
  final formKey = GlobalKey<FormState>();

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).splashColor,
          ),
          height: 50.0,
          child:  TextFormField(
            controller: emailTextController,
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Enter your Email';
              }
            },
            keyboardType: TextInputType.emailAddress,
            style:const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration:const InputDecoration(
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

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).splashColor,
          ),
          height: 50.0,
          child:  TextFormField(
            controller: passwordTextController,
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Enter your Password';
              }
              return null;
            },
            obscureText: true,
            style:const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration:const InputDecoration(

              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xff27C1F9),
              ),
              hintText: 'Enter your Password',
              //  hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }


  Widget forgetPassword(){
    return GestureDetector(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ForgetPassword())),
      child:  Padding(
        padding: EdgeInsets.only(left: 55.w),
        child: const Text('Forget Password',style: TextStyle(color: Color(0xff27C1F9),),),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var data = userProvider.userData;
    Widget _buildLoginBtn() {
      return FutureBuilder<QuerySnapshot>(
          future: services.users.where('type',isEqualTo: 'admin').get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Some things wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data!.docs[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    width: double.infinity,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          if(data['type']=='admin'){
                            services.adminLogin(emailTextController.text, passwordTextController.text, context);
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content:
                              Text('This Account are not login as Admin !'),
                              ),
                            );
                          }
                        }
                      },
                      padding: const EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: const Color(0xff27C1F9),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  );
                }
            );
          });

    }


    // Widget _buildLoginBtn() {
    //   return Container(
    //     padding: const EdgeInsets.symmetric(vertical: 25.0),
    //     width: double.infinity,
    //     child: RaisedButton(
    //       elevation: 5.0,
    //       onPressed: () {
    //         if(formKey.currentState!.validate()){
    //             widget.index == 0 ? services.userLogin(emailTextController.text, passwordTextController.text, context,):widget.index==1?
    //             services.adminLogin(emailTextController.text, passwordTextController.text, context,):services.riderLogin(emailTextController.text, passwordTextController.text, context);
    //         }
    //       },
    //       padding: const EdgeInsets.all(15.0),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10.0),
    //       ),
    //       color: const Color(0xff27C1F9),
    //       child: const Text(
    //         'LOGIN',
    //         style: TextStyle(
    //           color: Colors.white,
    //           letterSpacing: 1.5,
    //           fontSize: 18.0,
    //           fontWeight: FontWeight.bold,
    //           fontFamily: 'OpenSans',
    //         ),
    //       ),
    //     ),
    //   );
    // }
    return Scaffold(
      body: Form(
        key: formKey,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                ),
                SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Text(data!.docs.first['']),
                        Image.asset(
                          'assets/logo/logo.png',
                          height: 10.h,
                          color: const Color(0xff27C1F9),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          "Login as a Admin",
                          style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontFamily: 'OpenSans',
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        _buildEmailTF(),
                        SizedBox(
                          height: 2.h,
                        ),
                        _buildPasswordTF(),
                        SizedBox(
                          height: 1.h,
                        ),
                      //  widget.index==0? forgetPassword():widget.index==1?forgetPassword():Container(),
                        SizedBox(
                          height: 3.h,
                        ),
                        _buildLoginBtn(),
                        SizedBox(
                          height: 6.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
