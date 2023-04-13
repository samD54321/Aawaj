import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_try/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  bool waveAnimated = false;
  bool animateWaveText = false;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(vsync: this);
    _waveController.addListener(() {
      if (_waveController.value > 0.7) {
        _waveController.stop();
        waveAnimated = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          animateWaveText = true;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _waveController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: context.canvasColor,
      body: Stack(
        children: [
          // White Container top half
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: waveAnimated ? screenHeight / 1.9 : screenHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(waveAnimated ? 40.0 : 0.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: !waveAnimated,
                  child: Lottie.asset(
                    'assets/aawaj_splash.json',
                    repeat: false,
                    controller: _waveController,
                    onLoaded: (composition) {
                      _waveController
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),
                ),
                Visibility(
                  visible: waveAnimated,
                  child: Image.asset(
                    'assets/logos/aawaj_logo.png',
                    height: 190.0,
                    width: 190.0,
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: animateWaveText ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    child: Text(
                      "Aawaj",
                      style: context.textTheme.displayLarge,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Text bottom part
          Visibility(visible: waveAnimated, child: const _BottomPart()),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Aawaj: A voice for the voiceless',
              style: GoogleFonts.montserrat(
                  fontSize: 27,
                  color: context.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30.0),
            Text(
              'Nepali Text-to-Speech (TTS) service with augmentative communication support',
              style: GoogleFonts.montserrat(
                fontSize: 15.0,
                color: context.primaryColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 50.0),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.handsRoute);
                },
                child: Container(
                  height: 40.0,
                  width: 180.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: context.primaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Open Aawaj",
                        style: GoogleFonts.montserrat(
                          fontSize: 15.0,
                          color: context.primaryColor,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        color: context.primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
