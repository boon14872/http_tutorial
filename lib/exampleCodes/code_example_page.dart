import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class CodeExample extends StatefulWidget {
  const CodeExample({
    Key? key,
  }) : super(key: key);

  @override
  _CodeExampleState createState() => _CodeExampleState();
}

class _CodeExampleState extends State<CodeExample> {
  late Highlighter _highlighter;
  late HighlighterTheme _theme;
  late String _codeExampleText;

  @override
  void initState() {
    super.initState();
  }

  Future<String> _loadThemeAndCodeExample() async {
    _theme = await HighlighterTheme.loadDarkTheme();
    _highlighter = Highlighter(language: 'dart', theme: _theme);
    _codeExampleText = await rootBundle.loadString('code/code_example.dart');
    return _codeExampleText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Example'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<String>(
            future: _loadThemeAndCodeExample(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: GoogleFonts.itim(
                      fontSize: 16,
                      height: 1.3,
                    ),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'code_example.dart',
                    style: GoogleFonts.firaCode(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text.rich(
                      _highlighter.highlight(snapshot.data!.toString()),
                      style: GoogleFonts.sourceCodePro(
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
