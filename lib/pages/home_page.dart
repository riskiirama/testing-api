import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:testing_api/config/api.dart';

import 'package:testing_api/routes/route.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  final GetStorage box = GetStorage();

  Future<void> getData() async {
    try {
      var response = await http.get(
        Uri.parse(apiUrl),
      );

      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('User List'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: getData(),
          builder: (BuildContext, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (BuildContext, int index) {
                    var el = snapshot.data['data'][index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          RouteHelper.detail,
                          parameters: {
                            'name': 'firstname',
                          },
                        );
                        box.write(
                          'key',
                          {
                            'avatar': el['avatar'],
                            'name': el['first_name'] + ' ' + el['last_name'],
                            'email': el['email']
                          },
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            el['avatar'],
                          ),
                        ),
                        title: Text(
                          el['first_name'] + ' ' + el['last_name'],
                        ),
                        subtitle: Text(
                          el['email'],
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
