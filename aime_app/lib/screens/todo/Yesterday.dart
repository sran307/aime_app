import 'package:dailyme/constants/constants.dart';
import 'package:flutter/material.dart';

class Yesterday extends StatefulWidget {
  const Yesterday({super.key});

  @override
  State<Yesterday> createState() => _YesterdayState();
}

class _YesterdayState extends State<Yesterday> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pending Actions"),
                Text("27/07/2024"),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width * .1,
                      height: MediaQuery.of(context).size.height * .55,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(96, 180, 39, 39),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(20.0),
                          )
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Icon(Icons.circle_outlined,
                        ))),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * .8,
                    height: MediaQuery.of(context).size.height * .55,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10),
                          child: Text('data',
                          style: TextStyle(
                            
                          ),),
                        ),
                        Divider(
                          color: kDark,
                          thickness: 1,
                          height: 1.0,
                          indent: 10,
                          endIndent: 20,
                        ),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
