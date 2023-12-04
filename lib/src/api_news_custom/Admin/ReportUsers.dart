
import 'package:flutter/material.dart';
import 'package:news_app/src/api_news_custom/Admin/widget/card_report.dart';
import '../../auth/utility/db_user.dart';
import 'model/ReportAuthor_moode.dart';

class ReportUsers extends StatefulWidget {
  const ReportUsers({Key? key}) : super(key: key);

  @override
  State<ReportUsers> createState() => _ReportUsersState();
}

class _ReportUsersState extends State<ReportUsers> {
  DBUser _dbUser = DBUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('تقارير المستخدمين'),),
      body: Column(
        children: [
          FutureBuilder<List?>(
            future: _dbUser.getReportUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                List Report = snapshot.data! ;

                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Report.length,
                    itemBuilder: (context, index) {
                      final report = Report[index];

                      return CardReport(
                        authorId: report['userId'].toString(),
                        content: report['content'].toString(),
                        dateCreated: report['dateCreated'].toString(),
                        logLevel: report['logLevel'].toString(),
                        role: 'المستخدم',


                      );
                    },
                  ),
                );
              }

              /// handles others as you did on question
              else {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 200,),
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
}
