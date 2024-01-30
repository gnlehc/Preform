import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/*
void main() {
  runApp(MaterialApp(home: JobCard()));
}
*/

class JobCard extends StatefulWidget {
  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  double progressValue = 0.5; // Example progress value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(25),
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: const Color(0xFFFF6C37)),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset("lib/images/data_chart_icon.svg"),
                    SizedBox(width: 13),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Data Scientist',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Entry-Level',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, // Set the border color
                      width: 2.0, // Set the border width
                    ),
                    borderRadius: BorderRadius.circular(10), // Set the border radius
                  ),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                    AlwaysStoppedAnimation<Color>(const Color(0xFFFF6C37)),
                  ),
                ),

                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement view feedback action
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'View feedback',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
