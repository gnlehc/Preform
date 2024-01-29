import 'package:flutter/material.dart';

class CardExample extends StatefulWidget {
  final double progressValue;
  final int numberPercentage;

  const CardExample({
    Key? key,
    required this.progressValue,
    required this.numberPercentage,
  }) : super(key: key);

  @override
  _CardExampleState createState() => _CardExampleState();
}

class _CardExampleState extends State<CardExample> {


  @override
  Widget build(BuildContext context) {
    return Stack(alignment: const Alignment(0.6, 0.6),
        children: [
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
            // borderRadius: BorderRadius.circular(10.0) ,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  // leading: ImageSection(image: 'images/code_icon_revisipng.png'),
                  title: Text('Frontend Developer'),
                  subtitle: Text('Entry Level'),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
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
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
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

