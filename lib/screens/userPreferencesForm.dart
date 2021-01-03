import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:transport_app/APIs/preferencesServices.dart';

class UserPreferencesForm extends StatefulWidget {
  UserPreferencesForm({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserPreferencesFormState createState() => _UserPreferencesFormState();
}

class _UserPreferencesFormState extends State<UserPreferencesForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _transports = <String>['', 'Bus', 'Trame', 'Taxi', 'Train'];
  List<String> _sexes = <String>['', 'Homme', 'Femme'];
  List<String> _isHandicape = <String>['', 'Oui', 'Non'];
  String _transport = '';
  String _sexe = '';
  String _handicape = "";
  String _age = "";
  RangeValues _currentRangeValues = const RangeValues(20, 60);

  void initializeState(){
    setState(() {
       _transport = '';
       _sexe = '';
       _handicape = "";
       _age = "0";
       _currentRangeValues = const RangeValues(20, 60);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: new SafeArea(
          top: false,
          bottom: false,
          child: Center(
            child: new Container(
              height: MediaQuery.of(context).size.height / 1.4,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: new Form(
                  key: _formKey,
                  autovalidate: true,
                  child: new ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 20.0),
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Préferences",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextFormField(
                        initialValue: "",
                        decoration: InputDecoration(
                            icon: const Icon(Icons.accessibility_new_sharp),
                            labelText: 'Age',
                            filled: true,
                            fillColor: new Color(0xf6f8fa),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(50.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(50.0))),
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          setState(() => {_age = val});
                        },
                      ),
                      SizedBox(height: 10),
                      new FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                icon: const Icon(Icons.wc_outlined),
                                labelText: 'Sexe',
                                filled: true,
                                fillColor: new Color(0xf6f8fa),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                    borderRadius: BorderRadius.circular(50.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                    borderRadius: BorderRadius.circular(50.0))),
                            isEmpty: _sexe == '',
                            child: new DropdownButtonHideUnderline(
                              child: new DropdownButton(
                                value: _sexe,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() => {
                                        _sexe = newValue,
                                        state.didChange(newValue)
                                      });
                                },
                                items: _sexes.map((String value) {
                                  return new DropdownMenuItem(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      new FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                icon: const Icon(
                                    Icons.accessible_forward_rounded),
                                labelText: 'Handicape ?',
                                filled: true,
                                fillColor: new Color(0xf6f8fa),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                    borderRadius: BorderRadius.circular(50.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                    borderRadius: BorderRadius.circular(50.0))),
                            isEmpty: _handicape == '',
                            child: new DropdownButtonHideUnderline(
                              child: new DropdownButton(
                                value: _handicape,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() => {
                                        _handicape = newValue,
                                        state.didChange(newValue)
                                      });
                                },
                                items: _isHandicape.map((String value) {
                                  return new DropdownMenuItem(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      new FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                icon:
                                    const Icon(Icons.airport_shuttle_outlined),
                                labelText: 'Transport Préferé',
                                filled: true,
                                fillColor: new Color(0xf6f8fa),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                    borderRadius: BorderRadius.circular(50.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                    borderRadius: BorderRadius.circular(50.0))),
                            isEmpty: _transport == '',
                            child: new DropdownButtonHideUnderline(
                              child: new DropdownButton(
                                value: _transport,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() => {
                                        _transport = newValue,
                                        state.didChange(newValue)
                                      });
                                },
                                items: _transports.map((String value) {
                                  return new DropdownMenuItem(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(Icons.attach_money, color: Colors.grey,),
                          new Expanded(
                              child: RangeSlider(
                            values: _currentRangeValues,
                            min: 0,
                            max: 100,
                            divisions: 10,
                            activeColor: Colors.cyan,
                            inactiveColor: Colors.grey,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                          )),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                            color: Colors.cyan,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            child: Text(
                              "Envoyer",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              PreferencesService().addPreference({"age":_age, "sexe":_sexe, "transport":_transport, "handicap":_handicape,"prixmin":_currentRangeValues.start.toString(),"prixmax":_currentRangeValues.end.toString()});
                              initializeState();
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          )),
    );
  }
}
