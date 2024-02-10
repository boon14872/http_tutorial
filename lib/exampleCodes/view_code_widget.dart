import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class ViewCodeWidget extends StatelessWidget {
  final String code;
  const ViewCodeWidget({
    Key? key,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Highlighter highlighter;
    late HighlighterTheme theme;
    late String codeExampleText;

    Future<String> loadThemeAndCodeExample() async {
      theme = await HighlighterTheme.loadDarkTheme();
      highlighter = Highlighter(language: 'dart', theme: theme);
      codeExampleText = await rootBundle.loadString(code);
      return codeExampleText;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Example'),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(top: 16),
          child: Column(children: [
            const SizedBox(height: 16),
            FutureBuilder<String>(
              future: loadThemeAndCodeExample(),
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
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purpleAccent[400]!),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: Text.rich(
                          // Highlight the code.
                          highlighter.highlight(codeExampleText),
                          style: GoogleFonts.itim(
                            fontSize: 14,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}
