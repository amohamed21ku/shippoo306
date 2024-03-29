import 'package:flutter/material.dart';
import 'package:shippoo306/models/Info.dart';
import 'package:shippoo306/widgets/infocard.dart';

class InfoList extends StatelessWidget {
  final List<infoCard> info;
  InfoList({required this.info});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return infoCard(
          name: info[index].name,
          Date: info[index].Date,
          onpress: info[index].onpress,
          icon: info[index].icon,
          intial: info[index].intial,
        );
      },
      itemCount: info.length,
    );
  }
}
