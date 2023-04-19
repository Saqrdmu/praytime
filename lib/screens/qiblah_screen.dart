import 'package:flutter/material.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';


class QiblahScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SmoothCompass(
          isQiblahCompass: true,
          compassBuilder: (context, snapshot, child) {
            return AnimatedRotation(
              turns: snapshot?.data?.turns ?? 0 / 360,
              duration: const Duration(milliseconds: 400),
              child: SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        'assets/compass.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      bottom: 20,
                      child: AnimatedRotation(
                          turns: (snapshot?.data?.qiblahOffset ?? 0) / 360,
                          duration: const Duration(milliseconds: 400),
                          child: Image.asset(
                            'assets/com.png',
                            fit: BoxFit.fitHeight,
                          )),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
