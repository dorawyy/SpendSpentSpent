import 'package:app/globals.dart';
import 'package:app/icons.dart';
import 'package:app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryGridItem extends StatefulWidget {
  Category category;

  CategoryGridItem({required this.category});

  @override
  CategoryGridItemState createState() => CategoryGridItemState();
}

class CategoryGridItemState extends State<CategoryGridItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Cat: ${widget.category.icon}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: defaultBorder,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), //color of shadow
              spreadRadius: 2, //spread radius
              blurRadius: 3, // blur radius
              offset: Offset(0, 2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            ),
            //you can set more BoxShadow() here
          ],
          gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.blue],
              stops: [0, 0.5],
              begin: Alignment.bottomCenter,
              end: Alignment.topRight)),
      child: getIcon(widget.category.icon, size: 40),
    );
  }
}
