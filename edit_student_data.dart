// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class editStudentData extends StatefulWidget {
  var studentIndex;
  String name, email, password;
  editStudentData(
    this.studentIndex,
    this.name,
    this.email,
    this.password,
  );

  @override
  State<editStudentData> createState() => _editStudentDataState();
}

class _editStudentDataState extends State<editStudentData> {
  var name = "";
  var email = "";
  var password = "";
  final _studentname = TextEditingController();
  final _studentemail = TextEditingController();
  final _studentpassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _studentemail.text = widget.email;
    _studentname.text = widget.name;
    _studentpassword.text = widget.password;
  }

  Future updateUser({required String ename, eemail, epassword}) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(widget.studentIndex)
        .update({'name': ename, 'email': eemail, 'password': epassword});
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
              alignment: AlignmentDirectional.topCenter,
              child: Image.asset(
                'images/studentImages.jpg',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                  controller: _studentname,
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
                  controller: _studentemail,
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
                  controller: _studentpassword,
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
                        setState(() {
                          name = _studentname.text;
                          email = _studentemail.text;
                          password = _studentpassword.text;
                        });
                        updateUser(
                            ename: name, eemail: email, epassword: password);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Update')),
                ElevatedButton(
                    onPressed: () => {print(widget.studentIndex)},
                    child: const Text('Reset'))
              ],
            ))
          ]),
        ),
      ),
    );
  }
}
