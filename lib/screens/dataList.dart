import 'package:class19/screens/editScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataList extends StatefulWidget {
  const DataList({super.key});

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  Future<void> deleteDocument(String documentId) async {
    await FirebaseFirestore.instance
        .collection('datalist')
        .doc(documentId)
        .delete();
    setState(() {});
  }

  Future<void> editDocument(String documentId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditScreen(documentId)),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DataList"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: FirebaseFirestore.instance.collection("datalist").get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  // Snapshot has data
                  QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
                  List<DocumentSnapshot> documents = querySnapshot.docs;

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      // Access the data of each document using documents[index].data()
                      Map<String, dynamic> data =
                          documents[index].data() as Map<String, dynamic>;

                      // Display data in a ListTile
                      return ListTile(
                        title: Text(
                          data['title'],
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          data['subTitle'],
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              data['time'],
                              style: TextStyle(color: Colors.black),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                editDocument(documents[index].id);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteDocument(documents[index].id);
                              },
                            ),
                          ],
                        ),
                        // Add more widgets to display other data as needed
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
