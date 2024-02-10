# http_tutorial

<!-- describe about my project what this project can do on readme file  -->
<!-- it's can show how docs http package can do like send hhtp request for get data and handle error in flutter -->

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:


## How to use http package in flutter

- First you need to add http package in your pubspec.yaml file
```yaml

dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.3
```

- Then you need to import http package in your dart file
```dart
import 'package:http/http.dart' as http;
```

- Now you can use http package to send http request and handle error in your flutter app
```dart
Future<void> fetchData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
    }
  }
```

<!-- end  -->

## Learn More

You can learn more in the [Flutter documentation](https://flutter.dev/docs).
To learn more about http package you can visit [http package documentation](https://pub.dev/packages/http).
For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
