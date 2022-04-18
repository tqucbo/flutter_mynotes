import 'package:flutter/material.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({ Key? key }) : super(key: key);

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghi chú mới'),
      ),
      body: const Text('Viết ghi chú mới của bạn ở đây.'),
    );
  }
}