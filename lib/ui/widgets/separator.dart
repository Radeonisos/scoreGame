import 'package:flutter/material.dart';

class Separator extends Padding {

  Separator(): super(
    padding: EdgeInsets.all(15),
    child: Divider(
      color: Colors.teal,
    )
  );
}