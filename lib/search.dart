import 'package:butom_navbar/services/data_contoller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;
  bool isExcecuted = false;

  @override
  Widget build(BuildContext context) {
    Widget searchData() {
      return ListView.builder(
          itemCount: snapshotData.docs.length,
          itemBuilder: (BuildContext Context, int index) {
            return ListTile(
              // leading: CircleAvatar(
              //   backgroundImage: NetworkImage(
              //     snapshotData.docs[index].data()['image']
              //   ),
              // ),
              title: Text(snapshotData.docs[index].data()['name'],style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24
              ),),
              subtitle:  Text(snapshotData.docs[index].data()["role"],style: TextStyle(
                color: Colors.black45,fontSize: 20,fontWeight: FontWeight.bold
              ),),
            );
          });
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      val.queryData(searchController.text).then((value) {
                        snapshotData = value;
                        setState(() {
                          isExcecuted = true;
                        });
                      });
                    });
              })
        ],
        title: TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Search here',
          ),
          controller: searchController,
        ),
      ),
      body: isExcecuted ? searchData() : Container(
        child: Center(
          child: Text(
            "Search any courses",style: TextStyle(
            color: Colors.black54,fontSize: 30
          ),
          ),
        ),
      )
    );
  }
}
