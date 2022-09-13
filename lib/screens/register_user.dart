import 'package:cl1m_inventory/landing_page.dart';
import 'package:cl1m_inventory/reusable_widgets/reusable_widget.dart';
import 'package:cl1m_inventory/screens/borrower/borrower_page.dart';
import 'package:cl1m_inventory/screens/dashboard.dart';
import 'package:cl1m_inventory/utils/color_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userTypeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("F48818"),
            hexStringToColor("F9CB9C"),
            hexStringToColor("FFB482")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/ccis.png"),
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.20), BlendMode.dstIn),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      reusableTextField("Email", Icons.person_outline, false,
                          _emailTextController),
                      const SizedBox(
                        height: 15,
                      ),
                      reusableTextField("Password", Icons.lock_outlined, true,
                          _passwordTextController),
                      const SizedBox(
                        height: 15,
                      ),
                      reusableTextField(
                          "Admin or Borrower",
                          Icons.admin_panel_settings_outlined,
                          false,
                          _userTypeTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      firebaseUIButton(context, "Sign Up", () {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          FirebaseFirestore.instance
                              .collection('UserData')
                              .doc(value.user!.uid)
                              .set({
                            "email": value.user!.email,
                            "usertype": _userTypeTextController.text
                          });
                        });
                        print("Created New Account");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MaterialApp(
                              home: AlertDialog(
                                title: const Text(
                                    'Successfully created an account'),
                                content: const Text('Proceed to Login'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(0xfffe5a1d),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LandingPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Okay',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future addUserDetails(String usertype) async {
  //   await FirebaseFirestore.instance.collection('UserData').add({
  //     'usertype': usertype,
  //   });
  // }
}
