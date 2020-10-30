library html_server;

import 'dart:async';
import 'dart:io';

/// html webService
/// Map html string to http service
class _HtmlServer extends HtmlServer{
  String _html;
  HttpServer _server;

  String get html {
    if (_html==null || _html.isEmpty) {
      return '''
      <!DOCTYPE html>
      <html lang="zh">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>error</title>
        </head>
        <body>
            <p>html content is None</p>
        </body>
      </html>
    ''';
    } else {
      return _html;
    }
  }

  _HtmlServer([this._html]);

  set html(String html) {
    assert(html != null && html.isNotEmpty);
    _html = html;
  }

  void _reqHandle(HttpRequest request) {
    request.response.headers.add('Content-Type', 'text/html; charset=UTF-8');
    request.response.write(html);
    request.response.close();
  }

  Future<HttpServer> serve() async {
    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    _server.listen(_reqHandle);
    return _server;
  }

  Future<dynamic> dispose() async {
    return _server?.close();
  }

  String get address => _server.address.address;
  int get port => _server.port;
}

abstract class HtmlServer {

  /// Get the html string returned by the http service
  String get html;

  /// Set the html string returned by the http service
  set html(String html);

  /// http address eg: 127.0.0.1
  String get address;

  /// http port
  int get port;

  /// Turn off http service
  Future<dynamic> dispose();

  /// Get the url to open html
  String get url => 'http://$address}:$port/';

  /// start an html service
  static Future<HtmlServer> serve([String html]) async {
    var _server = _HtmlServer(html);
    await _server.serve();
    return _server;
  }
}