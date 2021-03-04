import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internshiptask/ViewItem.dart';
import 'package:internshiptask/variables.dart';

class Approved extends StatefulWidget {
  Approved1 createState() => Approved1();
}

class Approved1 extends State<Approved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          margin: EdgeInsets.all(5),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Ads")
                  .where("status", isEqualTo: "Approved")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return GridView.builder(
                    itemCount: snapshot.data.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.61,
                        crossAxisSpacing: 2.0),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            String n =
                                snapshot.data.documents[index].get("name");
                            String i =
                                snapshot.data.documents[index].get("image");
                            String des = snapshot.data.documents[index]
                                .get("description");
                            String cat =
                                snapshot.data.documents[index].get("category");
                            String subcat =
                                snapshot.data.documents[index].get("subCat");
                            String type =
                                snapshot.data.documents[index].get("type");
                            String location =
                                snapshot.data.documents[index].get("location");
                            String id =
                                snapshot.data.documents[index].get("id");
                            String u =
                                snapshot.data.documents[index].get("user");
                            String e =
                                snapshot.data.documents[index].get("email");
                            String p =
                                snapshot.data.documents[index].get("phone");
                            String s =
                                snapshot.data.documents[index].get("status");

                            Navigator.of(context).push(MaterialPageRoute(
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
                                      status: s,
                                    )));
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 10, top: 5),
                            padding: EdgeInsets.only(left: 15, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: 100,
                                    height: 25,
                                    color: Color(0xff32CD32),
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
                                  height: 10,
                                ),
                                Image(
                                    height: 80,
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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      snapshot.data.documents[index]
                                          .get("category"),
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: 'OMR ',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: snapshot.data.documents[index]
                                            .get("Omr"),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ]))),
                                Text("1 day ago")
                              ],
                            ),
                          ));
                    });
              }),
        ),
      ),
    );
  }
}
