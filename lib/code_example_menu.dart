// codeExampleMenu

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_tutorial/exampleCodes/code_example_page.dart';
import 'package:http_tutorial/exampleCodes/example_get.dart';
import 'package:http_tutorial/exampleCodes/example_get_handle.dart';

const codeExamplePages = [
  {
    'title': 'การใช้งาน HTTP',
    'route': CodeExample(),
  },
  {
    'title': 'การใช้งาน HTTP เพื่อดึงข้อมูลสินค้า',
    'route': ExampleGet(),
  },
  {
    'title': 'การใช้งาน HTTP กับ Loading และ Error Handling',
    'route': ExampleGetHandler(),
  },
];

class CodeExampleMenu extends StatelessWidget {
  const CodeExampleMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตัวอย่างการใช้งาน HTTP ใน Flutter'),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: Center(
        child: Container(
          // width 80% of screen
          width: MediaQuery.of(context).size.width * 0.8,
          margin: const EdgeInsets.only(top: 30.0),
          alignment: Alignment.center,
          // list menu with beautiful design by using button and handle on hover effect
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: codeExamplePages.map((page) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => page['route']! as Widget),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.purpleAccent[400]),
                      overlayColor:
                          MaterialStateProperty.all(Colors.purpleAccent[100]),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.symmetric(
                        vertical: 2,
                      )),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      shadowColor: MaterialStateProperty.all(
                        Colors.purpleAccent[400],
                      ),
                      // add shadow effect when hover
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return 6;
                          }
                          return 2;
                        },
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        page['title']! as String,
                        style: GoogleFonts.itim(
                          fontSize: 20,
                          height: 1.3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
// codeExampleMenu
