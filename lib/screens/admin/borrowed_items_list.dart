import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BorrowedItemList());
}

final CollectionReference _borrowedItems =
    FirebaseFirestore.instance.collection('borrowedItems');

class BorrowedItemList extends StatelessWidget {
  const BorrowedItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Firestore',
      home: FetchBorrowedItemList(),
    );
  }
}

class FetchBorrowedItemList extends StatefulWidget {
  const FetchBorrowedItemList({Key? key}) : super(key: key);

  @override
  _FetchBorrowedItemListState createState() => _FetchBorrowedItemListState();
}

class _FetchBorrowedItemListState extends State<FetchBorrowedItemList> {
  final CollectionReference _borrowedItems =
      FirebaseFirestore.instance.collection('borrowedItems');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrowed Items'),
        backgroundColor: const Color(0xffe9692c),
      ),
      body: StreamBuilder(
        stream: _borrowedItems.snapshots(),
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
                    isThreeLine: true,
                    title: Text(documentSnapshot['propertyNum']),
                    subtitle: Text(documentSnapshot['borrowedBy']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(documentSnapshot['status']),
                        IconButton(
                            icon: const Icon(Icons.delete_sweep),
                            onPressed: () => {
                                  _delete(documentSnapshot.id),

                                  print(documentSnapshot[
                                      'propertyNum']), //terminal
                                  print(documentSnapshot['description'])
                                }),
                        // Column(
                        //   children: [
                        //     Text(documentSnapshot['status']),
                        //   ],
                        // )
                      ],
                    ),

                    // trailing: SizedBox(
                    //   width: 100,
                    //   child: Row(
                    //     children: [
                    //       // IconButton(
                    //       //     icon: const Icon(Icons.edit),
                    //       //     onPressed: () => _update(documentSnapshot)),
                    //       IconButton(
                    //           icon: const Icon(Icons.delete_sweep),
                    //           alignment: const Alignment(15, 0.6),
                    //           onPressed: () => _delete(documentSnapshot.id)),
                    //     ],
                    //   ),
                    // ),
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

Future<void> _delete(String itemId) async {
  await _borrowedItems.doc(itemId).delete();
}
