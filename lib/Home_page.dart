import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:news_app/drawer.dart';
import 'package:news_app/src/Currency/pages/home_page.dart';
import 'package:news_app/src/api_news_custom/Admin/Home_Admin.dart';
import 'package:news_app/src/api_news_custom/Author/Home_Author.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
import 'src/livel_channels/presentation/screens/home_live.dart';

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  //page active
  Widget? current = const Home();

  var internetStatus = 'لا يوجد اتصال بالإنترنت';
  String role = 'user';

  @override
  void initState() {
    super.initState();
    checkUserRole();
    _checkInternetConnection();
    // استماع لتغييرات حالة الاتصال بالإنترنت
    Connectivity().onConnectivityChanged.listen((result) {
      _checkInternetConnection();
    });
  }

  void _checkInternetConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        internetStatus = 'متصل';
      });
    } else {
      setState(() {
        internetStatus = 'جاري اتصال  ';
      });
    }
  }

  Future<void> checkUserRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userRole = await preferences
        .getString('roles'); // استبدل 'user_role' بالمفتاح الصحيح لدور المستخدم
    setState(() {
      role = userRole!; // استبدل 'كاتب' بالقيمة التي تمثل دور الكاتب
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(internetStatus),
      ),
      drawer: role == 'User'
          ? Drawer_home()
          : role == 'Admin'
              ? const HomeAdmin()
              : const HomeAuthor(),

      //Navigation bar the package
      bottomNavigationBar: CurvedNavigationBar(
        height: 80,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home),
            label: 'الأخبار',
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.live_tv_outlined,
            ),
            label: 'بث حي',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.monetization_on),
            label: 'سعرالصرف',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.sunny_snowing),
            label: 'الطقس',
          ),
        ],
        onTap: (index) {
          setState(()  {
            switch (index) {
              case 0:
                current = const Home();
                //   Navigator.pushNamed(context, '/home');
                break;

              case 1:
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const HomeLive()));

                break;
              case 2:
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MianCurrency()));
                break;
              case 3:
                Get.offAndToNamed('/homeWeather');

                break;
            }
          });
        },
      ),
      body: current,
    );
  }
}
