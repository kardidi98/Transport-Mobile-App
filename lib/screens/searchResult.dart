import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SearchResult extends StatelessWidget {
  SearchResult(
      {Key key,
      this.title,
      this.heureDep,
      this.stationDep,
      this.stationArrivee,
      this.transport})
      : super(key: key);

  final String heureDep;
  final String stationDep;
  final String stationArrivee;
  final String transport;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: this.title,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Container(
          child: SearchResultPage(
            title: this.title,
            heureDep: this.heureDep,
            stationDep: this.stationDep,
            stationArrivee: this.stationArrivee,
            transport: this.transport,
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/backG1.jpg"), fit: BoxFit.fill)),
        ));
  }
}

class SearchResultPage extends StatefulWidget {
  SearchResultPage(
      {Key key,
      this.title,
      this.heureDep,
      this.stationDep,
      this.stationArrivee,
      this.transport})
      : super(key: key);

  final String heureDep;
  final String stationDep;
  final String stationArrivee;
  final String transport;
  final String title;

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResultPage> {
  List<String> _resultSearch = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('transports').snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> _preferences) {
              if (!_preferences.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return new ListView(
                  padding: EdgeInsets.all(10),
                  children: _preferences.data.docs.map((item) {
                    if (item["type"] == widget.transport &&
                        item["stationDep"] == widget.stationDep &&
                        item["stationArrivee"] == widget.stationArrivee &&
                        item["heureDep"] == widget.heureDep) {
                      return new Center(
                          child: Card(
                        elevation: 10.0,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {},
                          child: Container(
                              padding: EdgeInsets.all(20),
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item["type"],
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
                                            item["heureDep"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Départ: " + item["stationDep"],
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Icon(
                                        Icons.arrow_downward_outlined,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "Arrivée: " + item["stationArrivee"],
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ));
                    } else {
                      return Center(
                        child: SizedBox(height: 0,),
                      );

                    }
                  }).toList());
            }));
  }
}
