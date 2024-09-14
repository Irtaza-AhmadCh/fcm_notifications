import 'package:flutter/material.dart';

class MessageScreeen extends StatefulWidget {
  final String message;
  const MessageScreeen({super.key, required this.message, });

  @override
  State<MessageScreeen> createState() => _MessageScreeenState();
}

class _MessageScreeenState extends State<MessageScreeen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Massage Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(child: Text(widget.message))
          ],
        ),
      ),
    );
  }
}
