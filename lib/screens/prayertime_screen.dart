import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:praytime/location.dart';

class PrayerTime extends StatefulWidget {
  const PrayerTime({super.key});

  @override
  State<PrayerTime> createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {
  late double latitude = 0;
  late double longitude = 0;
  final TextEditingController _cityController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late String cityName = '';
  late DateTime fajr = DateTime.now();
  late DateTime dhuhr = DateTime.now();
  late DateTime asr = DateTime.now();
  late DateTime maghreb = DateTime.now();
  late DateTime isha = DateTime.now();
  String cityTitle = 'Your Location';
  bool isLoading = true;

  Future getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });
    LocationSc location = LocationSc();
    await location.getCurrentLocation();
    longitude = location.longitude;
    latitude = location.latitude;
    updateUI(latitude, longitude);
    setState(() {
      isLoading = false;
    });
  }

  void getLatLngByCityName() async {
    setState(() {
      isLoading = true;
    });

    List<Location> locations = await locationFromAddress(cityName);
    Location location = locations.first;

    latitude = location.latitude;
    longitude = location.longitude;
    updateUI(latitude, longitude);

    setState(() {
      isLoading = false;
    });
  }

  updateUI(double latitude, double longitude) {
    setState(() {
      isLoading = true; // Set isLoading to true when data is being fetched
    });
    final myCoordinates = Coordinates(latitude, longitude);
    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    setState(() {
      fajr = prayerTimes.fajr;
      dhuhr = prayerTimes.dhuhr;
      asr = prayerTimes.asr;
      maghreb = prayerTimes.maghrib;
      isha = prayerTimes.isha;
      cityTitle = cityName;
      isLoading = false; // Set isLoading to true when data is being fetched
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Prayer Timing',
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _cityController,
              onChanged: (value) {
                cityName = value;
              },
              style: const TextStyle(
                color: Colors.black,
              ),
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Enter City Name',
                filled: true,
                fillColor: Colors.white,
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    getLatLngByCityName();
                    _cityController.clear();
                    _focusNode.unfocus();
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text('Prayer Time in $cityTitle',
              style: const TextStyle(
                  fontSize: 27.0,
                  decorationStyle: TextDecorationStyle.solid,
                  fontWeight: FontWeight.w800,
                  color: Colors.white)),
          const SizedBox(
            height: 10.0,
          ),
          Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 4,
                margin: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF516367),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Center(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: [
                                    PrayerTimeCard(
                                      prayerTimes: fajr,
                                      title: 'Fajar',
                                      iconData: Icons.sunny,
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    PrayerTimeCard(
                                        prayerTimes: dhuhr,
                                        title: 'Dhuhr',
                                        iconData: Icons.sunny),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    PrayerTimeCard(
                                        prayerTimes: asr,
                                        title: 'Asr',
                                        iconData: Icons.sunny_snowing),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    PrayerTimeCard(
                                        prayerTimes: maghreb,
                                        title: 'Maghrib',
                                        iconData: Icons.sunny_snowing),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    PrayerTimeCard(
                                        prayerTimes: isha,
                                        title: 'Isha',
                                        iconData: Icons.sunny_snowing),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Show CircularProgressIndicator if isLoading is true
              if (isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class PrayerTimeCard extends StatelessWidget {
  const PrayerTimeCard(
      {super.key,
      required this.prayerTimes,
      required this.title,
      required this.iconData});

  final DateTime prayerTimes;
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // color: const Color.fromRGBO(10, 91, 144, 1),
      height: 70,
      child: Card(
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),

          subtitle: Text(DateFormat.jm().format(prayerTimes),
              style: const TextStyle(fontSize: 20, color: Colors.white)),
          trailing: Icon(
            iconData,
            color: Colors.yellow,
          ),
          // dense: true,
        ),
      ),
    );
  }
}
