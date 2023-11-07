import 'package:flutter/material.dart';

class Timecard extends StatefulWidget {
  // String quantity = "Total";
  // String left = "20";
  final String quantity;
  final String left;

  const Timecard({
    super.key,
    required this.left,
    required this.quantity,
  });

  @override
  State<Timecard> createState() => _TimecardState();
}

class _TimecardState extends State<Timecard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 144,
              width: 115,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(width: 3, color: const Color(0xffC99F4A)),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                transform: Matrix4.translationValues(30, 40, 0),
                child: Text(
                  widget.quantity,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Satoshi',
                    fontSize: 30,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(35, 50, 0),
                child: Text(
                  widget.left,
                  style: const TextStyle(
                    color: Color(0xffC99F4A),
                    fontFamily: 'Satoshi',
                    fontSize: 30,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
