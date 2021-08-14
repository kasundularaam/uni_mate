import 'package:location/location.dart';

class MyLocationService {
  static Location location = new Location();
  static Future<void> enableServicesAndPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  static Future<LocationData> getCurrentLocation() async {
    LocationData locationData = await location.getLocation();
    return locationData;
  }
}
