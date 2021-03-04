import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internshiptask/Dashboard.dart';

class ViewItem extends StatefulWidget {
  String image,
      name,
      desc,
      cat,
      subcat,
      type,
      location,
      id,
      user,
      email,
      phone,
      status;

  ViewItem(
      {this.name,
      this.image,
      this.desc,
      this.cat,
      this.subcat,
      this.type,
      this.location,
      this.id,
      this.user,
      this.email,
      this.phone,
      this.status});
  ViewItem1 createState() => ViewItem1();
}

class ViewItem1 extends State<ViewItem> {
  showapprovedialog() {
    showModalBottomSheet(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        context: context,
        builder: (context) {
          return Container(
            height: 280,
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Approve Ad",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.clear_rounded,
                    )
                  ],
                ),
                Text("\n\nAre you sure you want to approve this ad?"),
                Text(
                  "\nNote: This section will notify user the ad is approved and visible to the other users.\n\n",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                FlatButton(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  onPressed: () {
                    Navigator.pop(context);
                    approveads();
                  },
                  child: Text(
                    "Approve",
                    style: TextStyle(color: Colors.white),
                  ),
                  height: 50,
                  color: Color(0xff32CD32),
                )
              ],
            ),
          );
        });
  }

  approveads() async {
    Map<String, dynamic> map = {"status": "Approved"};
    await FirebaseFirestore.instance
        .collection("Ads")
        .get()
        .then((document) => {
              document.docs.forEach((element) {
                if (widget.id == element.data()["id"]) {
                  FirebaseFirestore.instance
                      .collection("Ads")
                      .doc(widget.id)
                      .update(map)
                      .then((value) => showd("Approved"));
                }
              })
            });
  }

  showreject() {
    showModalBottomSheet(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        context: context,
        builder: (context) {
          String hint = "";
          return StatefulBuilder(builder: (context, StateSetter setState1) {
            return Container(
              height: 320,
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reject Ad",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.clear_rounded,
                      )
                    ],
                  ),
                  Text(
                    "\n\nAre you sure you want to reject this ad?",
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "\nPick Ad Rejection Reason.\n\n",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300])),
                      height: 50,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(
                            hint,
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          isExpanded: true,
                          iconSize: 20.0,
                          style: TextStyle(color: Colors.black),
                          items: [
                            "The Category is Mismatch",
                          ].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState1(() {
                              hint = val;
                            });
                          },
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    onPressed: () {
                      rejectads();
                    },
                    child: Text(
                      "Reject",
                      style: TextStyle(color: Colors.white),
                    ),
                    height: 50,
                    color: Colors.lightBlue,
                  )
                ],
              ),
            );
          });
        });
  }

  rejectads() async {
    Map<String, dynamic> map = {"status": "Rejected"};
    await FirebaseFirestore.instance
        .collection("Ads")
        .get()
        .then((document) => {
              document.docs.forEach((element) {
                if (widget.id == element.data()["id"]) {
                  FirebaseFirestore.instance
                      .collection("Ads")
                      .doc(widget.id)
                      .update(map)
                      .then((value) => showd("Rejected"));
                }
              })
            });
  }

  showd(String s1) {
    Dialog s = Dialog(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.white),
          height: 290,
          width: 100,
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Done!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 70,
                height: 70,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 45,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff32CD32),
                ),
              ),
              Text(
                "\nThe Ad is Successfully",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                s1,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                minWidth: 220,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
                child: Text(
                  "Okay",
                  style: TextStyle(color: Colors.white),
                ),
                height: 40,
                color: Color(0xff32CD32),
              )
            ],
          ),
        ));
    showDialog(
        context: context,
        builder: (context) {
          return s;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 1005,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: NetworkImage(widget.image),
                    height: 200,
                    fit: BoxFit.cover,
                  )),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 100,
                          height: 25,
                          color: widget.status == "Pending"
                              ? Colors.lightBlue
                              : widget.status == "Approved"
                                  ? Colors.green
                                  : Colors.red,
                          child: Center(
                              child: Text(
                            widget.status,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'OMR ',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          TextSpan(
                            text: "225",
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                        ])),
                      ],
                    ),
                    Text(
                      "\n" + widget.name,
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\nDescription",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("\n" + widget.desc + "\n"),
                    Divider(
                      color: Colors.black87,
                    ),
                    Container(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Category"),
                              Text("Sub Category"),
                              Text("Type/make")
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(7),
                                    child: Text(
                                      widget.cat,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                        color: Colors.orange,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: 40,
                                    child: Text(
                                      widget.subcat,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      height: 40,
                                      padding: EdgeInsets.all(7),
                                      child: Text(
                                        widget.type,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(10))))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Text(
                      "\nAd Location",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 35,
                      ),
                      title: Text(widget.location),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      color: Colors.black87,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Ad Poster Info",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 150,
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("\n\n" + widget.user),
                              Text("\n" + widget.email),
                              Text("\n" + widget.phone)
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 70,
                              ),
                              Icon(Icons.mail),
                              Icon(Icons.phone)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.all(25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 1,
                child: RaisedButton(
                  onPressed: () {
                    showapprovedialog();
                  },
                  shape: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5)),
                  color: Color(0xff32CD32),
                  child: Text(
                    "Approve",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                flex: 1,
                child: RaisedButton(
                  onPressed: () {
                    showreject();
                  },
                  shape: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5)),
                  color: Colors.lightBlue,
                  child: Text(
                    "Reject",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
