import 'package:flutter/material.dart';
import 'package:news_app/src/api_news_custom/Admin/widget/Show_card_authors.dart';
import 'package:news_app/src/api_news_custom/Admin/widget/Show_card_users.dart';
import 'package:news_app/src/api_news_custom/Admin/widget/card_report.dart';
import '../../auth/utility/db_user.dart';
import 'model/ReportAuthor_moode.dart';

class ShowUsers extends StatefulWidget {
  const ShowUsers({Key? key}) : super(key: key);

  @override
  State<ShowUsers> createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
  DBUser _dbUser = DBUser();

  List? filteredList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    var  filteredList3 = await _dbUser.getUsers() as List;
    setState(() {
      filteredList=filteredList3;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(' المستخدمين'),
      ),
      body: Column(
        children: [

          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blue.shade100, // لون الحاشية
                width: 1.0, // سمك الحاشية
              ),),
            width: size.width * 0.9,
            height: size.height*0.07,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            child: TextField(
              onChanged: _filterData,
              decoration: InputDecoration(
                labelText: 'بحث',
                prefixIcon: Icon(Icons.search),


              ),
            ),
          ),
          FutureBuilder<List?>(
            future: _dbUser.getUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                List Report = snapshot.data!;



                return ShowCardUsers(data:filteredList! );
              }

              /// handles others as you did on question
              else {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                        ),
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        )
                      ]),
                );
              }
            },
          )
        ],
      ),
    );
  }
  void _filterData(String query)async {
    var    filteredList1 = await _dbUser.getUsers()as List;
    setState(()  {

      filteredList= filteredList1.where((data) =>
          data['displayName'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
