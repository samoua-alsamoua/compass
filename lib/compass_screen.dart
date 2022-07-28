import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_compass/flutter_compass.dart';

class CompassScreen extends StatelessWidget {
  const CompassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Expanded(child: _buildCompass(context)),
          ],
        );
      }),
    );
  }

  Widget _buildCompass(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // might need to accound for padding on iphones
    //var padding = MediaQuery.of(context).padding;
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data?.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text("Device does not have sensors !"),
          );
        }

        int ang = (direction.round());
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEBEBEB),
              ),
              child: Transform.rotate(
                angle: (direction * (math.pi / 180) * -1),
                child: Image.asset('assets/compass.png'),
              ),
            ),
            // Center(
            //   child: Text(
            //     "$ang",
            //     style: const TextStyle(
            //       color: Color(0xFFEBEBEB),
            //       fontSize: 56,
            //     ),
            //   ),
            // ),
            Positioned(
              // center of the screen - half the width of the rectangle
              left: (width / 2) - ((width / 80) / 2),
              // height - width is the non compass vertical space, half of that
              top: (height - width) / 2,
              child: SizedBox(
                width: width / 80,
                height: width / 10,
                child: Container(
                  //color: HSLColor.fromAHSL(0.85, 0, 0, 0.05).toColor(),
                  color: const Color(0xBBEBEBEB),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
