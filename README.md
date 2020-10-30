# html_server

Start http service, visit url to get html string

## Getting Started

``` dart

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  HtmlServer server;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: server == null ? CircularProgressIndicator() : WebView(
        initialUrl: server.url,
      ),
    );
  }

  initWeb() async {
    String html = "<html><p>hello my friend</p></html>";
    server = await HtmlServer.serve(html);
    setState(() {});
  }
  
  @override
  void initState() {
    initWeb();
    super.initState();
  }
  
  @override
  void dispose() {
    server.dispose();
    super.dispose();
  }
}
```