
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:news_app/splash_screen.dart';
import 'package:news_app/src/api_news_custom/Admin/AddCategory.dart';
import 'package:news_app/src/api_news_custom/Admin/Add_author.dart';
import 'package:news_app/src/api_news_custom/Admin/ReportAuthors.dart';
import 'package:news_app/src/api_news_custom/Admin/ReportUsers.dart';
import 'package:news_app/src/api_news_custom/Admin/ShowAuthors.dart';
import 'package:news_app/src/api_news_custom/Admin/ShowUsers.dart';
import 'package:news_app/src/api_news_custom/Author/Add_posts.dart';
import 'package:news_app/src/api_news_custom/Author/Edit_post.dart';
import 'package:news_app/src/api_news_custom/Author/My_posts.dart';
import 'package:news_app/src/api_news_custom/Author/Profile_author.dart';
import 'package:news_app/src/api_news_custom/Author/ShowProfileAuthor.dart';
import 'package:news_app/src/auth/components/login_page.dart';
import 'package:news_app/src/livel_channels/presentation/screens/home_live.dart';
import 'package:news_app/src/news/views/home_news.dart';
import 'package:news_app/src/profile/pages/Profile.dart';

import 'package:news_app/src/weather/pages/home/home_weather.dart';
import 'package:news_app/src/weather/utils/Binding/HomeBinding.dart';

import 'Home.dart';
import 'Home_page.dart';
class AppRoutes {
  AppRoutes._();
  static const initial = '/splashScreen';
  static final routes = [
    GetPage(
        name: '/splashScreen',
        page: () => const SplashScreen(),
        transition: Transition.zoom),
    GetPage(
        name: '/homePage',
        page: () => Home_page(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/home',
        page: () => Home(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/ProfilePage',
        page: () => Profile(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/homeNews',
        page: () => HomeNews(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/login',
        page: () => LoginPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/homeLive',
        page: () => HomeLive(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/ProfileAuthor',
        page: () => ProfileAuthor(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/MyPosts',
        page: () => MyPosts(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/AddPost',
        page: () => AddPost(),
        transition: Transition.fadeIn),

    GetPage(
        name: '/AddAuthor',
        page: () => AddAuthor(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/ShowAuthors',
        page: () => ShowAuthors(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/ShowUsers',
        page: () => ShowUsers(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/ReportUsers',
        page: () => ReportUsers(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/ReportAuthors',
        page: () => ReportAuthors(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/AddCategory',
        page: () => AddCategory(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/homeWeather',
        page: () => HomeWeather(),
      binding: HomeBinding(),
    ),

  ];
}
