import 'package:application/Screens/AssignmentOne.dart';
import 'package:application/Screens/AssignmentTwo.dart';
import 'package:application/Screens/AssignmentThree/Read.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: '/',
      routes: {
        '/assignmentOne': (context) => const AssignmentOne(),
        '/assignmentTwo': (context) => const Assignmenttwo(),
        '/assignmentThree': (context) => const ReadRequest(),
        },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void screen(String choice){
    switch (choice) {
      case "1":
        Navigator.pushNamed(context, '/assignmentOne');
        break;
      case "2":
        Navigator.pushNamed(context, '/assignmentTwo');
      break;
      case "3":
        Navigator.pushNamed(context, '/assignmentThree');
      break;
      default:
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignment"),
        backgroundColor: Colors.blue,
      ),
      body:   Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            ElevatedButton(
              onPressed: () => screen("1"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: const Color.fromARGB(255, 100, 100, 100),
                foregroundColor:const Color.fromARGB(255, 0, 0, 0)
                ), 
              child: const Text("Assignment One"),
              ),
            ElevatedButton(
              onPressed: () => screen("2"), 
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: const Color.fromARGB(255, 100, 100, 100),
                foregroundColor:const Color.fromARGB(255, 0, 0, 0)
                ), 
              child: const Text("Assignment Two")
              ),
            ElevatedButton(
              onPressed: () => screen("3"), 
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: const Color.fromARGB(255, 100, 100, 100),
                foregroundColor:const Color.fromARGB(255, 0, 0, 0)
                ), 
              child: const Text("Assignment Three")),
          ],),
      ),
    )
    );
  }
}

