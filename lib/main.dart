import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_tutorial/code_example_menu.dart';
import 'package:syntax_highlight/syntax_highlight.dart';
import 'package:google_fonts/google_fonts.dart';

// json
late final Highlighter _dartLightHighlighter;
late final Highlighter _dartDarkHighlighter;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the highlighter.
  await Highlighter.initialize(['dart']);

  // Load the default light theme and create a highlighter.
  var lightTheme = await HighlighterTheme.loadLightTheme();
  var darkTheme = await HighlighterTheme.loadDarkTheme();
  _dartLightHighlighter = Highlighter(
    language: 'dart',
    theme: lightTheme,
  );

  _dartDarkHighlighter = Highlighter(
    language: 'dart',
    theme: darkTheme,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter HTTP Tutorial',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://jsonplaceholder.typicode.com/users";
  var responseText = 'ข้อมูลจะแสดงที่นี่';

  Future<void> _fetchData() async {
    // set loading text
    setState(() {
      responseText = 'กำลังโหลดข้อมูล...';
    });
    try {
      final uri = Uri.parse(url);
      http.Response response;
      response = await http.get(uri);
      if (response.statusCode == 200) {
        setState(() {
          responseText = response.body;
        });
      } else {
        setState(() {
          responseText = 'Error: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        responseText = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter HTTP Tutorial'),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // header text
            Text(
              'ตัวอย่างการใช้งาน HTTP ใน Flutter',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent[400],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10.0, right: 10.0),
                  child: const Text(
                    'URL: ',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: url),
                    decoration: const InputDecoration(
                      hintText: 'Enter URL',
                    ),
                    onChanged: (value) => url = value,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: _fetchData,
                style: ElevatedButton.styleFrom(
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 20.0),
                  backgroundColor: Colors.purpleAccent[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text('ดึงข้อมูล'),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purpleAccent[400]!),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    // make min height for container is full screen
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                      minWidth: MediaQuery.of(context).size.width,
                    ),

                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Text.rich(
                        // Highlight the code.
                        _dartDarkHighlighter.highlight(responseText),
                        style: GoogleFonts.itim(
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // button for navigate to page to show actual code example
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CodeExampleMenu(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 20.0),
                  backgroundColor: Colors.purpleAccent[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text('ดูตัวอย่างโค้ด'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
