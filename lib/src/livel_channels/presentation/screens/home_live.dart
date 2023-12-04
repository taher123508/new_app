import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:news_app/Home_page.dart';
import 'package:sizer/sizer.dart';
import '../../../Currency/pages/home_page.dart';
import '../../data/constants/constants.dart';
import '../component/list_channels.dart';

class HomeLive extends StatefulWidget {
  const HomeLive({Key? key}) : super(key: key);

  @override
  State<HomeLive> createState() => _HomeLiveState();
}

class _HomeLiveState extends State<HomeLive> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(

        bottomNavigationBar: CurvedNavigationBar(
          index: 1,
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => const Home_page()));
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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 15.sp),
            tabs: const [
              Tab(
                text: "ديني",
              ),
              Tab(
                text: "رياضة",
              ),
              Tab(
                text: "أخبار",
              ),
              Tab(
                text: "أطفال",
              ),
            ],
          ),
          title: const Text('البث الحي'),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            ListChannels(
              image: Constants.myListimageQrana,
              url: Constants.myListUrlQrana,
            ),
            ListChannels(
              image: Constants.myListimageSport,
              url: Constants.myListUrlSport,
            ),
            ListChannels(
              image: Constants.myListimageNews,
              url: Constants.myListUrlNews,
            ),
            ListChannels(
              image: Constants.myListimagecheldren,
              url: Constants.myListUrlcheldren,
            ),
          ],
        ),
      ),
    );
  }
}
