import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internshiptask/Allorders.dart';
import 'package:internshiptask/Approved.dart';
import 'package:internshiptask/Pending.dart';
import 'package:internshiptask/Rejected.dart';
import 'package:internshiptask/variables.dart';

class Viewallads extends StatefulWidget {
  int index;
  Viewallads({this.index});
  Viewallads1 createState() => Viewallads1();
}

class Viewallads1 extends State<Viewallads>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _text = TextEditingController();
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Icon(
            Icons.menu,
            size: 35,
            color: Colors.red,
          ),
          iconTheme: IconThemeData(color: Colors.red, size: 35),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
              controller: _tabController,
              labelColor: Colors.redAccent,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.redAccent,
              indicatorWeight: 4,
              tabs: [
                Tab(
                  text: "Pending",
                ),
                Tab(
                  text: "Rejected",
                ),
                Tab(
                  text: "Approved",
                ),
                Tab(
                  text: "All",
                )
              ]),
          title: Expanded(
              child: Container(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        search = val;
                      });
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5),
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        hintText: "Search Ads..",
                        fillColor: Colors.grey[300],
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Ads",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
          ))),
      body: TabBarView(
          controller: _tabController,
          children: [Pending(), Rejected(), Approved(), Allorders()]),
    );
  }
}
