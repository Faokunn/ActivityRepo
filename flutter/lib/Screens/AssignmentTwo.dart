import 'package:application/widget/CustomListTile.dart';
import 'package:flutter/material.dart';

class Assignmenttwo extends StatefulWidget {
  const Assignmenttwo({super.key});

  @override
  State<Assignmenttwo> createState() => _AssignmenttwoState();
}

class _AssignmenttwoState extends State<Assignmenttwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignment Two"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: ListView(
            children: const <Widget>[
              CustomlistTile(country: "Canda",image: "canada", continent: 'North America',language: 'French/English'),
              SizedBox(height: 10,),
              CustomlistTile(country: "China",image: "china", continent: 'Asia',language: 'Mandarin'),
              SizedBox(height: 10,),
              CustomlistTile(country: "France",image: "france", continent: 'Europe',language: 'French'),
              SizedBox(height: 10,),
              CustomlistTile(country: "Germany",image: "germany", continent: 'Europe',language: 'German'),
              SizedBox(height: 10,),
              CustomlistTile(country: "Italy",image: "italy", continent: 'Europe',language: 'Italian'),
              SizedBox(height: 10,),
              CustomlistTile(country: "Japan",image: "japan", continent: 'Asia',language: 'Japanese'),
              SizedBox(height: 10,),
              CustomlistTile(country: "Philippines",image: "philippines", continent: 'Asia',language: 'Filipino'),
              SizedBox(height: 10,),
              CustomlistTile(country: "South Korea",image: "south-korea", continent: 'Asia',language: 'Korean'),
              SizedBox(height: 10,),
              CustomlistTile(country: "Sweden",image: "sweden", continent: 'Europe',language: 'Swedish'),
              SizedBox(height: 10,),
              CustomlistTile(country: "United Kingdom",image: "united-kingdom", continent: 'Europe',language: 'English'),
              SizedBox(height: 10,),
            ]
          ),
        )
      );
  }
}