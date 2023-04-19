// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:praytime/qiblah_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   bool hasPermission = false;
//
//   Future getPermission() async {
//     if (await Permission.location.serviceStatus.isEnabled) {
//       var status = await Permission.location.status;
//       if (status.isGranted) {
//         hasPermission = true;
//       } else {
//         Permission.location.request().then((value) {
//           setState(() {
//             hasPermission = (value == PermissionStatus.granted);
//           });
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: FutureBuilder(
//           builder: (context, snapshot) {
//             if (hasPermission) {
//               return const QiblahScreen();
//             } else {
//               return const Scaffold(
//                 backgroundColor: Color.fromARGB(255, 48, 48, 48),
//               );
//             }
//           },
//           future: getPermission(),
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'screens/homepage.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        backgroundColor: const Color(0xFF7F9D9D),
        scaffoldBackgroundColor: const Color(0xFF7F9D9D),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7F9D9D)
        )
      ),
      home: HomePage(),
    );
  }
}



