import 'package:flutter/material.dart';
import 'package:praytime/screens/prayertime_screen.dart';
import 'package:praytime/screens/qiblah_screen.dart';
import 'package:praytime/screens/zakatcalculator_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'halalfoodscreen.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeCard(
                  title: 'Compass',
                  iconData: FontAwesomeIcons.compass,
                  voidCallback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QiblahScreen(),
                        ));
                  },
                ),
                HomeCard(
                  title: 'Pray Time',
                  iconData: FontAwesomeIcons.mosque,
                  voidCallback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrayerTime(),
                        ));
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeCard(
                  title: 'Zakat Calculator',
                  iconData: FontAwesomeIcons.calculator,
                  voidCallback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ZakatCalculatorScreen(),
                        ));
                  },
                ),
                HomeCard(
                  title: 'Halal Food',
                  iconData: FontAwesomeIcons.apple,
                  voidCallback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HalalFoodScreen(),
                        ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback voidCallback;
  HomeCard(
      {required this.title,
      required this.iconData,
      required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: voidCallback,
        child: Container(
          height: 115,
          width: 143,
          decoration: BoxDecoration(
            color: const Color(0xFF516367),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 50.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      fontFamily: 'roboto'),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
