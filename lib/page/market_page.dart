import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:http_throttle/http_throttle.dart';

class MarketPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    final client = new ThrottleClient(32);

    client
        .get("https://api.huobi.pro/market/tickers", headers: {'Content-Type': 'application/json'})
        .then((response) {
          print("get market/tickers return ");
          return response;
        })
        .catchError((dynamic, stackTrace){
          print("get market error $stackTrace\n");
        })
        .then((response) => response.body)
        .then(json.decode)
        .then((result) => result['data'])
        .then((list) => list.forEach(_addWidgets));
  }

  void _addWidgets(dynamic item) {
    setState(() {
      widgets.add(new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new FlatButton(child: new Text(item['symbol']),textColor: Colors.grey, onPressed: () {},),
        ],
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("行情"),
      ),
      body: new Container(
        child: new ListView(scrollDirection: Axis.vertical, children: widgets),
      ),
    );
  }
}
