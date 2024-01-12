import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/": (_) => MyHomePage(), '/resolve': (_) => MyHomePage()},
      title: 'URL Parser',
      // home: MyHomePage(),
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

  void openAppStoreOrWebsite() {
    String url;

    switch (platform) {
      case 'Android':
        url =
            'https://play.google.com/store/apps/details?id=com.google.android.apps.maps';
        break;
      case 'iOS':
        url = 'https://apps.apple.com/us/app/google-maps/id585027354';
        break;
      case 'Windows':
      case 'macOS':
      case 'Linux':
        url = 'https://kaha.com.np';
        break;
      default:
        url = 'https://kaha.com.np';
        break;
    }

    html.window.location.href = url;
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
            // Kaha Logo
            Image.asset(
              'assets/kaha_logo.png', // Replace with your actual image path
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            // Beautifully decorated card widget as a button
            InkWell(
              onTap: openAppStoreOrWebsite,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Open App Store or Website',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
