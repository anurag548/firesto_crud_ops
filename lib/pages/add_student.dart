import 'package:flutter/material.dart';

class addStudentPage extends StatefulWidget {
  const addStudentPage({Key? key}) : super(key: key);

  @override
  State<addStudentPage> createState() => _addStudentPageState();
}

class _addStudentPageState extends State<addStudentPage> {
  final _formkey = GlobalKey<FormState>();

  var name = "";
  var email = "";
  var password = "";

  final _studentname = TextEditingController();
  final _studentemail = TextEditingController();
  final _studentpassword = TextEditingController();

  @override
  void dispose() {
    _studentname.dispose();
    _studentemail.dispose();
    _studentpassword.dispose();
    super.dispose();
  }

  clearText() {
    _studentemail.clear();
    _studentname.clear();
    _studentpassword.clear();
  }

  addUser() {
    print('User Added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Register New Student",
          style: TextStyle(fontSize: 20),
        )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _studentname,
                    decoration: const InputDecoration(
                        labelText: "Name",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "Name",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                      controller: _studentemail,
                      decoration: const InputDecoration(
                          labelText: "Email",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: "Email",
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null) {
                          return 'Enter a email';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Enter a proper Email';
                        }
                      }),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: _studentpassword,
                    decoration: const InputDecoration(
                        labelText: "Password",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: "Password",
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null) {
                        return 'Password cannot be empty';
                      } else if (value.length < 6) {
                        return 'Password too short, Min. 6 characters';
                      }
                    },
                  ),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: () => {
                                if (_formkey.currentState!.validate())
                                  {
                                    setState(() {
                                      name = _studentname.text;
                                      email = _studentemail.text;
                                      password = _studentpassword.text;
                                      addUser();
                                      clearText();
                                    })
                                  }
                              },
                          child: const Text('Register')),
                      ElevatedButton(
                          onPressed: clearText, child: const Text('Reset'))
                    ],
                  ))
                ],
              )),
        ));
  }
}
