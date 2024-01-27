import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditScreen extends StatefulWidget {
  final String documentId;

  EditScreen(this.documentId);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDocumentData();
  }

  Future<void> fetchDocumentData() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('datalist')
        .doc(widget.documentId)
        .get();

    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    titleController.text = data['title'];
    subtitleController.text = data['subTitle'];
  }

  Future<void> updateDocument() async {
    await FirebaseFirestore.instance
        .collection('datalist')
        .doc(widget.documentId)
        .update({
      'title': titleController.text,
      'subTitle': subtitleController.text,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Document'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Call the update function when the check button is pressed
              updateDocument();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(labelText: 'Subtitle'),
            ),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
