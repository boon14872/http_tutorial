import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_tutorial/exampleCodes/view_code_widget.dart';

class ExampleGetHandler extends StatefulWidget {
  const ExampleGetHandler({Key? key}) : super(key: key);

  @override
  _ExampleGetStateHandler createState() => _ExampleGetStateHandler();
}

class _ExampleGetStateHandler extends State<ExampleGetHandler> {
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
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: _fetchData,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                    backgroundColor: Colors.greenAccent.shade400,
                  ),
                  child: const Text(
                    'ดึงข้อมูล',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (responseText is String)
                  Center(
                    child: Text(
                      responseText,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.3,
                      ),
                    ),
                  )
                else if (responseText is List)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purpleAccent[400]!),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(16),
                      height: MediaQuery.of(context).size.height,
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
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewCodeWidget(
                            code: 'assets/code/code_exampleGet.dart',
                          ),
                        ),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    textStyle: const TextStyle(fontSize: 16),
                    backgroundColor: Colors.purpleAccent[400],
                  ),
                  child: const Text(
                    'ดูโค้ด',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
