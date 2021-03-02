import 'dart:io';
import 'package:butom_navbar/buttom_bar.dart';
import 'package:flutter/material.dart';
import 'package:butom_navbar/onboarding/data.dart';
import 'package:butom_navbar/patient//home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Onboarding",
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SliderModel> slides = new List<SliderModel>();
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides = getSlides();
  }

  Widget pageIndexIndicator(bool isCurrentPage) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
          color: isCurrentPage ? Colors.grey : Colors.grey[300],
          borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: slides.length,
        onPageChanged: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        itemBuilder: (context, index) {
          return SliderTitle(
            imageAssetPath: slides[index].getImageAssetPath(),
            title: slides[index].getTitle(),
            desc: slides[index].getDesc(),
          );
        },
      ),
      bottomSheet: currentIndex != slides.length - 1
          ? Container(
        height: Platform.isAndroid ? 90 : 80,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
                onTap: () {
                  pageController.animateToPage(slides.length - 1,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.linear);
                },
                child: Text("SKIP",style: TextStyle(
                    fontSize: 20
                ),)),
            Row(
              children: <Widget>[
                for (int i = 0; i < slides.length; i++)
                  currentIndex == i
                      ? pageIndexIndicator(true)
                      : pageIndexIndicator(false)
              ],
            ),
            InkWell(
                onTap: () {
                  pageController.animateToPage(currentIndex + 1,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.linear);
                },
                child: Text("NEXT",style: TextStyle(
                    fontSize: 20
                ),)),
          ],
        ),
      )
          : GestureDetector(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffC0C0E4),
          height: Platform.isAndroid ? 90 : 80,
          child: Text(
            "GET STARTED NOW",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
        onTap: (){
          try{
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Navbar()),);
          }
          catch(e){

          }
        },
      ),
    );
  }
}

class SliderTitle extends StatelessWidget {
  String imageAssetPath, title, desc;
  SliderTitle({this.imageAssetPath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imageAssetPath),
          SizedBox(
            height: 20,
          ),
          Text(title),
          SizedBox(
            height: 12,
          ),
          Text(desc),
        ],
      ),
    );
  }
}