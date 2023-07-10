import 'package:flutter/material.dart';

Future<String> fetchData() async {
  await Future.delayed(const Duration(seconds: 4));
  return 'Data retrieved successfully';
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Text('Data: ${snapshot.data}');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
        }
        return const Text('Unknown state');
      },
    );
  }
}
