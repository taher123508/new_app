
import 'package:flutter/material.dart';
import 'package:news_app/src/livel_channels/data/constants/constants.dart';
import 'package:news_app/src/livel_channels/presentation/component/screen_live.dart';

class ListChannels extends StatelessWidget {
   ListChannels({Key? key , required this.image, required this.url}) : super(key: key);
final List<String> image;
final List<String> url;
bool islood=false;


  @override

  Widget build(BuildContext context) {
     //Future.delayed(const Duration(seconds: 2));

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return  Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(20),

      child: GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20),
          itemCount: url.length,
          itemBuilder: (BuildContext ctx, int index) {
            return InkWell(

              onTap: () {


                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Screen_live(url[index])));


              },
              child: Container(



                width: w * 15,
                height: h * 0.01,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
image: DecorationImage(image: NetworkImage(image[index],),fit: BoxFit.cover)

                ),
              ),
            );
          }),
    );
  }
}
