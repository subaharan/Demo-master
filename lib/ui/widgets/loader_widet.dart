import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  LoaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Please Wait...",
                textAlign: TextAlign.center,
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            )
          ],
        ),
      );
  }
}
