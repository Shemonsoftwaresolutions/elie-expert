import 'dart:async';
import 'package:elie_expert/Database/API.dart';
import 'package:elie_expert/Database/Locator.dart';
import 'package:elie_expert/Database/Tracking.dart';
import 'package:location/location.dart';

class LocationTracking {
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _location;
  late LocationData _locationSubscription;

  Future<void> listenLocation() async {
    print('Here - 1');
    location.enableBackgroundMode(enable: true);
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      print('Here - 2');
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Here - 3');
        return;
      }
    }

    //first one
    _locationSubscription = await location.getLocation();
    location.enableBackgroundMode(enable: true);
    _location = _locationSubscription;
    print(_location);

    var parsedLocation =
        LocationForTracking(_location?.latitude, _location?.longitude).toJson();
    var parsedTracking = Tracking(parsedLocation, DateTime.now().toString(),
            DateTime.now().toString(), getItUserIn.userPhone)
        .toJson();
    print(getItUserIn.userPhone);
    print('Adding location');
    API().addLocationTrack(parsedTracking);

    //looping one
    Timer.periodic(Duration(seconds: 60), (t) async {
      _locationSubscription = await location.getLocation();
      location.enableBackgroundMode(enable: true);
      _location = _locationSubscription;
      print(_location);
      print(DateTime.now());

      var parsedLocation =
          LocationForTracking(_location?.latitude, _location?.longitude)
              .toJson();
      var parsedTracking = Tracking(parsedLocation, DateTime.now().toString(),
              DateTime.now().toString(), getItUserIn.userPhone)
          .toJson();
      print(getItUserIn.userPhone);
      await API().addLocationTrack(parsedTracking);
      print('Adding location again');
    });
  }
}
