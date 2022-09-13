import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ReturnItemList());
}

class ReturnItemList extends StatelessWidget {
  const ReturnItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Firestore',
      home: FetchReturnItemList(),
    );
  }
}

class FetchReturnItemList extends StatefulWidget {
  const FetchReturnItemList({Key? key}) : super(key: key);

  @override
  _FetchReturnItemListState createState() => _FetchReturnItemListState();
}

class _FetchReturnItemListState extends State<FetchReturnItemList> {
  final CollectionReference _userBorrowedItems = FirebaseFirestore.instance
      .collection('UserData')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('borrowedItems');

  final CollectionReference _borrowedItems =
      FirebaseFirestore.instance.collection('borrowedItems');

  Future<void> _deleteUserBorrow(String id) async {
    await _userBorrowedItems.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return'),
        backgroundColor: const Color(0xffe9692c),
      ),
      body: StreamBuilder(
        stream: _userBorrowedItems.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['propertyNum']),
                    subtitle: Text(documentSnapshot['description']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              icon:
                                  const Icon(Icons.assignment_return_outlined),
                              onPressed: () => {
                                    // FirebaseFirestore.instance
                                    //     .collection('borrowedItems')
                                    //     .where('propertyNum',
                                    //         isEqualTo: streamSnapshot
                                    //             .data!.docs[index]),
                                    _deleteUserBorrow(documentSnapshot.id),
                                    print(documentSnapshot[
                                        'propertyNum']), //terminal
                                    print(documentSnapshot['description'])
                                  }),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
