import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/src/auth/components/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.red,
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            bool loggedIn = snapshot.data!.getBool('islogin') ?? false;

            return loggedIn ? Home_page() : LoginPage();
          }

          return Center(
              child: Center(
                  child: Lottie.network(
                      'https://assets4.lottiefiles.com/packages/lf20_qmfs6c3i.json')));
        },
      ),

      //Center(child:Lottie.network('https://assets4.lottiefiles.com/packages/lf20_qmfs6c3i.json')
      // Image.asset('assets/flashNews.jpeg')
      //  ),
    );
  }
}
