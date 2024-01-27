import 'package:class19/screens/dataList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subTitleController = TextEditingController();

  sendDataToFireStore() async {
    final _db = FirebaseFirestore.instance;

    final dataList = {
      "title": _titleController.text,
      "subTitle": _subTitleController.text,
      "time": DateTime.now().toString()
    };

    await _db.collection("datalist").add(dataList).whenComplete(() {
      print("SuccessFully Submitted");
      _titleController.clear();
      _subTitleController.clear();
    });
  }

  gotoDataList() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DataList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                        hintText: "Title", border: OutlineInputBorder()),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _subTitleController,
                    decoration: const InputDecoration(
                        hintText: "Sub Title", border: OutlineInputBorder()),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: sendDataToFireStore, child: const Text("SUBMIT")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: gotoDataList, child: const Text("DataList Page")),
            )
          ],
        ),
      ),
    );
  }
}
