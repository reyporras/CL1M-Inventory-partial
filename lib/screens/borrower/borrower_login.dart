import 'package:cl1m_inventory/reusable_widgets/reusable_widget.dart';
import 'package:cl1m_inventory/screens/borrower/borrower_page.dart';
import 'package:cl1m_inventory/screens/dashboard.dart';
import 'package:cl1m_inventory/screens/register_user.dart';
import 'package:cl1m_inventory/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BorrowerLogin extends StatefulWidget {
  const BorrowerLogin({Key? key}) : super(key: key);

  @override
  _BorrowerLoginState createState() => _BorrowerLoginState();
}

class _BorrowerLoginState extends State<BorrowerLogin> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                  child: Column(
                    children: <Widget>[
                      // logoWidget("assets/images/logo1.png"),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      reusableTextField("Email", Icons.person_outline, false,
                          _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Password", Icons.lock_outline, true,
                          _passwordTextController),
                      const SizedBox(
                        height: 5,
                      ),
                      // forgetPassword(context),
                      firebaseUIButton(context, "Sign In", () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          _passwordTextController.clear();
                          _emailTextController.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BorrowerPage()));
                          print(value);
                          print(value.user!.email);
                          print(value.user!.uid);
                        }).onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Incorrect email or password')));
                          print("Error ${error.toString()}");
                        });
                        getUserData();
                      }),
                      signUpOption()
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

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Color.fromARGB(179, 17, 17, 17))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
                color: Color.fromARGB(179, 17, 17, 17),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Future<void> getUserData() async {
    User user;
    User userData = await FirebaseAuth.instance.currentUser!;
    setState(() {
      user = userData;
      print(userData.uid);
      print(userData.email);
    });
  }

  // Widget forgetPassword(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: 35,
  //     alignment: Alignment.bottomRight,
  //     child: TextButton(
  //       child: const Text(
  //         "Forgot Password?",
  //         style: TextStyle(color: Colors.white70),
  //         textAlign: TextAlign.right,
  //       ),
  //       onPressed: () => Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => ResetPassword())),
  //     ),
  //   );
  // }
}
