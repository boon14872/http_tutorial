// example for get http request with flutter http package

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://jsonplaceholder.typicode.com/users";
  String method = 'GET';
  var responseText = 'ข้อมูลจะแสดงที่นี่';

  Future<void> _fetchData() async {
    // set loading text
    setState(() {
      responseText = 'กำลังโหลดข้อมูล...';
    });
    try {
      // Send the GET request
      var response = await http.get(Uri.parse(url));
      // Update the text with the response
      setState(() {
        responseText = response.body;
      });
    } catch (e) {
      // Update the text with the error
      setState(() {
        responseText = 'เกิดข้อผิดพลาด: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Tutorial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('โหลดข้อมูล'),
            ),
            const SizedBox(height: 16),
            Text(
              responseText,
              style: const TextStyle(
                fontSize: 16,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
