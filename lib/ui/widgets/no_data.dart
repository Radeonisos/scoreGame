import 'package:flutter/material.dart';

class NoData extends StatelessWidget {

  final String data;

  NoData(this.data);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        data,
        style: TextStyle(
          color: Colors.teal,
          fontSize: 25,
          fontStyle: FontStyle.italic
        )
      ),
    );
  }

}