import 'package:flutter/material.dart';
import 'package:huobi_flutter/page/market_page.dart';

void main() => runApp(new HuobiApp());

class HuobiApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: '火币 Flutter',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => new HomePage(),
        }
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(initialIndex: _currentIndex, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new TabBarView(
            controller: tabController,
            children: [
              new MarketPage(),
              new MarketPage(),
              new MarketPage(),
            ]),
        bottomNavigationBar: new Material(
          color: Colors.blue,
          child: new TabBar(
              controller: tabController,
              tabs: [
                new Tab(icon: new Icon(Icons.access_time), text: "Tab1"),
                new Tab(icon: new Icon(Icons.access_time), text: "Tab2"),
                new Tab(icon: new Icon(Icons.access_time), text: "Tab3")
              ]),
        ));
  }
}
