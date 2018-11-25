import 'package:flutter/material.dart';

void main() => runApp(MyMain());

class MyMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyMainState();
  }
}

class Person {
  final String name;
  bool isCheck;

  Person({this.name, this.isCheck});
}

class _MyMainState extends State<MyMain> {
  List<Person> _person = [
    Person(name: "men", isCheck: true),
    Person(name: "men", isCheck: true),
    Person(name: "men", isCheck: true),
    Person(name: "men", isCheck: true),
    Person(name: "men", isCheck: true),
    Person(name: "men", isCheck: true),
    Person(name: "men", isCheck: true)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "my app main",
      home: Scaffold(
        appBar: AppBar(
          title: Text('this my main'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(children: <Widget>[
                Text(
                  _person[index].name,
                ),
                Checkbox(
                    value: _person[index].isCheck,
                    onChanged: (value) {
                      _changeValue(value, index);
                    })
              ]),
            );
          },
          itemCount: _person.length,
        ),
      ),
    );
  }

  void _changeValue(bool value, int index) {
    setState(() {
      _person[index].isCheck = value;
    });
  }
}
