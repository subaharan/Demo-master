import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  NoDataWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("No Data Found",
              textAlign: TextAlign.center,
              style:
              TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87)),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
