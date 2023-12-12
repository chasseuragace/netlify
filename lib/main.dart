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
  late String platform;

  @override
  void initState() {
    super.initState();
    parseUrl();
    detectPlatform();
  }

  void parseUrl() {
    final Uri currentUri = Uri.parse(html.window.location.href);
    setState(() {
      currentUrl = currentUri.toString();
      queryParams = currentUri.queryParameters;
    });
  }

  void detectPlatform() {
    final userAgent = html.window.navigator.userAgent.toLowerCase();

    if (userAgent.contains('android')) {
      setState(() {
        platform = 'Android';
      });
    } else if (userAgent.contains('iphone') || userAgent.contains('ipad')) {
      setState(() {
        platform = 'iOS';
      });
    } else if (userAgent.contains('win')) {
      setState(() {
        platform = 'Windows';
      });
    } else if (userAgent.contains('macintosh') ||
        userAgent.contains('mac os')) {
      setState(() {
        platform = 'macOS';
      });
    } else if (userAgent.contains('linux')) {
      setState(() {
        platform = 'Linux';
      });
    } else {
      setState(() {
        platform = 'Unknown Platform';
      });
    }
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
              'Platform:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              platform,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
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
