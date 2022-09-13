import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ItemList());
}

class ItemList extends StatelessWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Firestore',
      home: FetchItemList(),
    );
  }
}

class FetchItemList extends StatefulWidget {
  const FetchItemList({Key? key}) : super(key: key);

  @override
  _FetchItemListState createState() => _FetchItemListState();
}

class _FetchItemListState extends State<FetchItemList> {
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
  final TextEditingController _statusController = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('items');
  final CollectionReference _availableItems =
      FirebaseFirestore.instance.collection('availableItems');

  Future<void> addItem([DocumentSnapshot? documentSnapshot]) async {
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
                    controller: _propertyNumController,
                    decoration: const InputDecoration(labelText: 'Property No'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: _categoryController,
                    decoration: const InputDecoration(labelText: 'Category'),
                  ),
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
                    controller: _acquisitionDateController,
                    decoration:
                        const InputDecoration(labelText: 'Acquisition Date'),
                  ),
                  TextField(
                    controller: _estimatedLifeController,
                    decoration:
                        const InputDecoration(labelText: 'Estimated Life'),
                  ),
                  TextField(
                    controller: _officeDesignationController,
                    decoration:
                        const InputDecoration(labelText: 'Office Designation'),
                  ),
                  TextField(
                    controller: _brandSerialNumController,
                    decoration:
                        const InputDecoration(labelText: 'Brand Serial No'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffe9692c),
                      onPrimary: Colors.white,
                    ),
                    child: const Text('Create'),
                    onPressed: () async {
                      final String propertyNum = _propertyNumController.text;
                      final String description = _descriptionController.text;
                      final String category = _categoryController.text;
                      final String acquisitionDate =
                          _acquisitionDateController.text;
                      final String estimdatedLife =
                          _estimatedLifeController.text;
                      final String officeDesignation =
                          _officeDesignationController.text;
                      final String brandSerialNum =
                          _brandSerialNumController.text;
                      const String status = 'Available';
                      if (description != null && propertyNum != null) {
                        await _items.add({
                          "propertyNum": propertyNum,
                          "description": description,
                          "category": category,
                          "acquisitionDate": acquisitionDate,
                          "estimatedLife": estimdatedLife,
                          "officeDesignation": officeDesignation,
                          "brandSerialNum": brandSerialNum,
                        });

                        await _availableItems.add({
                          "propertyNum": propertyNum,
                          "description": description,
                          "category": category,
                          "acquisitionDate": acquisitionDate,
                          "estimatedLife": estimdatedLife,
                          "officeDesignation": officeDesignation,
                          "brandSerialNum": brandSerialNum,
                          "status": status,
                        });

                        _propertyNumController.text = '';
                        _descriptionController.text = '';
                        _categoryController.text = '';
                        _acquisitionDateController.text = '';
                        _estimatedLifeController.text = '';
                        _officeDesignationController.text = '';
                        _brandSerialNumController.text = '';
                        // _statusController.text = 'Available';
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  // Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
  //   if (documentSnapshot != null) {
  //     _propertyNumController.text = documentSnapshot['propertyNum'];
  //     _descriptionController.text = documentSnapshot['description'].toString();
  //   }

  //   await showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //               top: 20,
  //               left: 20,
  //               right: 20,
  //               bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               TextField(
  //                 controller: _propertyNumController,
  //                 decoration: const InputDecoration(labelText: 'propertyNum'),
  //               ),
  //               TextField(
  //                 keyboardType:
  //                     const TextInputType.numberWithOptions(decimal: true),
  //                 controller: _descriptionController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'description',
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               ElevatedButton(
  //                 child: const Text('Update'),
  //                 onPressed: () async {
  //                   final String propertyNum = _propertyNumController.text;
  //                   final double? description =
  //                       double.tryParse(_descriptionController.text);
  //                   if (description != null) {
  //                     await _items
  //                         .doc(documentSnapshot!.id)
  //                         .update({"propertyNum": propertyNum, "description": description});
  //                     _propertyNumController.text = '';
  //                     _descriptionController.text = '';
  //                     Navigator.of(context).pop();
  //                   }
  //                 },
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }

  Future<void> _delete(String itemId) async {
    await _items.doc(itemId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully deleted an item')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Item Inventory'),
            backgroundColor: const Color.fromARGB(225, 21, 21, 21)),
        body: StreamBuilder(
          stream: _items.snapshots(),
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
                      subtitle:
                          Text(documentSnapshot['description'].toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            // IconButton(
                            //     icon: const Icon(Icons.edit),
                            //     onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete_sweep),
                                onPressed: () => _delete(documentSnapshot.id)),
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
// Add new item
        floatingActionButton: FloatingActionButton(
          onPressed: () => addItem(),
          backgroundColor: const Color(0xffe9692c),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
