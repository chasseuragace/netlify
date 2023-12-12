import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Parser',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String currentUrl;
  late Map<String, String> queryParams;

  @override
  void initState() {
    super.initState();
    parseUrl();
  }

  void parseUrl() {
    final Uri currentUri = Uri.parse(html.window.location.href);
    setState(() {
      currentUrl = currentUri.toString();
      queryParams = currentUri.queryParameters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('URL Parser'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current URL:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              currentUrl,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Query Parameters:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              jsonEncode(queryParams),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
