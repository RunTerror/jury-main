import 'package:flutter/material.dart';

import '../mkres.dart';

class addcasenavbarbutton extends StatelessWidget {
  const addcasenavbarbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: make_responsive('h', 12, context)),
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFC99F4A),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
