import 'package:cl1m_inventory/landing_page.dart';
import 'package:cl1m_inventory/screens/admin/borrowed_items_list.dart';
import 'package:cl1m_inventory/screens/admin/item_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: AdminPage(),
  ));
}

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // children: [
                //   // const Icon(Icons.location_history,
                //   //     color: Colors.white, size: 60.0),
                //   // Image.asset("assets/admin-top.png", width: 60.0)
                // ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "Welcome Admin",
                style: TextStyle(
                    color: Color.fromARGB(225, 21, 21, 21),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [
                    //users
                    SizedBox(
                      width: 150.0,
                      height: 150.0,
                      child: InkWell(
                        onTap: () {
                          //BUTTON ACTION
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ItemList()));
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.inventory_outlined,
                                  size: 75,
                                  color: Color(0xffe9692c),
                                ),
                                Text("Inventory",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    )),
                                SizedBox(height: 5.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // HOME
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
                                      const BorrowedItemList()));
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.archive_outlined,
                                  size: 75,
                                  color: Color(0xffe9692c),
                                ),
                                Text('Borrowed Items',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    )),
                                SizedBox(height: 5.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
