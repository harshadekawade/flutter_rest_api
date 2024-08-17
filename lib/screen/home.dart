import 'package:fetch_data_from_api/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<User>> fetchUser() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    return userFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder<List<User>>(
        future: fetchUser(),
        builder: (context, snapshot) {
          List<User>? data = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.all(5),
                  color: Colors.blueGrey[50],
                  child: ListTile(
                    title: Text('${data![index].title}'),
                    subtitle: Text('${data[index].body}'),
                  )),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
