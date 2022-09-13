import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BorrowItemList());
}

class BorrowItemList extends StatelessWidget {
  const BorrowItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Firestore',
      home: FetchBorrowItemList(),
    );
  }
}

class FetchBorrowItemList extends StatefulWidget {
  const FetchBorrowItemList({Key? key}) : super(key: key);

  @override
  _FetchBorrowItemListState createState() => _FetchBorrowItemListState();
}

class _FetchBorrowItemListState extends State<FetchBorrowItemList> {
// text fields' controllers
  final TextEditingController _propertyNumController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _acquisitionDateController =
      TextEditingController();
  final TextEditingController _estimatedLifeController =
      TextEditingController();
  final TextEditingController _officeDesignationController =
      TextEditingController();
  final TextEditingController _brandSerialNumController =
      TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _borrowedItemController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  final CollectionReference _availableItems =
      FirebaseFirestore.instance.collection('availableItems');

  final CollectionReference _borrowedItems =
      FirebaseFirestore.instance.collection('borrowedItems');

  final CollectionReference _userData =
      FirebaseFirestore.instance.collection('UserData');

  Future<void> _addBorrowItem([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _propertyNumController.text = documentSnapshot['propertyNum'];
      _descriptionController.text = documentSnapshot['description'];
      _acquisitionDateController.text = documentSnapshot['acquisitionDate'];
      _estimatedLifeController.text = documentSnapshot['estimatedLife'];
      _officeDesignationController.text = documentSnapshot['officeDesignation'];
      _brandSerialNumController.text = documentSnapshot['brandSerialNum'];
      _categoryController.text = documentSnapshot['category'];
      _statusController.text = documentSnapshot['status'];
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        final format = DateFormat('MM-dd-yyyy');
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  enabled: false,
                  controller: _propertyNumController,
                  decoration: const InputDecoration(labelText: 'Property No.'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: InputBorder.none,
                  ),
                  enabled: false,
                ),
                TextField(
                  enabled: false,
                  controller: _categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  enabled: false,
                  controller: _acquisitionDateController,
                  decoration: const InputDecoration(
                    labelText: 'Acquisition Date',
                    border: InputBorder.none,
                  ),
                ),
                TextField(
                  enabled: false,
                  controller: _estimatedLifeController,
                  decoration:
                      const InputDecoration(labelText: 'Estimated Life'),
                ),
                TextField(
                  enabled: false,
                  controller: _officeDesignationController,
                  decoration: const InputDecoration(
                    labelText: 'Office Designation',
                    border: InputBorder.none,
                  ),
                ),
                TextField(
                  enabled: false,
                  controller: _brandSerialNumController,
                  decoration:
                      const InputDecoration(labelText: 'Brand Serial No.'),
                ),
                // TextField(
                //   controller: _statusController,
                //   decoration: const InputDecoration(labelText: 'Item Status'),
                // ),
                DateTimeField(
                  format: format,
                  onShowPicker: ((context, currentValue) async {
                    final date = showDatePicker(
                      context: context,
                      initialDate: currentValue ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xffe9692c),
                              onPrimary: Colors.white,
                              onSurface: Color.fromARGB(225, 21, 21, 21),
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                primary: const Color(0xffe9692c),
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    return date;
                  }),
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
                TextField(
                  controller: _returnDateController,
                  decoration: const InputDecoration(labelText: "Return Date"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xffe9692c),
                              onPrimary: Colors.white,
                              onSurface: Color.fromARGB(225, 21, 21, 21),
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                primary: const Color(0xffe9692c),
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);

                      setState(() {
                        _returnDateController.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Borrow'),
                  onPressed: () async {
                    final String propertyNum = _propertyNumController.text;
                    final String description = _descriptionController.text;
                    final String acquisitionDate =
                        _acquisitionDateController.text;
                    final String estimdatedLife = _estimatedLifeController.text;
                    final String officeDesignation =
                        _officeDesignationController.text;
                    final String brandSerialNum =
                        _brandSerialNumController.text;
                    final String returnDate = _returnDateController.text;
                    final String date = _dateController.text;
                    final String category = _categoryController.text;
                    const String status = 'Borrowed';
                    final String? _email =
                        FirebaseAuth.instance.currentUser!.email;

                    if (description != null) {
                      await _borrowedItems.add({
                        "propertyNum": propertyNum,
                        "description": description,
                        "acquisitionDate": acquisitionDate,
                        "estimatedLife": estimdatedLife,
                        "officeDesignation": officeDesignation,
                        "brandSerialNum": brandSerialNum,
                        "returnDate": returnDate,
                        "dateBorrowed": date,
                        "borrowedBy": _email,
                        "category": category,
                        "status": status,
                      });

                      _propertyNumController.text = '';
                      _descriptionController.text = '';
                      _acquisitionDateController.text = '';
                      _estimatedLifeController.text = '';
                      _officeDesignationController.text = '';
                      _brandSerialNumController.text = '';
                      _returnDateController.text = '';
                      _dateController.text = '';
                      _categoryController.text = '';

                      Navigator.of(context).pop();
                    }
                    // FirebaseFirestore.instance.collection('UserData').get().then(
                    //       (value) => value.docs.forEach(
                    //         (element) {
                    //           var docRef = FirebaseFirestore.instance
                    //               .collection('UserData')
                    //               .doc(FirebaseAuth.instance.currentUser!.uid);

                    //           docRef.update({'itemBorrowed': description});
                    //         },
                    //       ),
                    //     );
                    FirebaseFirestore.instance
                        .collection('UserData')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('borrowedItems')
                        .add({
                      "propertyNum": propertyNum,
                      "description": description,
                      "category": category,
                      "date": date,
                      "returnDate": returnDate
                    });
                    FirebaseFirestore.instance
                        .collection('availableItems')
                        .doc(documentSnapshot!.id)
                        .update({"status": 'Unavailable'});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Item added to list of borrowed items.'),
                      ),
                    );
                    //_delete(documentSnapshot!.id);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(String itemId) async {
    await _availableItems.doc(itemId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Item added successfully to list of borrowed items.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrow item'),
        backgroundColor: const Color.fromARGB(225, 21, 21, 21),
      ),
      body: StreamBuilder(
        stream: _availableItems.snapshots(),
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
                    subtitle: Text(documentSnapshot['description']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(documentSnapshot['status']),
                        IconButton(
                            icon: const Icon(Icons.archive_outlined),
                            onPressed: () => {
                                  _addBorrowItem(documentSnapshot),

                                  print(documentSnapshot[
                                      'propertyNum']), //terminal
                                  print(documentSnapshot['description'])
                                }),
                      ],
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
