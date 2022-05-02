import 'package:flutter/material.dart';

class studDetails extends StatefulWidget {
  final String name, email;
  const studDetails({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  State<studDetails> createState() => _studDetailsState();
}

class _studDetailsState extends State<studDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        title: Text(widget.name),
        bottom: PreferredSize(
            child: Text(widget.email),
            preferredSize: const Size.fromHeight(10)),
      ),
      body: Container(
        height: 200,
        width: 500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('images/studentImages.jpg'),
          ],
        ),
        color: Colors.amber,
      ),
    );
  }
}
