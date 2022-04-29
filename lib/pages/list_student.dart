// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firesto_crud_ops/pages/edit_student_data.dart';
import 'package:flutter/material.dart';

class listStudentPage extends StatefulWidget {
  const listStudentPage({Key? key}) : super(key: key);

  @override
  State<listStudentPage> createState() => _listStudentPageState();
}

class _listStudentPageState extends State<listStudentPage> {
  final List storedocs = [];
  final Stream<QuerySnapshot> studentStream =
      FirebaseFirestore.instance.collection('students').get().asStream();

  deleteUser(id) {
    print("User Deleted $id");
  }

  Future getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('students').get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return
        // FutureBuilder(
        //   future: getData(),
        //   builder: (context, AsyncSnapshot snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       print(snapshot.data!.data['stud1'].toString());
        //     } else if (snapshot.connectionState == ConnectionState.waiting) {
        //       print("Loading");
        //     } else if (snapshot.connectionState == ConnectionState.active) {
        //       print("Still loading");
        //     }
        //     return SizedBox();
        //   },
        // );
        StreamBuilder<QuerySnapshot>(
            stream: studentStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print('Error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data!.toString());
                print(snapshot.data!.docs.map((e) => print(e.data)));
                snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map a = document.data() as Map<String, dynamic>;
                  storedocs.add(a);
                }).toList();
                print(storedocs);
              }

              return Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                child: SingleChildScrollView(
                    child: Table(
                  border: TableBorder.all(),
                  columnWidths: const/*<int, TableColumnWidth>*/ {
                    1: FixedColumnWidth(140)
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: Container(
                        color: Colors.blue[700],
                        child: const Center(
                            child: Text('Name',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold))),
                      )),
                      TableCell(
                          child: Container(
                        color: Colors.blue[700],
                        child: const Center(
                            child: Text('Email',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold))),
                      )),
                      TableCell(
                          child: Container(
                        color: Colors.blue[700],
                        child: const Center(
                            child: Text('Action',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold))),
                      ))
                    ]),
                    TableRow(children: [
                      const TableCell(
                        child: Center(child: Text('Name here')),
                      ),
                      const TableCell(
                        child: Center(child: Text('Email here')),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            editStudentData())),
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () =>
                                    {/*deleteUser(1)*/ print(storedocs)},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ))
                          ],
                        ),
                      ),
                    ])
                  ],
                )),
              );
            });
  }
}
