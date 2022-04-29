// ignore_for_file: camel_case_types

import 'package:firesto_crud_ops/pages/add_student.dart';
import 'package:firesto_crud_ops/pages/list_student.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('FireStore operations'),
          ElevatedButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => addStudentPage())),
            child: const Text(
              'Add Student',
              style: TextStyle(fontSize: 20.0),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple, maximumSize: const Size(200, 50)),
          )
        ]),
      ),
      body: const listStudentPage(),
    );
  }
}
