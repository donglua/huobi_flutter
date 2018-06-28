import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import "dart:async";
import 'package:async/async.dart';

class MarketPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();

    http
        .get("https://api.huobi.pro/market/tickers")
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
    print("---  item = " + item['symbol']);
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
      body: new ListView(scrollDirection: Axis.vertical, children: widgets),
    );
  }
}
