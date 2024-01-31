import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MaterialApp(home: OpenInterviewCard()));
}

class OpenInterviewCard extends StatefulWidget {
  @override
  _OpenInterviewCardState createState() => _OpenInterviewCardState();
}

class _OpenInterviewCardState extends State<OpenInterviewCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: const Color(0xFFFF6C37)),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFF6C37), // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: SvgPicture.asset(
                          'lib/images/microsoft.svg',
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Software Engineer - Backend',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Microsoft Corporation',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              VerticalDivider(
                                  width: 3, color: Colors.transparent),
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 12,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 15,
                  thickness: 1,
                  color: Colors.transparent,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildInfoItem(
                          Icons.location_on, 'San Fransisco, California'),
                      _buildInfoItem(Icons.work, 'Full-Time'),
                      _buildInfoItem(Icons.monetization_on, 'Negotiable'),
                    ],
                  ),
                ),
                Divider(
                  height: 10,
                  thickness: 1,
                  color: Colors.transparent,
                ),
                IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 32,
                        // Set the desired width  // Set the desired height
                        child: TextButton(
                          onPressed: () {
                           // do something...
                          },
                          child: Text(
                            'On-site',
                            style: TextStyle(fontSize: 11),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.pink[100],
                            foregroundColor: Colors.pink,
                          ),
                        ),
                      ),
                      VerticalDivider(
                          width: 10, thickness: 1, color: Colors.transparent),
                      Container(
                        height: 30,
                        // Set the desired width  // Set the desired height
                        child: TextButton(
                          onPressed: () {
                            // do something ...
                          },
                          child: Text(
                            'Priority Slots Available',
                            style: TextStyle(fontSize: 9),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.teal[100],
                            foregroundColor: Colors.teal[500],
                          ),
                        ),
                      ),
                      Divider(height: 15, color: Colors.transparent),
                    ],
                  ),
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
                        Text('Start Interview'),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFFF6C37), // Text color
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Colors.black, size: 16),
        SizedBox(width: 12),
        Text(text),
      ],
    );
  }
}
