import 'package:flutter/material.dart';

class TextAlternate extends StatelessWidget{

  final String string;
  final String alternate;
  final double size;
  final Color color;
  final TextAlign align;


  TextAlternate({@required this.string, this.alternate, this.size, this.color,  this.align});

  @override
  Widget build(BuildContext context) {
    if ( string != null) {
      return text(string);
    } else if (alternate != null){
      return text(alternate);
    } else {
      return Container(height: 1,);
    }
  }

  Text text(String string){
    return Text(
      string,
      style: TextStyle(
        fontSize: size ?? 14,
        color: color ?? Colors.black
      ),
      textAlign: this.align ?? TextAlign.justify,
    );
  }

}