
// import 'package:flutter/material.dart';
// import 'package:flutter_compass/flutter_compass.dart';
// import 'dart:math' as math;
//
// import 'package:permission_handler/permission_handler.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatefulWidget {
//   const MyApp({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   bool _hasPermissions = false;
//   CompassEvent? _lastRead;
//   DateTime? _lastReadAt;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _fetchPermissionStatus();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text('Flutter Compass'),
//         ),
//         body: Builder(builder: (context) {
//           if (_hasPermissions) {
//             return Column(
//               children: <Widget>[
//                 _buildManualReader(),
//                 Expanded(child: _buildCompass()),
//               ],
//             );
//           } else {
//             return _buildPermissionSheet();
//           }
//         }),
//       ),
//     );
//   }
//
//   Widget _buildManualReader() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: <Widget>[
//           ElevatedButton(
//             child: const Text('Read Value'),
//             onPressed: () async {
//               final CompassEvent tmp = await FlutterCompass.events!.first;
//               setState(() {
//                 _lastRead = tmp;
//                 _lastReadAt = DateTime.now();
//               });
//             },
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     '$_lastRead',
//                     style: Theme.of(context).textTheme.caption,
//                   ),
//                   Text(
//                     '$_lastReadAt',
//                     style: Theme.of(context).textTheme.caption,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCompass() {
//     return StreamBuilder<CompassEvent>(
//       stream: FlutterCompass.events,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error reading heading: ${snapshot.error}');
//         }
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//
//         double? direction = snapshot.data!.heading;
//
//         // if direction is null, then device does not support this sensor
//         // show error message
//         if (direction == null) {
//           return const Center(
//             child: Text("Device does not have sensors !"),
//           );
//         }
//
//         return Material(
//           shape: const CircleBorder(),
//           clipBehavior: Clip.antiAlias,
//           elevation: 4.0,
//           child: Container(
//             padding: const EdgeInsets.all(16.0),
//             alignment: Alignment.center,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//             ),
//             child: Transform.rotate(
//               angle: (direction * (math.pi / 180) * -1),
//               child: Image.asset(
//                 'assets/compass.png',
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildPermissionSheet() {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           const Text('Location Permission Required'),
//           ElevatedButton(
//             child: const Text('Request Permissions'),
//             onPressed: () {
//               Permission.locationWhenInUse.request().then((ignored) {
//                 _fetchPermissionStatus();
//               });
//             },
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             child: const Text('Open App Settings'),
//             onPressed: () {
//               openAppSettings().then((opened) {
//                 //
//               });
//             },
//           )
//         ],
//       ),
//     );
//   }
//
//   void _fetchPermissionStatus() {
//     Permission.locationWhenInUse.status.then((status) {
//       if (mounted) {
//         setState(() => _hasPermissions = status == PermissionStatus.granted);
//       }
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'compass_screen.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: CompassScreen(),
    );
  }
}
//
// class CompassScreen extends StatefulWidget {
//   const CompassScreen({Key? key}) : super(key: key);
//
//   @override
//   _CompassScreenState createState() => _CompassScreenState();
// }
//
// class _CompassScreenState extends State<CompassScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.yellow[100],
//         body: Builder(builder: (context) {
//           return Column(
//             children: <Widget>[
//               Expanded(child: _buildCompass()),
//             ],
//           );
//         }),
//       ),
//     );
//   }
//
//   Widget _buildCompass() {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     // might need to accound for padding on iphones
//     //var padding = MediaQuery.of(context).padding;
//     return StreamBuilder<CompassEvent>(
//       stream: FlutterCompass.events,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error reading heading: ${snapshot.error}');
//         }
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//
//         double? direction = snapshot.data?.heading;
//
//         // if direction is null, then device does not support this sensor
//         // show error message
//         if (direction == null) {
//           return const Center(
//             child: Text("Device does not have sensors !"),
//           );
//         }
//
//         int ang = (direction.round());
//         return Stack(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(5.0),
//               alignment: Alignment.center,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color(0xFFEBEBEB),
//               ),
//               child: Transform.rotate(
//                 angle: (direction * (math.pi / 180) * -1),
//                 child: Image.asset('assets/compass.png'),
//               ),
//             ),
//             // Center(
//             //   child: Text(
//             //     "$ang",
//             //     style: const TextStyle(
//             //       color: Color(0xFFEBEBEB),
//             //       fontSize: 56,
//             //     ),
//             //   ),
//             // ),
//             Positioned(
//               // center of the screen - half the width of the rectangle
//               left: (width / 2) - ((width / 80) / 2),
//               // height - width is the non compass vertical space, half of that
//               top: (height - width) / 2,
//               child: SizedBox(
//                 width: width / 80,
//                 height: width / 10,
//                 child: Container(
//                   //color: HSLColor.fromAHSL(0.85, 0, 0, 0.05).toColor(),
//                   color: const Color(0xBBEBEBEB),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }