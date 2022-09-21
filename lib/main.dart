import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: PageHome(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final String baseUrl = "https://jsonplaceholder.typicode.com/posts";
bool isLoading = false;

String body = "";
List _post = [];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : _post.isEmpty
                ? Text("sorry no Data")
                : ListView.builder(
                    itemCount: _post.length,
                    itemBuilder: (context, index) {
                      final post = _post[index];
                      return ListTile(
                        title: Text(
                          post["title"],
                        ),
                        subtitle: Text(post["body"]),
                      );
                    },
                  ),
        // : Column(
        //     children: [],
        //   ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        setState(() {
          isLoading = true;
        });
        final response = await http.get(
          Uri.parse(baseUrl),
        );

        setState(() {
          final map = json.decode(response.body);
          _post = map as List<dynamic>;
          body = response.body;
          isLoading = false;
        });
      }),
    );
  }
}

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  final baseUrl = "https://jsonplaceholder.typicode.com/posts";
  bool loding = true;
  String body = "";
  List _post = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loding
            ? CircularProgressIndicator()
            : _post.isEmpty
                ? Text("nO dATA")
                : ListView.builder(
                    itemCount: _post.length,
                    itemBuilder: (context, index) {
                      final post = _post[index];
                      return ListTile(
               
                        leading: Text(post["id"].toString()),
                        title: Text(post["title"]),
                        subtitle: Text(post["body"]),
                        trailing: Text(post["userId"].toString()),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        setState(() {
          loding = true;
        });
        final response = await http.get(
          Uri.parse(baseUrl),
        );

        setState(() {
          final map = json.decode(response.body);
          _post = map as List<dynamic>;
          body = response.body;

          loding = false;
        });
      }),
    );
  }
}
// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final String baseUrl = "https://jsonplaceholder.typicode.com/posts";

//   bool loading = false;

//   String body = "";
//   List _post = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Http Flutter"),
//         backgroundColor: Colors.purple,
//       ),
//       body: Center(
//         child: loading
//             ? CircularProgressIndicator()
//             : _post.isEmpty
//                 ? Text("sorry no Data")
//                 : ListView.builder(
//                     itemCount: _post.length,
//                     itemBuilder: (context, index) {
//                       final post = _post[index];
//                       return ListTile(
//                         title: Text(
//                           post["title"],
//                         ),
//                         subtitle: Text(post["body"]),
//                       );
//                     },
//                   ),
//         // : Column(
//         //     children: [],
//         //   ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           setState(() {
//             loading = true;
//           });
//           final response = await http.get(
//             Uri.parse(baseUrl),
//           );

//           setState(() {
//             final map = json.decode(response.body);
//             _post = map as List<dynamic>;
//             body = response.body;
//             loading = false;
//           });
//         },
//         child: Icon(
//           Icons.send_rounded,
//           color: Colors.purple,
//         ),
//       ),
//     );
//   }
// }
