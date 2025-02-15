import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:spend_spent_spent/globals.dart';
import 'package:spend_spent_spent/icons.dart';
import 'package:spend_spent_spent/models/appColors.dart';
import 'package:spend_spent_spent/models/category.dart';
import 'package:spend_spent_spent/utils/colorUtils.dart';

class Step1 extends StatefulWidget {
  Function setCategory, setName;
  Category? selected;
  String name;

  Step1({required this.setCategory, this.selected, required this.setName, required this.name});

  @override
  Step1State createState() => Step1State();
}

class Step1State extends State<Step1> with AfterLayoutMixin {
  List<Category> categories = [];
  TextEditingController nameController = TextEditingController(text: '');

  getCategories() {
    service.getCategories().then((value) {
      setState(() {
        categories = value;
      });
    });
  }

  onSelect(Category e) {
    widget.setCategory(e);
  }

  @override
  Widget build(BuildContext context) {
    AppColors colors = get(context);
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlatformTextField(
              controller: nameController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              hintText: 'A name maybe ?',
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 8.0,
                  runSpacing: 4,
                  children: categories
                      .map((e) => GestureDetector(
                            onTap: () => onSelect(e),
                            child: AnimatedContainer(
                              decoration: BoxDecoration(
                                borderRadius: defaultBorder,
                                color: (widget.selected?.icon ?? '') != e.icon ? colors.dialogBackground : colors.main,
                              ),
                              duration: panelTransition,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: getIcon(e.icon!, size: 30, color: (widget.selected?.icon ?? '') == e.icon ? colors.iconOnMain : colors.main),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getCategories();
    nameController.text = widget.name;
    nameController.addListener(() {
      widget.setName(nameController.value.text);
    });
  }
}
