import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/*
void main() {
  runApp(MaterialApp(home: ExploreMockInterviewCard()));
}

 */

class ExploreMockInterviewCard extends StatefulWidget {
  @override
  _ExploreMockInterviewCardState createState() =>
      _ExploreMockInterviewCardState();
}

class _ExploreMockInterviewCardState extends State<ExploreMockInterviewCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: const Color(0xFFFF6C37), width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                // crossAxisAlignment: CrossAxisAlignment.,
                children: <Widget>[
                  Container(
                    width:
                        50.0, // Set the width and height to make the circle larger
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFF6C37), // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: SvgPicture.asset(
                        'lib/images/microsoft.svg',
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 28,
                                // Set the desired width  // Set the desired height
                                child: TextButton(
                                  onPressed: () {
                                    // do something ...
                                  },
                                  child: Text(
                                    'HR Interview',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.purple[100],
                                    foregroundColor: Colors.deepPurple[500],
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                width: 6,
                              ),
                              Container(
                                height: 28,
                                // Set the desired width  // Set the desired height
                                child: TextButton(
                                  onPressed: () {
                                    // do something ...
                                  },
                                  child: Text(
                                    'Entry Level',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.orange[300],
                                    foregroundColor: Colors.orange[900],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 6,
                          color: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 135),
                          child: Row(children: <Widget>[
                            Container(
                              height: 28,
                              // Set the desired width  // Set the desired height
                              child: TextButton(
                                onPressed: () {
                                  // do something ...
                                },
                                child: Text(
                                  'Recommended by others',
                                  style: TextStyle(fontSize: 9),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.yellow[100],
                                  foregroundColor: Colors.yellow[900],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 10,
                thickness: 1,
                color: Colors.transparent,
              ),
              Container(
                padding: EdgeInsets.only(left: 8, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                            child: Text("Top 10 HR Interview Questions",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24)))
                      ],
                    ),
                    Divider(height: 10, color: Colors.transparent),
                    IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 3, height: 3),
                          Icon(Icons.thumb_up_alt_outlined,
                              size: 12, color: Colors.grey),
                          SizedBox(width: 6),
                          Text(
                            "88% users like this",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 6),
                          VerticalDivider(
                            width: 3,
                            thickness: 1.5,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "2,900 Users",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10,
                thickness: 1,
                color: Colors.transparent,
              ),
              Divider(
                height: 0.5,
                thickness: 1,
                color: Colors.transparent,
              ),
              Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                Spacer(),
                TextButton(
                  onPressed: () {
                    // TODO: Implement start interview action
                  },
                  child: Row(
                    children: [
                      Text('Start Now'),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6C37),
                    foregroundColor: Colors.white, // Text color
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
