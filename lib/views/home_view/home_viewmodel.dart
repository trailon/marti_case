import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:marti_case/app/app_defaults.dart';
import 'package:marti_case/models/route_list_model.dart';
import 'package:marti_case/utils/geolocation_mixin.dart';
import 'package:marti_case/views/home_view/_partials/marker_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/blueprints/base_viewmodel.dart';
import '../../utils/pop_messager_mixin.dart';

class HomeViewModel extends BaseViewModel
    with PopMessagerMixin, GeolocationMixin {
  String metersInSecond = '0 m/s';
  bool isMoving = false;
  bool enabled = false;
  bool showPolyline = false;
  bool isUsingGPXfile = false;
  bg.Location? currentLocation;
  List<Marker> currentLocationMarkers = [];
  late List<Marker> markersForEvery100Meters;
  MapController mapController = MapController();
  Polyline polyline = Polyline(points: []);
  @override
  void disposeModel() {}

  @override
  Future<void> testScenario() async {}

  @override
  Future<void> getData() async {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await _forceMovingToTrueIfAndroidEmulatorAndUsingGPXorKMLfile();
      await _fetchRouteList();
      await initBgConfiguration();
      currentLocation = await bg.BackgroundGeolocation.getCurrentPosition();
      setViewDidLoad(true);
    });
  }

  Future<void> _forceMovingToTrueIfAndroidEmulatorAndUsingGPXorKMLfile() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Platform.isAndroid && !androidInfo.isPhysicalDevice) {
      final askIfUsingGPXfile = await askForGPXorKMLfile();
      if (askIfUsingGPXfile == true) {
        isUsingGPXfile = true;
      }
    }
  }

  Future<void> _fetchRouteList() async {
    final prefs = await SharedPreferences.getInstance();
    final routeListJson = prefs.getString('routeList');
    if (routeListJson != null) {
      final routeListModel = RouteListModel.fromJson(jsonDecode(routeListJson));
      markersForEvery100Meters = routeListModel.markers!;
      _updatePolyline();
      notifyListeners();
      return;
    }
    markersForEvery100Meters = [];
    notifyListeners();
  }

  void _onLocation(bg.Location location) {
    metersInSecond = '${location.coords.speed.toStringAsFixed(2)} m/s';
    _updateCurrentLocationMarkers(location);
    _updateMarkerListForEvery100Meters(location);
    _saveCurrentRoute();
    _updatePolyline();
    notifyListeners();
  }

  void _updateMarkerListForEvery100Meters(bg.Location location) {
    if (markersForEvery100Meters.isEmpty) {
      markersForEvery100Meters.add(
        Marker(
          width: AppDefaults.kMarkerWidth,
          height: AppDefaults.kMarkerHeight,
          point: LatLng(location.coords.latitude, location.coords.longitude),
          child: MarkerChild(
            key: ObjectKey(location.coords.latitude),
            location: LatLng(
              location.coords.latitude,
              location.coords.longitude,
            ),
          ),
        ),
      );
      notifyListeners();
      return;
    }
    final lastMarker = markersForEvery100Meters.last;
    final LatLng lastMarkerLatLng = LatLng(
      lastMarker.point.latitude,
      lastMarker.point.longitude,
    );
    final distanceFromLastMarker = Distance().as(
      LengthUnit.Meter,
      lastMarkerLatLng,
      LatLng(location.coords.latitude, location.coords.longitude),
    );
    if (distanceFromLastMarker >= AppDefaults.distanceFromLastMarker) {
      markersForEvery100Meters.add(
        Marker(
          width: AppDefaults.kMarkerWidth,
          height: AppDefaults.kMarkerHeight,
          point: LatLng(location.coords.latitude, location.coords.longitude),
          child: MarkerChild(
            key: ObjectKey(location.coords.latitude),
            location: LatLng(
              location.coords.latitude,
              location.coords.longitude,
            ),
          ),
        ),
      );
      notifyListeners();
    }
  }

  void _updatePolyline() {
    polyline = Polyline(
      color: Colors.red,
      points: markersForEvery100Meters
          .map(
            (marker) => LatLng(marker.point.latitude, marker.point.longitude),
          )
          .toList(),
    );
    notifyListeners();
  }

  void togglePolyline(bool? value) {
    showPolyline = value ?? false;
    notifyListeners();
  }

  void _updateCurrentLocationMarkers(bg.Location location) {
    currentLocationMarkers.clear();
    currentLocationMarkers.add(
      Marker(
        point: LatLng(location.coords.latitude, location.coords.longitude),
        child: Icon(Icons.location_on, color: Colors.blue, size: AppDefaults.currentLocationMarkerSize),
      ),
    );
    if (enabled && super.viewDidLoad) {
      mapController.move(
        LatLng(location.coords.latitude, location.coords.longitude),
        15,
      );
    }
  }

  _saveCurrentRoute() async {
    final routeListModel = RouteListModel(markers: markersForEvery100Meters);
    final routeListJson = routeListModel.toJson();
    final encoded = jsonEncode(routeListJson);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('routeList', encoded);
  }

  resetRoute() async {
    final prefs = await SharedPreferences.getInstance();
    polyline = Polyline(points: [currentLocationMarkers.first.point]);
    await prefs.remove('routeList');
    markersForEvery100Meters = [];
    notifyListeners();
  }

  void _onLocationError(bg.LocationError error) {
    switch (error.code) {
      case 0:
        showError('Location unknown');
        break;
      case 1:
        showError('Location permission denied');
        break;
      case 2:
        showError('Network error');
        break;
      case 3:
        showError(
          'Attempt to initiate location-services in background with WhenInUse authorization',
        );
        break;
      case 408:
        showError('Location timeout');
        break;
    }
  }

  void _onMotionChange(bg.Location location) {
    if (location.isMoving) {
      showInfo('Moving');
    } else {
      showInfo('Stopped');
    }
  }

  Future<void> initBgConfiguration() async {
    bg.BackgroundGeolocation.onLocation(_onLocation, _onLocationError);
    bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
    await bg.BackgroundGeolocation.ready(
          bg.Config(
            reset: true,
            debug: true,
            logLevel: bg.Config.LOG_LEVEL_VERBOSE,
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: 10.0,
            backgroundPermissionRationale: bg.PermissionRationale(
              title:
                  "Allow {applicationName} to access this device's location even when the app is closed or not in use.",
              message:
                  "This app collects location data to enable recording your trips to work and calculate distance-travelled.",
              positiveAction: 'Change to "{backgroundPermissionOptionLabel}"',
              negativeAction: 'Cancel',
            ),
            stopOnTerminate: false,
            startOnBoot: true,
            enableHeadless: true,
          ),
        )
        .then((bg.State state) {
          enabled = state.enabled;
          isMoving = state.isMoving!;
          if (!state.isMoving! && isUsingGPXfile) {
            bg.BackgroundGeolocation.changePace(true);
            isMoving = true;
          }
        })
        .catchError((error) {
          showError('Error initializing background geolocation: $error');
        });
  }

  startStopBackgroundFetch(bool enable) {
    if (enable) {
      bg.BackgroundGeolocation.setOdometer(0);
      bg.BackgroundGeolocation.start()
          .then((bg.State state) {
            debugPrint('[start] success $state');
            enabled = state.enabled;
            isMoving = state.isMoving!;
            notifyListeners();
          })
          .catchError((error) {
            debugPrint('[start] ERROR: $error');
          });
    } else {
      bg.BackgroundGeolocation.stop().then((bg.State state) {
        debugPrint('[stop] success: $state');
        enabled = state.enabled;
        isMoving = state.isMoving!;
        notifyListeners();
      });
    }
  }
}
