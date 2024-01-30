import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MaterialApp(
      home: PrevInterviewCard(
    progressValue: 0.1,
    numberPercentage: 10,
  )));
}

class PrevInterviewCard extends StatefulWidget {
  final double progressValue;
  final int numberPercentage;

  const PrevInterviewCard({
    Key? key,
    required this.progressValue,
    required this.numberPercentage,
  }) : super(key: key);

  @override
  _PrevInterviewCardState createState() => _PrevInterviewCardState();
}

class _PrevInterviewCardState extends State<PrevInterviewCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: const Alignment(0.6, 0.6), children: [
      // pake stack supaya iconnya ada di atas cardnya
      // Add icon nya disini

      Card(
          margin: const EdgeInsets.all(25),
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: const Color(0xFFFF6C37)),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: 300,
            // borderRadius: BorderRadius.circular(10.0) ,
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
                  padding: EdgeInsets.only(top: 10.0),
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
                  padding: EdgeInsets.only(bottom: 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Entry-Level',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Set the border color
                        width: 2.0, // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(10), // Set the border radius
                    ),
                    child: ClipRRect(
                    // Wrap LinearProgressIndicator with ClipRRect
                    borderRadius: BorderRadius.circular(10.0),
                    // Adjust the radius as needed
                    child: LinearProgressIndicator(
                      value: widget.progressValue,
                      minHeight: 10,
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFFF6C37)),
                    ),
                  ),
                  )

                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  // Adjust the left margin as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Score: ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.numberPercentage.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text("/100",
                          style: const TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Column(children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      child: Text('Try Again',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF6C37),
                      borderRadius: BorderRadius.circular(
                          4.0), // Optional: Add borderRadius
                    ),
                  ),
                ])
                //const SizedBox(width: 7)
              ],
            ),
          )),
      // Image.asset('images/iconCode.svg'),
    ]);
  }
}
