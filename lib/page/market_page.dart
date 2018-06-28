import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import "dart:async";

import 'package:rxdart/rxdart.dart';


class MarketPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<Widget> widgets = [];

  List<dynamic> items = [];

  bool isDisposed = false;

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void getData() {

    print("---- getData");

    Future<http.Response> getMarketTickers() async {
      return await http.get("https://api.huobi.pro/market/tickers");
    }

    Observable.fromFuture(getMarketTickers())
        .map((response) => response.body)
        .map(json.decode)
        .map((result) => result['data'])
        .listen((list) {
          items.clear();
          list.forEach(_addWidgets);
        },
        onError: (error, StackTrace stackTrace) {
          print("get /market/tickers error");
          print("error -> $stackTrace");
        });
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  void _addWidgets(dynamic item) {
    setState(() => items.add(item));
  }

  @override
  Widget build(BuildContext context) {
    print("build Widget");

    return Scaffold(
      appBar: AppBar(
        title: new Text("行情"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            generateItem(items[index]),
        itemCount: items.length,
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => getData(),
        child: new Icon(Icons.refresh),
        isExtended: true,),
    );
  }

  Widget generateItem(dynamic item) {

    final String symbol = item['symbol'];
    final name = symbol
        .replaceAll(new RegExp("ht\$"), "/HT")
        .replaceAll(new RegExp("usdt\$"), "/USDT")
        .replaceAll(new RegExp("btc\$"), "/BTC")
        .replaceAll(new RegExp("eth\$"), "/ETH")
        .toUpperCase();

    final double close = item['close'];
    final double open = item['open'];
    final closePrice = close.toStringAsFixed(6);
    final rate = ((close - open) / open * 100).toStringAsFixed(2) + '%';
    final color = (close - open) >= 0 ? Colors.redAccent : Colors.lightGreen;

    return new Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(name, style: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              )),
              new Text(closePrice),
            ],
          ),
          new Text(rate, style: new TextStyle(
              color: color
          ))
        ],
      ),);
  }
}
