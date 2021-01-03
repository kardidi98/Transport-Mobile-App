import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:transport_app/screens/searchResult.dart';

class UserForm extends StatefulWidget {
  UserForm({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _transports = <String>['', 'Bus', 'Trame', 'Taxi', 'Train'];
  String _transport = '';
  DateTime _heureDep = DateTime.now();
  String _stationDep = "";
  String _stationArrivee = "";

  final format = DateFormat("HH:mm");

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
                          "Chercher un transport",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      SizedBox(height: 40),
                      new DateTimeField(
                          format: format,
                          initialValue: (DateTime.now()),
                          onChanged: (val) {
                            setState(() => {_heureDep = val});
                          },
                          decoration: InputDecoration(
                              icon: const Icon(Icons.access_time),
                              labelText: 'Heure de départ',
                              filled: true,
                              fillColor: new Color(0xf6f8fa),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.cyan),
                                  borderRadius: BorderRadius.circular(50.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.cyan),
                                  borderRadius: BorderRadius.circular(50.0))),
                          onShowPicker: (context, currentValue) async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.convert(time);
                          }),
                      SizedBox(height: 10),
                      new TextFormField(
                        decoration: InputDecoration(
                            icon: const Icon(Icons.adjust_outlined),
                            labelText: 'Station de départ',
                            filled: true,
                            fillColor: new Color(0xf6f8fa),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(50.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(50.0))),
                        keyboardType: TextInputType.text,
                        onChanged: (val) {
                          setState(() => {_stationDep = val});
                        },
                      ),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.arrow_downward_outlined,
                              color: Colors.grey),
                        ],
                      ),
                      new TextFormField(
                        decoration: InputDecoration(
                            icon: const Icon(Icons.add_location_alt_outlined),
                            labelText: 'Station d\'arrivée',
                            filled: true,
                            fillColor: new Color(0xf6f8fa),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(50.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                                borderRadius: BorderRadius.circular(50.0))),
                        keyboardType: TextInputType.text,
                        onChanged: (val) {
                          setState(() => {_stationArrivee = val});
                        },
                      ),
                      SizedBox(height: 10),
                      new FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                icon: const Icon(
                                    Icons.emoji_transportation_outlined),
                                labelText: 'Transport',
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
                      Container(
                        padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                            color: Colors.cyan,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            child: Text("Chercher",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchResult(
                                          title: "Transports Disponibles",
                                          heureDep: _heureDep.toString(),
                                          stationDep: _stationDep,
                                          stationArrivee: _stationArrivee,
                                          transport: _transport,
                                        )),
                              );
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
