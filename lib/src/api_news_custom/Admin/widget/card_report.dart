import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/auth/utility/db_user.dart';
class CardReport extends StatefulWidget {
  final String logLevel;
  final String content;
  final String authorId;
  final String dateCreated;
  final String role;


  CardReport({
    Key? key,
    required this.content,
    required this.authorId,
    required this.dateCreated,
    required this.logLevel,
    required this.role,

  }) : super(key: key);

  @override
  _CardReportState createState() => _CardReportState();
}

class _CardReportState extends State<CardReport> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.dateCreated);
    String formattedTime = DateFormat.MMMEd().format(dateTime);
    return Container(
      child: Card(
        color: widget.logLevel=='0'?Colors.red:widget.logLevel=='1'?Colors.amber:Colors.green,
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('التاريخ',style: TextStyle(color: Colors.white),),
                          Text(formattedTime,style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    Column(
                      children: [
                        Text('رقم '+ widget.role,style: TextStyle(color: Colors.white),),
                        Text(widget.authorId,style: TextStyle(color: Colors.white),),
                      ],
                    ),

                    ],
                  ),
                  Column(
                    children: [
                      Divider(thickness: 1.5,color: Colors.black38),
                      Text(widget.content,style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}