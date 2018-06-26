import 'package:flutter/material.dart';
import '../api/huobi_api.dart';

class MarketPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MarketPageState();
}

class _MarketPageState extends State<MarketPage>{
  List widgets = [];

  @override
  void initState() {
    super.initState();
    final marketService = new MarketService();
    marketService.getTikers().then((response) {
      print("getTikers = ${response.body}");
    }).catchError((object, stackTrace) {
      print("getTikers error ${stackTrace.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: AppBar(title: new Text("行情"),),
      body: new Container(
        child: new Center(
          child: new Text(
            'First Page',
            style: new TextStyle(fontSize: 25.0, color: Colors.teal),
          ),
        ),),
    );
  }
}

