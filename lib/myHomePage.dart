import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _posts = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Reader"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _posts.isEmpty
              ? const Center(
                  child: Text("Data is not avilable"),
                )
              : ListView.builder(
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(post['title'] as String),
                        subtitle: Text(post['body'] as String),
                      ),
                    );
                  }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          fetchData();
        },
        tooltip: "refresh",
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(response.body) as List<dynamic>;
      setState(() {
        _posts = jsonData.cast<Map<String, dynamic>>();
        isLoading = false;
      });
    } else {
      _posts = [];
    }
  }
}
