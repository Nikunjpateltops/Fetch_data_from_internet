import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model_class.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SamplePosts> samplePosts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(18.0),
          child: Text("Fetch Data From Internet",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.purple,
                  fontWeight: FontWeight.w600)),
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: samplePosts.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  color: Colors.purpleAccent,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'User id: ${samplePosts[index].userId}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Id: ${samplePosts[index].id}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Title: ${samplePosts[index].title}',
                        style: const TextStyle(fontSize: 18),
                        maxLines: 1,
                      ),
                      Text(
                        'Body: ${samplePosts[index].body}',
                        maxLines: 1,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(28.0),
              child: Center(
                // child: LinearProgressIndicator(),
                child: CircularProgressIndicator(color: Colors.purple),
              ),
            );
          }
        },
      ),
    );
  }

  Future getData() async {
    final response = await http.get(
      Uri.parse(
        'https://jsonplaceholder.typicode.com/posts',
      ),
    );

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        samplePosts.add(SamplePosts.fromJson(index));
      }
      return samplePosts;
    } else if (response.statusCode == 404) {
      throw Exception('Failed to load data');
    } else {
      return samplePosts;
    }
  }
}
