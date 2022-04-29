// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class editStudentData extends StatefulWidget {
  const editStudentData({Key? key}) : super(key: key);

  @override
  State<editStudentData> createState() => _editStudentDataState();
}

class _editStudentDataState extends State<editStudentData> {
  final _formkey = GlobalKey<FormState>();

  updateUser() {
    print('user updated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Student data')),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                  initialValue: "Name here",
                  autofocus: false,
                  onChanged: (value) => {},
                  decoration: const InputDecoration(
                      labelText: 'Name:',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a name';
                    }
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                  initialValue: "example@email.com",
                  autofocus: false,
                  onChanged: (value) => {},
                  decoration: const InputDecoration(
                      labelText: 'Email:',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a email';
                    }
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                  initialValue: "Password",
                  autofocus: false,
                  onChanged: (value) => {},
                  decoration: const InputDecoration(
                      labelText: 'Password:',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter password';
                    }
                  }),
            ),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        updateUser();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Update')),
                ElevatedButton(onPressed: null, child: const Text('Reset'))
              ],
            ))
          ]),
        ),
      ),
    );
  }
}
