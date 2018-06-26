import 'dart:async';
import 'package:http/http.dart' as http;


class MarketService extends NetworkService {
  MarketService() : super("https://api.huobi.pro/market");

  Future<http.Response> getMarketDetail(String symbol) {
    return httpGet("/detail/merged?symbol=$symbol");
  }

  Future<http.Response> getTikers() {
    return httpGet("/tickers");
  }
}

class NetworkService {
  String _baseUrl;

  NetworkService(String baseUrl) {
    _baseUrl = baseUrl;
  }


  Future<http.Response> httpGet(String path) {
    print("httpGet = ${_baseUrl + path}");

    return http.get(_baseUrl + path, headers: {'Content-Type': 'application/json'});
  }

  Future<http.Response> httpPost(String path, {body}) {
    return http.post(_baseUrl + path,
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept-Language": "zh-cn"
        });
  }
}
