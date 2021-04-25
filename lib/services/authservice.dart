import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/loginpage.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';


  handleAuth() {

    return StreamBuilder(
      stream: FirebaseAuth.instance.idTokenChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return DashboarPage();
        }
        else {
          return LoginPage();
        }
      },
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
  signIn(AuthCredential authCred){
    FirebaseAuth.instance.signInWithCredential(authCred);
  }

  signinwithotp(smsCode, verId){
    AuthCredential authCred = PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCred);
  }