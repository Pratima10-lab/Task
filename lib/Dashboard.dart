import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internshiptask/ViewItem.dart';
import 'package:internshiptask/Viewads.dart';

class Dashboard extends StatefulWidget {
  Dashboard1 createState() => Dashboard1();
}

class Dashboard1 extends State<Dashboard> {
  int pending = 0, rejected = 0, approved = 0;

  void initState() {
    super.initState();
    getnumbers();
  }

  getnumbers() async {
    await FirebaseFirestore.instance.collection("Ads").get().then((value) => {
          value.docs.forEach((element) {
            if (element.data()["status"] == "Approved") {
              setState(() {
                approved += 1;
              });
            } else if (element.data()["status"] == "Rejected") {
              setState(() {
                rejected += 1;
              });
            } else {
              setState(() {
                pending += 1;
              });
            }
          })
        });
  }

  a(String a, String b, String c) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(7),
              child: Text(
                a,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: Color(0xff32CD32),
                  borderRadius: BorderRadius.circular(10)),
              height: 40,
            )),
        SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: Color(0xff3BB9FF),
                  borderRadius: BorderRadius.circular(10)),
              height: 40,
              child: Text(
                b,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )),
        SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 1,
            child: Container(
                height: 40,
                padding: EdgeInsets.all(8),
                child: Text(
                  c,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10))))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.menu,
            size: 45,
            color: Colors.red,
          ),
          iconTheme: IconThemeData(color: Colors.red, size: 35),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Align(
            alignment: Alignment.topRight,
            child: Text(
              "Dashboard",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Arial Narrow'),
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 5),
                            prefixIcon: Icon(Icons.search),
                            filled: true,
                            hintText: "Search Ads..",
                            fillColor: Colors.grey[300],
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FlatButton(
                        minWidth: 30,
                        height: 35,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Viewallads(
                                    index: 3,
                                  )));
                        },
                        color: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "View All Ads",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(60)),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Totals Ads\n",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Viewallads(
                                      index: 2,
                                    )));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xff32CD32),
                                borderRadius: BorderRadius.circular(10)),
                            height: 140,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Approved Ads",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      approved.toString(),
                                      style: TextStyle(
                                          fontSize: 40, color: Colors.white),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Viewallads(
                                      index: 1,
                                    )));
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              height: 140,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rejected    Ads",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.clear_rounded,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        rejected.toString(),
                                        style: TextStyle(
                                            fontSize: 40, color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff3BB9FF),
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Viewallads(
                                        index: 0,
                                      )));
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                height: 140,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Pending   Ads",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.assignment,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          pending.toString(),
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange,
                                )))),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black87,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\nPending By Categories\n",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "See More",
                      style: TextStyle(color: Colors.green),
                    )
                  ],
                ),
                Container(
                    height: 150,
                    child: Column(
                      children: [
                        a("Cars", "Properties", "Jobs"),
                        SizedBox(
                          height: 15,
                        ),
                        a("Electronic", "Mobile", "Apple"),
                        SizedBox(
                          height: 15,
                        ),
                        a("Laptops", "Lands", "Apple")
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black87,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\nPending Ads\n",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\nSee More\n",
                      style: TextStyle(color: Colors.green),
                    )
                  ],
                ),
                Container(
                  height: 420,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Ads")
                          .where("status", isEqualTo: "Pending")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return GridView.builder(
                            itemCount: snapshot.data.docs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.46,
                                    crossAxisSpacing: 2.0),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    String n = snapshot.data.documents[index]
                                        .get("name");
                                    String i = snapshot.data.documents[index]
                                        .get("image");
                                    String des = snapshot.data.documents[index]
                                        .get("description");
                                    String cat = snapshot.data.documents[index]
                                        .get("category");
                                    String subcat = snapshot
                                        .data.documents[index]
                                        .get("subCat");
                                    String type = snapshot.data.documents[index]
                                        .get("type");
                                    String location = snapshot
                                        .data.documents[index]
                                        .get("location");
                                    String id = snapshot.data.documents[index]
                                        .get("id");
                                    String u = snapshot.data.documents[index]
                                        .get("user");
                                    String e = snapshot.data.documents[index]
                                        .get("email");
                                    String p = snapshot.data.documents[index]
                                        .get("phone");
                                    String s = snapshot.data.documents[index]
                                        .get("status");

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ViewItem(
                                                  name: n,
                                                  image: i,
                                                  desc: des,
                                                  cat: cat,
                                                  subcat: subcat,
                                                  type: type,
                                                  location: location,
                                                  id: id,
                                                  user: u,
                                                  email: e,
                                                  phone: p,
                                                )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding:
                                        EdgeInsets.only(left: 15, right: 10),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            width: 100,
                                            height: 35,
                                            color: Color(0xff3BB9FF),
                                            child: Center(
                                                child: Text(
                                              snapshot.data.documents[index]
                                                  .get("status"),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Image(
                                            height: 120,
                                            fit: BoxFit.contain,
                                            image: NetworkImage(snapshot
                                                .data.documents[index]
                                                .get("image"))),
                                        Text(
                                          "\n" +
                                              snapshot.data.documents[index]
                                                  .get("name"),
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "" +
                                              snapshot.data.documents[index]
                                                  .get("description"),
                                          maxLines: 2,
                                        ),
                                        Text("\nCategory"),
                                        FlatButton(
                                            minWidth: 30,
                                            height: 25,
                                            onPressed: () {},
                                            color: Colors.redAccent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              snapshot.data.documents[index]
                                                  .get("subCat"),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text: 'OMR ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: snapshot
                                                    .data.documents[index]
                                                    .get("Omr"),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ]))),
                                        Text("1 day ago")
                                      ],
                                    ),
                                  ));
                            });
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
