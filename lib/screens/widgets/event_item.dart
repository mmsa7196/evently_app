import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
              width: 2
        ),
      ),
      child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
        height: 230,
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset("assets/images/birthday.png",fit: BoxFit.fill,
                  height:double.infinity ,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text("This is a Birthday Party ",style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black
                      ),),
                      Spacer(),
                      Icon(Icons.favorite,color: Theme.of(context).primaryColor,)
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left:  8,top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("21"),
                  Text("Dec"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
