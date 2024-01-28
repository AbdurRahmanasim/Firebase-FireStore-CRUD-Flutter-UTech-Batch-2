import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Realtime extends StatefulWidget {
  const Realtime({super.key});

  @override
  State<Realtime> createState() => _RealtimeState();
}

class _RealtimeState extends State<Realtime> {
  final _dbRealTime = FirebaseDatabase.instance.ref('newRef');
  final _dbRealTime1 = FirebaseDatabase.instance.ref('flutter');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REALTIME"),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          FirebaseAnimatedList(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            query: _dbRealTime,
            itemBuilder: (context, snapshot, animation, index) {
              return ListTile(
                title: Text(snapshot.child("name").value.toString()),
              );
            },
          ),

          // FirebaseAnimatedList(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   query: _dbRealTime,
          //   itemBuilder: (context, snapshot, animation, index) {
          //     return ListTile(
          //       title: Text(snapshot.child('Data').value.toString()),
          //     );
          //   },
          // ),
          ElevatedButton(
              onPressed: () {
                // _dbRealTime.set("Hello");

                _dbRealTime
                    .child(DateTime.now().microsecondsSinceEpoch.toString())
                    .set({"id": 124122, "name": "Ali"});

                _dbRealTime1.set("Flutter is great");

                // _dbRealTime
                //     .child("2")
                //     .child("path")
                //     .set({"id": 14541, "Data": "Hello1 World"}).then((value) {
                //   print("Success");
                // }).onError((error, stackTrace) {
                //   print("Erorr Occured");
                // });
                // _dbRealTime
                //     .child(DateTime.now().microsecondsSinceEpoch.toString())
                //     .set({"id": 14541, "Data": "Hello111 World"}).then((value) {
                //   print("Success");
                // }).onError((error, stackTrace) {
                //   print("Erorr Occured");
                // });

                // _dbRealTime.remove();
                // set({"id": 14541, "Data": "Hello1 World"});
              },
              child: Text("SEND")),
          ElevatedButton(
              onPressed: () {
                _dbRealTime.remove();
              },
              child: Text('REMOVE'))
        ]),
      ),
    );
  }
}
