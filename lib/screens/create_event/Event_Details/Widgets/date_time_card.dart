import 'package:easy_localization/easy_localization.dart' show DateFormat;
import 'package:flutter/material.dart';
class DateTimeCard extends StatelessWidget {
  final int date;
  final bool time;

  const DateTimeCard({required this.date, required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2) ,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.calendar_month, color: Theme.of(context).scaffoldBackgroundColor,size: 32,),
          ),
          SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: ${DateFormat('yyyy-MM-dd').format(dateTime)}', style: Theme.of(context).textTheme.titleSmall),
                Text(TimeOfDay(hour: dateTime.hour, minute: dateTime.minute).format(context), style: Theme.of(context).textTheme.titleSmall)
              ],
            ),
          ),
        ],

      ),
    );
  }
}
