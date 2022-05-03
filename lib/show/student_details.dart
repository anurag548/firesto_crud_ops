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
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: const TextStyle(color: Colors.white70, fontSize: 20.0),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.email,
              style: const TextStyle(color: Colors.white54, fontSize: 14.0),
            )
          ],
        ),
        automaticallyImplyLeading: false,
        leading: const CircleAvatar(
            backgroundImage: AssetImage('images/studentImages.jpg')),
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
