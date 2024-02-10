import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleGet extends StatefulWidget {
  const ExampleGet({Key? key}) : super(key: key);

  @override
  _ExampleGetState createState() => _ExampleGetState();
}

class _ExampleGetState extends State<ExampleGet> {
  final url = "https://65c641e1e5b94dfca2e145a4.mockapi.io/v1/product";
  final method = 'GET';
  dynamic responseText = 'ข้อมูลจะแสดงที่นี่';

  Future<void> _fetchData() async {
    setState(() {
      responseText = 'กำลังโหลดข้อมูล...';
    });

    try {
      final response = await http.get(Uri.parse(url));
      final decodedData = jsonDecode(response.body);
      setState(() {
        responseText = decodedData;
      });
    } catch (error) {
      setState(() {
        responseText = 'เกิดข้อผิดพลาด: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การใช้งาน HTTP เพื่อดึงข้อมูลสินค้า'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('ดึงข้อมูล'),
            ),
            const SizedBox(height: 16),
            if (responseText is String)
              Text(
                responseText,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.3,
                ),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purpleAccent[400]!),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(16),
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Column(
                      children: [
                        const Text(
                          'ข้อมูลที่ได้รับ',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: (responseText as List).length,
                            itemBuilder: (context, index) {
                              final product = responseText[index];
                              return Card(
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Text(product['productName']),
                                      const Spacer(),
                                      Text(
                                          'จำนวน: ${product['productStock']} ชิ้น'),
                                    ],
                                  ),
                                  subtitle: Text(
                                      'ราคา: ${product['productPrice']} บาท'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
