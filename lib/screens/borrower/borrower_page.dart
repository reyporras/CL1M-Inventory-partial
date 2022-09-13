import 'package:cl1m_inventory/landing_page.dart';
import 'package:cl1m_inventory/screens/borrower/borrow/borrow.dart';
import 'package:cl1m_inventory/screens/borrower/borrower_login.dart';
import 'package:cl1m_inventory/screens/borrower/return/borrowed_item_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//import 'dashboard.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BorrowerPage(),
  ));
}

class BorrowerPage extends StatelessWidget {
  const BorrowerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xffe9692c),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            print("Signed Out");
            Navigator.pop(context);
          });
        },
        label: const Text('Log out'),
        icon: const Icon(Icons.logout),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("CL1M INVENTORY"),
        backgroundColor: const Color.fromARGB(225, 21, 21, 21),
      ),
      backgroundColor: const Color(0xffffdead),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // children: [
                  //   const Icon(Icons.menu, color: Colors.white, size: 60.0),
                  //   Image.asset("assets/inventory.png", width: 60.0)
                  // ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Dashboard",
                  style: TextStyle(
                      color: Color.fromARGB(225, 21, 21, 21),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Center(
                  child: Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: [
                      SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: InkWell(
                          onTap: () {
                            //BUTTON ACTION
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Borrow()));
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Image.asset("assets/bo.png", width: 64.0),
                                  const SizedBox(height: 10.0),
                                  const Text("Borrow",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      )),
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: InkWell(
                          onTap: () {
                            //BUTTON ACTION
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ReturnItemList()));
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Image.asset("assets/return.png", width: 64.0),
                                  const SizedBox(height: 10.0),
                                  const Text("Return",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      )),
                                  const SizedBox(height: 5.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: InkWell(
                            // onTap: () {
                            //   //BUTTON ACTION
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => const BorrowForm()));
                            // },
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
