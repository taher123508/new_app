import 'package:flutter/material.dart';

import 'package:news_app/src/auth/components/common/Card_news_display.dart';

import 'package:news_app/src/auth/utility/Datanews.dart';
import 'package:news_app/src/auth/utility/db_user.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DBUser _dbUser = DBUser();
  List? data, data1, data2, data3;
  bool islood = false;
  bool islooddata = false;
  List values = [
    {"id": 1, "categoryName": "رياضة"},
    {"id": 2, "categoryName": "سياسي"},
    {"id": 3, "categoryName": "عسكري"},
  ];

  // القيمة المحددة افتراضيًا
  int selectedValue = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataTabs();
    getCategory();
  }

  Future<void> getCategory() async {
    var data = await _dbUser.getCategory();
    setState(() {
      print(data);
      values = data!;
    });
  }

  Future<void> getDataTabs() async {
    var d = await _dbUser.getNews() as List<Article>;

    setState(() {
      data = d;
      data1 = d.where((element) => element.categoryId == 1).toList();
      data2 = d.where((element) => element.categoryId == 2).toList();
      data3 = d.where((element) => element.categoryId == 3).toList();
      islooddata = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(

         animationDuration: Duration(seconds: 1),
        length: 4, // عدد علامات التبويب
        child: Column(children: [
          TabBar(
            labelColor: Colors.blue,

            // علامات التبويب
            tabs: [
              Tab(text: 'الكل',),
              Tab(text: 'عسكري'),
              Tab(text: 'سياسي'),
              Tab(text: 'أخرى'),
            ],
          ),
          Expanded(
              child: islooddata
                  ? TabBarView(

                      children: [
                        RefreshIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.blue,
                          strokeWidth: 4.0,
                          onRefresh: () async {
                            var articles1 =
                                await _dbUser.getNews() as List<Article>;
                            setState(() {
                              islood = true;
                              data = articles1;
                              data1 = articles1
                                  .where((element) => element.categoryId == 1)
                                  .toList();
                              data2 = articles1
                                  .where((element) => element.categoryId == 2)
                                  .toList();
                              data3 = articles1
                                  .where((element) => element.categoryId == 3)
                                  .toList();
                            });
                            // Replace this delay with the code to be executed during refresh
                            // and return a Future when code finishes execution.
                            return Future<void>.delayed(
                                const Duration(seconds: 2));
                          },
                          child: Column(
                            children: [
                              PersonCard(articles: data as List<Article>),
                            ],
                          ),
                        ),
                        RefreshIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.blue,
                          strokeWidth: 4.0,
                          onRefresh: () async {
                            var articles1 =
                                await _dbUser.getNews() as List<Article>;
                            setState(() {
                              islood = true;
                              data = articles1;
                              data1 = articles1
                                  .where((element) => element.categoryId == 1)
                                  .toList();
                              data2 = articles1
                                  .where((element) => element.categoryId == 2)
                                  .toList();
                              data3 = articles1
                                  .where((element) => element.categoryId == 3)
                                  .toList();
                            });
                            // Replace this delay with the code to be executed during refresh
                            // and return a Future when code finishes execution.
                            return Future<void>.delayed(
                                const Duration(seconds: 2));
                          },
                          child: Column(
                            children: [
                              PersonCard(articles: data1 as List<Article>),
                            ],
                          ),
                        ),
                        RefreshIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.blue,
                          strokeWidth: 4.0,
                          onRefresh: () async {
                            var articles1 =
                                await _dbUser.getNews() as List<Article>;
                            setState(() {
                              islood = true;
                              data = articles1;
                              data1 = articles1
                                  .where((element) => element.categoryId == 1)
                                  .toList();
                              data2 = articles1
                                  .where((element) => element.categoryId == 2)
                                  .toList();
                              data3 = articles1
                                  .where((element) => element.categoryId == 3)
                                  .toList();
                            });
                            // Replace this delay with the code to be executed during refresh
                            // and return a Future when code finishes execution.
                            return Future<void>.delayed(
                                const Duration(seconds: 2));
                          },
                          child: Column(
                            children: [
                              PersonCard(articles: data2 as List<Article>),
                            ],
                          ),
                        ),
                        RefreshIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.blue,
                          strokeWidth: 4.0,
                          onRefresh: () async {
                            var articles1 =
                                await _dbUser.getNews() as List<Article>;
                            setState(() {
                              islood = true;
                              data = articles1;
                              data1 = articles1
                                  .where((element) => element.categoryId == 1)
                                  .toList();
                              data2 = articles1
                                  .where((element) => element.categoryId == 2)
                                  .toList();
                              data3 = articles1
                                  .where((element) => element.categoryId == 3)
                                  .toList();
                            });
                            // Replace this delay with the code to be executed during refresh
                            // and return a Future when code finishes execution.
                            return Future<void>.delayed(
                                const Duration(seconds: 2));
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(20)),
                                margin: EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                width: size.width * 0.9,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 3),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: selectedValue
                                        .toString(), // القيمة المحددة
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedValue = int.parse(newValue!);
                                        data3 = data!
                                            .where((element) =>
                                                element.categoryId ==
                                                selectedValue)
                                            .toList();
                                        print(selectedValue);

                                        // تحديث القيمة المحددة
                                      });
                                    },
                                    items: values.map((value) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.centerRight,
                                        value: value['id'].toString(),
                                        child: Center(
                                            child: Text(
                                          value['categoryName'],
                                          style: TextStyle(fontSize: 18),
                                        )),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              PersonCard(articles: data3 as List<Article>),
                            ],
                          ),
                        ),
                      ],
                    )
                  : TabBarView(children: [
                      Center(child: CircularProgressIndicator()),
                      Center(child: CircularProgressIndicator()),
                      Center(child: CircularProgressIndicator()),
                      Center(child: CircularProgressIndicator()),
                    ]))
        ]));
  }
}
