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
  // List storedocs = [];
  // final Stream<QuerySnapshot> studentStream =
  //     FirebaseFirestore.instance.collection('students').get().asStream();

  // deleteUser(id) {
  //   print("User Deleted $id");
  // }

  Future getData() async {
    // await FirebaseFirestore.instance
    // .collection('students')
    // .get()
    // .then((QuerySnapshot qn) {
    // print(qn.docs);
    // return qn.docs;
    // });

    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('students').get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          getData();
        });
      },
      child: FutureBuilder(
          future: getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // print(snapshot.data!['stud2'].toString());
              return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  child: ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Column(children: <Widget>[
                            ListTile(
                              title: Text(snapshot.data[index]['name']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data[index]['email']),
                                ],
                              ),
                              onTap: () {
                                print(snapshot.data[index]['password']);
                              },
                              leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('images/studentImages.jpg')),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      editStudentData(
                                                        snapshot.data[index].id,
                                                        snapshot.data[index]
                                                            ['name'],
                                                        snapshot.data[index]
                                                            ['email'],
                                                        snapshot.data[index]
                                                            ['password'],
                                                      )));
                                        }),
                                    InkWell(
                                      child: const Icon(Icons.delete),
                                      onTap: () {
                                        FirebaseFirestore.instance
                                            .collection('students')
                                            .doc(snapshot.data[index].id)
                                            .delete();
                                      },
                                    ),
                                  ]),
                              // IconButton(
                              //   padding: EdgeInsets.zero,
                              //   icon: const Icon(Icons.delete),
                              //   onPressed: () {},
                              // ),
                            )
                          ]));
                    },
                  ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              print("Loading");
            } else if (snapshot.connectionState == ConnectionState.active) {
              print("Still loading");
            }
            return SizedBox();
          }),
    );
  }
}   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // StreamBuilder<QuerySnapshot>(
    //     stream: studentStream,
    //     builder:
    //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (snapshot.hasError) {
    //         print('Error');
    //       }
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(child: CircularProgressIndicator());
    //       }
    //       snapshot.data!.docs.map((DocumentSnapshot document) {
    //         Map a = document.data() as Map<String, dynamic>;
    //         storedocs.add(a);
    //       }).toList();

    // SingleChildScrollView(
    //     child: Table(
    //         border: TableBorder.all(),
    //         columnWidths: const <int, TableColumnWidth>{
    //           1: FixedColumnWidth(140)
    //         },
    //         defaultVerticalAlignment:
    //             TableCellVerticalAlignment.middle,
    //         children: [
    //           TableRow(children: [
    //             TableCell(
    //                 child: Container(
    //               color: Colors.blue[700],
    //               child: const Center(
    //                   child: Text('Name',
    //                       style: TextStyle(
    //                           fontSize: 20.0,
    //                           fontWeight: FontWeight.bold))),
    //             )),
    //             TableCell(
    //                 child: Container(
    //               color: Colors.blue[700],
    //               child: const Center(
    //                   child: Text('Email',
    //                       style: TextStyle(
    //                           fontSize: 20.0,
    //                           fontWeight: FontWeight.bold))),
    //             )),
    //             TableCell(
    //                 child: Container(
    //               color: Colors.blue[700],
    //               child: const Center(
    //                   child: Text('Action',
    //                       style: TextStyle(
    //                           fontSize: 20.0,
    //                           fontWeight: FontWeight.bold))),
    //             ))
    //           ]),
    //           for (var i = 0;
    //               i < snapshot.data!.docs.length;
    //               i++) ...[
    //             TableRow(children: [
    //               TableCell(
    //                 child:
    //                     Center(child: Text(storedocs[i]['name'])),
    //               ),
    //               TableCell(
    //                 child: Center(
    //                     child: Text(
    //                   storedocs[i]['email'],
    //                   style: TextStyle(fontSize: 18),
    //                 )),
    //               ),
    //               TableCell(
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     IconButton(
    //                         onPressed: () => Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) =>
    //                                     editStudentData())),
    //                         icon: const Icon(Icons.edit)),
    //                     IconButton(
    //                         onPressed: () => {
    //                               /*deleteUser(1)*/ print(storedocs)
    //                             },
    //                         icon: const Icon(
    //                           Icons.delete,
    //                           color: Colors.redAccent,
    //                         ))
    //                   ],
    //                 ),
    //               ),
    //             ])
    //           ],
    //         ])),
 