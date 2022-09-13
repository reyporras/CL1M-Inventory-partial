import 'package:cl1m_inventory/screens/borrower/borrow/item_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Borrow(),
    );
  }
}

class Borrow extends StatefulWidget {
  const Borrow({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();

  static fromJson(e) {}
}

class _MyHomePageState extends State<Borrow> {
  // By defaut, the checkbox is unchecked and "agree" is "false"
  bool agree = false;

  // This function is triggered when the button is clicked
  void _doSomething() {
    // Do something
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrow Page'),
        backgroundColor: const Color.fromARGB(225, 21, 21, 21),
      ),
      body: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        title: const Text('Terms & Conditions'),
        scrollable: true,
        content: RichText(
          textAlign: TextAlign.justify,
          text: const TextSpan(
            text:
                'The following Terms & Conditions are considered mandatory:\n',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '\nInsurance:\n',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: """
    1.) Equipment must be returned in good order and must be devoid of permanent damage including but not limited to structural damage and markings beyond reasonable wear and tear, as determined by the Personnel.
    2.) The Borrower is responsible for the full cost of repair or replacement of any or all of the “Equipment” that is damaged, lost, confiscated, or stolen from the time the Borrower assumes custody until its return to the Personnel at expiry of this agreement.\n""",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              TextSpan(
                text: '\nForce Majeure:\n',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    "The Borrower is not responsible to Personnel for any loss or damage if occasioned by fire, flood, explosion, or any other cause beyond the reasonable control of the Borrower.\n",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              TextSpan(
                text:
                    '\nIf the Borrower fails to uphold any of the items above, this agreement may be revoked, associated cost penalties may be enforced, and the Borrower may be ineligible to submit future inquiries.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffe9692c),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'CANCEL',
              style: TextStyle(fontSize: 15),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffe9692c),
            ),
            onPressed: () {
              agree ? _doSomething : null;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FetchBorrowItemList(),
                ),
              );
            },
            child: const Text(
              'ACCEPT',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
