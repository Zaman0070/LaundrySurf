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

class LoginScreen extends StatefulWidget {
  final int? index;
  const LoginScreen({Key? key,required this.index}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


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


  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: (){
        if(widget.index == 0){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>const SignUp(index: 0,)));
        }else if(widget.index == 1){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>const SignUp(index: 1,)));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (_)=>const SignUp(index: 2,)));
        }
      },
      child:widget.index==0 ? RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Color(0xff27C1F9),
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color:Color(0xff27C1F9),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ):widget.index==1 ? Container(): Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var data = userProvider.userData;

    Widget _buildLoginBtn() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            if(formKey.currentState!.validate()){
                widget.index == 0 ? services.userLogin(emailTextController.text, passwordTextController.text, context,):widget.index==1?
                services.adminLogin(emailTextController.text, passwordTextController.text, context,):services.riderLogin(emailTextController.text, passwordTextController.text, context);
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
                          widget.index == 0 ?"Let's Login": widget.index==1? "Login as a Admin":"Login as a Rider",
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
                       widget.index==0? forgetPassword():widget.index==1?forgetPassword():Container(),
                        SizedBox(
                          height: 3.h,
                        ),
                        _buildLoginBtn(),

                        widget.index == 0 ? SignInButton(
                          Buttons.google,
                          text: "Sign up with Google",
                          onPressed: ()async {
                            User? user =await GoogleAuth.signInWithGoogle(context: context);
                            if(user!=null){
                              FirebaseServices services = FirebaseServices();
                               services.addUser(context, user.uid);
                            }
                          },
                        ):widget.index==1 ? Container(): Container(),
                        SizedBox(
                          height: 6.h,
                        ),
                        _buildSignupBtn(),
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
