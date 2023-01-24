import 'package:flutter/material.dart';

class NotConnected extends StatelessWidget {
  const NotConnected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.signal_wifi_connected_no_internet_4, size: 30),
            SizedBox(height: 20),
            Text("Internet Not Connected")
          ],
        ));
  }
}
