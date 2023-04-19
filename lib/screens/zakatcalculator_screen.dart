import 'package:flutter/material.dart';

import '../constant.dart';

class ZakatCalculatorScreen extends StatefulWidget {
  @override
  _ZakatCalculatorScreenState createState() => _ZakatCalculatorScreenState();
}

class _ZakatCalculatorScreenState extends State<ZakatCalculatorScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  double wealthAmount = 0;
  double zakatAmount = 0;
  double nisab = 0;
  double zakatRate = 2.5;


  void _calculateZakat() {
    setState(() {
      zakatAmount = wealthAmount >= nisab ? wealthAmount * zakatRate / 100 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zakat Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 4,
          margin: const EdgeInsets.all(10.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF516367),
              // image: DecorationImage(image: AssetImage("assets/card_background.png"), fit: BoxFit.cover)
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Wealth Amount:'),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _textEditingController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: kTextFieldDecoration,
                    onChanged: (value) {
                      setState(() {
                        wealthAmount = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const Text('Nisab Threshold:'),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.number,
                    decoration: kTextFieldDecoration,
                    onChanged: (value) {
                      setState(() {
                        nisab = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _calculateZakat();
                      _focusNode.unfocus();
                      _textEditingController.clear();
                    },
                    child: const Text('Calculate Zakat'),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Text('Zakat Amount:'),
                      Text(
                        '$zakatAmount',
                        style: const TextStyle(fontSize: 30.0),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
