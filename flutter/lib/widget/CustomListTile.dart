import 'package:flutter/material.dart';

class CustomlistTile extends StatefulWidget {
  const CustomlistTile({super.key, required this.country, required this.image, required this.continent, required this.language});
  final String image;
  final String country;
  final String continent;
  final String language;
  @override
  State<CustomlistTile> createState() => _CustomlistTileState();
}

class _CustomlistTileState extends State<CustomlistTile> {
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: Text(widget.country),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.continent, style: const TextStyle(color: Colors.black)),
          Text(widget.language, style: const TextStyle(color: Colors.black)),
        ],
      ),
      tileColor: Color.fromARGB(255, 240, 170, 64),
      leading: Image.asset('assets/${widget.image}.png'),
    );
  }
}