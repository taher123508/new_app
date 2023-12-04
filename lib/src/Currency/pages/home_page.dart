import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Home_page.dart';
import '../../livel_channels/presentation/screens/home_live.dart';
import '../data/default_values.dart';
import '../util/api_calls.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/buttons_grid.dart';
import '../widgets/currency_pickers.dart';
import '../widgets/value_counter.dart';

class MianCurrency extends StatefulWidget {
  const MianCurrency({Key? key}) : super(key: key);

  @override
  _MianCurrencyState createState() => _MianCurrencyState();
}

class _MianCurrencyState extends State<MianCurrency> {
  @override
  void initState() {
    getRatesFromApi();
    super.initState();
  }

  Map currencyData = {};
  getRatesFromApi() async {
    selectedPrice.value = 0.00;
    Response response = await ApiCalls().getRates(selectedFrom.value);
    currencyData = response.body;
    selectedPrice.value =
        double.parse(currencyData['data'][selectedTo]['value'].toString());
  }

  RxString selectedFrom = 'EUR'.obs;
  RxString selectedTo = 'PLN'.obs;
  RxString ammount = '1'.obs;
  RxDouble selectedPrice = 0.00.obs;

  void changeSelected(bool isFrom, String currency) {
    if (isFrom && selectedFrom.value != currency) {
      selectedFrom.value = currency;
      getRatesFromApi();
    } else if (!isFrom) {
      selectedTo.value = currency;
      selectedPrice.value =
          double.parse(currencyData['data'][selectedTo]['value'].toString());
    }
  }

  void switchCurrencies() {
    String selectedFromTemp = selectedFrom.value;
    selectedFrom.value = selectedTo.value;
    selectedTo.value = selectedFromTemp;
    getRatesFromApi();
  }

  void backspace() {
    if (ammount.value.isNotEmpty) {
      ammount.value = ammount.value.substring(0, ammount.value.length - 1);
    }
  }

  void changeAmmount(String value) {
    int index = ammount.value.indexOf(',');
    if (value == '0' && ammount.value == '0') {
    } else if (ammount.value == '0' && value != ',') {
      ammount.value = value;
    } else if (ammount.value.isEmpty && value == ',') {
      ammount.value = '0,';
    } else if (!ammount.value.contains(',') &&
        value == ',' &&
        ammount.value.isNotEmpty) {
      ammount.value = '${ammount.value}$value';
    } else if (value != '' &&
        ammount.value.contains(',') &&
        ammount.value.length - index < 3) {
      ammount.value = '${ammount.value}$value';
    } else if (value != ',' && !ammount.value.contains(',')) {
      ammount.value = '${ammount.value}$value';
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      appBar: appbarWidget(themeData),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
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


      body: SafeArea(
        child: Padding(
          padding: paddingV1,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              currencyPickers(selectedFrom, selectedTo, switchCurrencies,
                  changeSelected, themeData),
              valueCounter(
                  ammount, selectedFrom, selectedTo, selectedPrice, themeData),
              buttonsGrid(changeAmmount, backspace, themeData),
            ],
          ),
        ),
      ),
    );
  }
}
