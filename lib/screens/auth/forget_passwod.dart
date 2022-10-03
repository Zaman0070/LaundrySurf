import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/screens/auth/login.dart';
import 'package:sizer/sizer.dart';




class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  final formKey  = GlobalKey<FormState>();


  bool validate = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              primary: Theme.of(context).primaryColor ,
            ),
            onPressed: (){
              if(formKey.currentState!.validate()){
                FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text)
                    .then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen(index: 0,)));
                });

              }

            },
            child: const Padding(
              padding: EdgeInsets.all(14.0),
              child: Text('Next',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),
              ),
            ),
          ),

        ),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              const   Icon(Icons.lock,color: Color(0xff27C1F9),size: 75,),
                const SizedBox(height: 10,),
                Text('Forget\nPassword?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 23.sp,fontWeight: FontWeight.bold,color:  Color(0xff27C1F9)),
                ),
                const SizedBox(height: 10,),
                const Text('Send your email,\nWe will send a link to reset password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 10,),

                ///////////////////////////////////////////////////

                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Enter email';
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 12),
                    labelText: 'Enter your Email',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
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