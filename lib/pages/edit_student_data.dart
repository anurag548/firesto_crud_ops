// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:firesto_crud_ops/services/upload_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  // ignore: prefer_typing_uninitialized_variables
  var uploadImage;
  File? filePath;

  @override
  void initState() {
    _studentemail.text = widget.email;
    _studentname.text = widget.name;
    _studentpassword.text = widget.password;
    super.initState();
  }

  Future _getGallery() async {
    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        filePath = File(pick.path);
      });
      print(pick.path);
    }
  }

  void _getCamera() async {
    final pick = await ImagePicker().pickImage(source: ImageSource.camera);
  }

  Future updateUser({required String ename, eemail, epassword}) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(widget.studentIndex)
        .update({'name': ename, 'email': eemail, 'password': epassword});
  }

  _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Change profile picture'),
            content: SingleChildScrollView(
                child: ListBody(children: [
              const Divider(height: 1, color: Colors.black),
              ListTile(
                onTap: () => {_getGallery(), Navigator.pop(context)},
                title: const Text('Upload from file'),
                leading: const Icon(Icons.image),
              ),
              ListTile(
                onTap: _getCamera,
                title: const Text('Upload from camera'),
                leading: const Icon(Icons.camera_alt),
              )
            ])),
          );
        });
  }

  Future uploadToFireStorage() async {
    var file = File(filePath!.path);
    FirebaseStorage store = FirebaseStorage.instance;
    Reference ref = store
        .ref('StudentProfilePic')
        .child(widget.name)
        .child('ProfilePic.jpg');
    UploadTask upload = ref.putFile(file);
    await upload;
  }

  Future downImage() async {
    return FirebaseStorage.instance
        .ref('StudentProfilePic')
        .child(widget.name)
        .child('ProfilePic.jpg')
        .getDownloadURL();
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
                margin: const EdgeInsets.all(10),
                alignment: AlignmentDirectional.topCenter,
                child: Stack(children: [
                  CircleAvatar(
                      radius: 100,
                      child: FutureBuilder(
                          future: downImage(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return CircleAvatar(
                                radius: 90,
                                backgroundImage: NetworkImage(snapshot.data!),
                              );
                            } else
                              return CircularProgressIndicator();
                          })),
                  Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                          child: Padding(
                              padding: const EdgeInsets.all(1.2),
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt),
                                onPressed: () => _showMyDialog(),
                              )),
                          decoration: BoxDecoration(
                              border: Border.all(width: 3, color: Colors.white),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(2, 4),
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 3)
                              ])))
                ])),
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
                        uploadToFireStorage();
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
