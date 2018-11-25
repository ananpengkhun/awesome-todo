import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyMain());

class MyMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyMainState();
  }
}

class _MyMainState extends State<MyMain> {
  var myCollection = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "my app main",
      home: Scaffold(
        appBar: AppBar(
          title: Text('this my main'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: myCollection.collection('todo').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Text(snapshot.data.documents[index].data['title']),
                      Checkbox(
                          value: snapshot.data.documents[index].data['isDone'],
                          onChanged: (value) {
                            print('path :' +snapshot.data.documents[index].reference.path);
                            updateNote(
                                snapshot.data.documents[index], value);
                          })
                    ],
                  ),
                );
              },
              itemCount: snapshot.data.documents.length,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          var data = new Map<String, dynamic>();
          data['title'] = "men add na kub";
          data['isDone'] = false;
          myCollection.collection('todo').add(data);
        }),
      ),
    );
  }

  Future<dynamic> updateNote(DocumentSnapshot data, bool value) async {
    data.data['isDone'] = value;
    myCollection.document(data.reference.path).updateData(data.data);
  }
}
