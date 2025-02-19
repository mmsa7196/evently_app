import 'package:flutter/material.dart';

class EventCategoryItem extends StatelessWidget {
  String eventType;
  bool isSelected;

  EventCategoryItem(
      {required this.eventType, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(37),
      ),
      child: Text(
        eventType,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: isSelected ? Colors.white : Theme.of(context).primaryColor),
      ),
    );
  }
}
