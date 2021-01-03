
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _prefences = <String>[
    'red',
    'green',
    'blue',
    'orange',
    'red',
    'green',
    'blue',
    'orange'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('preferences').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> preferences) {
            if (!preferences.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return  ListView(
                padding: EdgeInsets.all(10),
                children: preferences.data.docs.map((item) {
                  return new Center(
                      child: Card(
                        elevation: 10.0,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {},
                          child: Container(
                              padding: EdgeInsets.all(20),
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item["transport"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21,
                                            color: Colors.black54),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            size: 15,
                                          ),
                                          Text(
                                            item["prixmin"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Départ: " +
                                            item["prixmax"],
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "Arrivée: " +
                                            item["sexe"],
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ));
                }).toList());
          }));
  }
}
