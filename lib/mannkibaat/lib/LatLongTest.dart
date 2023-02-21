import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LatLongTest extends StatefulWidget {
  const LatLongTest({Key? key}) : super(key: key);

  @override
  State<LatLongTest> createState() => _LatLongTestState();
}

class _LatLongTestState extends State<LatLongTest> {
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text("Get Location"),
              ElevatedButton(
                  onPressed: () {
                    final _currentPosition = this._currentPosition;
                    if (_currentPosition != null)
                      Text(
                          "LAT: ${_currentPosition.latitude.toString()}, LNG: ${_currentPosition.longitude}");
                  },
                  child: Text("Press for Location"))
            ],
          ),
        ),
      ),
    );
  }

  getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
