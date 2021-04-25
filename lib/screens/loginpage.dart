import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/authservice.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  String phoneNo,verificationId, smsCode;
  bool codeSent= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Container(width: double.infinity,
                height: 65.0,
                color: Colors.grey,
                child: Text('code sent to +91XXXXXXXXXX',style: TextStyle(fontSize: 20.0, color: Colors.black),)),
              Container(height: 250.0,),
              Padding(padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: 'Enter your phone number'),
                onChanged: (val){
                  setState(() {
                    this.phoneNo = val;
                  });
                },
              )
              ),
              codeSent ? Padding(padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter otp'),
                    onChanged: (val){
                      setState(() {
                        this.smsCode = val;
                      });
                    },
                  )
              ) : Container(),
              Padding(padding: EdgeInsets.only(left: 25.0, right: 25.0),
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: (){codeSent? signinwithotp(smsCode, verificationId) :verifyPhone(phoneNo);},
                child: Center(
                    child: Center(child: codeSent? Text('login'): Text('verify')))


                ,
              ),)
            ],
          ),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async{
    final PhoneVerificationCompleted verified = (AuthCredential authResult){
      //To Do
      signIn(authResult);

    };
    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException){
      //To Do
      print('${authException.message}');

    };
    final PhoneCodeSent smssent = (String verId,[int forceResend]){
      this.verificationId = verId;
      setState(() {
        this.codeSent= true;
      });
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId){
      this.verificationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smssent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}

