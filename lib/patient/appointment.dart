import 'package:butom_navbar/patient/appointment/dental.dart';
import 'package:flutter/material.dart';

class Appointment_user extends StatefulWidget {
  @override
  _Appointment_userState createState() => _Appointment_userState();
}

class _Appointment_userState extends State<Appointment_user> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  // void getPostsData() {
  //   List<dynamic> responseList = FOOD_DATA;
  //   List<Widget> listItems = [];
  //   responseList.forEach((post) {
  //     listItems.add(Container(
  //         height: 150,
  //         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //         decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
  //           BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
  //         ]),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(
  //                     post["name"],
  //                     style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  //                   ),
  //                   Text(
  //                     post["brand"],
  //                     style: const TextStyle(fontSize: 17, color: Colors.grey),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     "\$ ${post["price"]}",
  //                     style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
  //                   )
  //                 ],
  //               ),
  //               Image.asset(
  //                 "assets/images/${post["image"]}",
  //                 height: double.infinity,
  //               )
  //             ],
  //           ),
  //         )));
  //   });
  //   setState(() {
  //     itemsData = listItems;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getPostsData();
    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.black,
        ),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Appointment",
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text("Category")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer?0:1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: size.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer?0:categoryHeight,
                    child: categoriesScroller),
              ),
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        if (topContainer > 0.5) {
                          scale = index + 0.5 - topContainer;
                          if (scale < 0) {
                            scale = 0;
                          } else if (scale > 1) {
                            scale = 1;
                          }
                        }
                        return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform:  Matrix4.identity()..scale(scale,scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dental()),
                  );
                },
                child: Container(
                  width: 150,
                  margin: EdgeInsets.only(right: 20),
                  height: categoryHeight,
                  decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Dental",
                          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "5 Doctors",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.blue.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Neurology",
                          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "8 Doctors",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.lightBlueAccent.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Oncology",
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "10 Doctor",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.lightBlueAccent.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Orthopedics",
                        style: TextStyle(fontSize: 22.7, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "6 Doctor",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// const FOOD_DATA = [
//   {
//     "name":"Burger",
//     "brand":"Hawkers",
//     "price":2.99,
//     "image":"burger.png"
//   },{
//     "name":"Cheese Dip",
//     "brand":"Hawkers",
//     "price":4.99,
//     "image":"cheese_dip.png"
//   },
//   {
//     "name":"Cola",
//     "brand":"Mcdonald",
//     "price":1.49,
//     "image":"cola.png"
//   },
//   {
//     "name":"Fries",
//     "brand":"Mcdonald",
//     "price":2.99,
//     "image":"fries.png"
//   },
//   {
//     "name":"Ice Cream",
//     "brand":"Ben & Jerry's",
//     "price":9.49,
//     "image":"ice_cream.png"
//   },
//   {
//     "name":"Noodles",
//     "brand":"Hawkers",
//     "price":4.49,
//     "image":"noodles.png"
//   },
//   {
//     "name":"Pizza",
//     "brand":"Dominos",
//     "price":17.99,
//     "image":"pizza.png"
//   },
//   {
//     "name":"Sandwich",
//     "brand":"Hawkers",
//     "price":2.99,
//     "image":"sandwich.png"
//   },
//   {
//     "name":"Wrap",
//     "brand":"Subway",
//     "price":6.99,
//     "image":"wrap.png"
//   }
// ];