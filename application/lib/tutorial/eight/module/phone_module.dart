import 'package:flutter/material.dart';

class PhonePad extends StatefulWidget {
  const PhonePad({Key? key}) : super(key: key);
  @override
  PhonePadState createState() => PhonePadState();
}

class PhonePadState extends State<PhonePad> {
  final TextEditingController _phoneNumberController = TextEditingController();

  String _enteredNumber = '';

  @override
  Widget build(BuildContext context) {
    Widget empty = ElevatedButton(
      onPressed: () {},
      child: const Text(""),
    );

    Widget call = ElevatedButton(
      onPressed: () {
        _handleCall();
      },
      child: const Text('Call'),
    );
    Widget backspace = ElevatedButton(
      onPressed: () {
        _handleBackspace();
      },
      child: const Icon(Icons.backspace),
    );

    Widget asterisk = ElevatedButton(
      onPressed: () {},
      child: const Text("*"),
    );

    Widget hash = ElevatedButton(
      onPressed: () {},
      child: const Text("#"),
    );

    Widget key(int k) {
      return ElevatedButton(
        onPressed: () {
          _handleNumericInput(k);
        },
        child: Text(k.toString()),
      );
    }

    // These are the numeric buttons
    final List<Widget> keypad = [
      [key(1), key(2), key(3)],
      [key(4), key(5), key(6)],
      [key(7), key(8), key(9)],
      [asterisk, key(0), hash],
      [empty, call, backspace]
    ].expand((x) => x).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Disable back button
        title: Focus(
          child: Semantics(
            focused: true, // Indicate that this widget is focused
            child: const Text(
              "tutorial8_lesson_title",
              semanticsLabel: "tutorial8",
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Entered Number: $_enteredNumber',
            style: const TextStyle(fontSize: 24),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) =>
                  index < keypad.length ? keypad[index] : null,
            ),
          ),
        ],
      ),
    );
  }

  void _handleNumericInput(int digit) {
    setState(() {
      _enteredNumber += digit.toString();
    });
  }

  void _handleCall() {
    // Check if the entered number matches the expected number
    String expectedNumber = '1234567890'; // Replace with the expected number
    if (_enteredNumber == expectedNumber) {
      // Call successful
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Call Successful'),
          content: Text('You have successfully called the number.'),
        ),
      );
    } else {
      // Call failed
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Call Failed'),
          content: Text('Please enter the correct phone number and try again.'),
        ),
      );
    }
  }

  void _handleBackspace() {
    setState(() {
      if (_enteredNumber.isNotEmpty) {
        _enteredNumber = _enteredNumber.substring(0, _enteredNumber.length - 1);
      }
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }
}

void main() => runApp(const MaterialApp(home: PhonePad()));
