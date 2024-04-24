import 'dart:convert';

import 'package:flutter/material.dart';

import 'user.dart';

void main() {
  runApp(JsonSerializeApp());
}

class JsonSerializeApp extends StatelessWidget {
  const JsonSerializeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> usersFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    usersFuture = getUsers(context);
  }

  static Future<List<User>> getUsers(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString("data/news.json");

    final body = jsonDecode(data);
    return body.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'List View with JSON',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: usersFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data!;

              return buildUsers(users);
            } else {
              return const Text(
                'No user data',
                style: TextStyle(),
              );
            }
          },
        ),
      ),
    );
  }

  ListView buildUsers(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, int index) {
        final user = users[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage("news/" + user.image),
            ),
            title: Text(
              user.title,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              user.summary,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}
