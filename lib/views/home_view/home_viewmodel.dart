import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

import '../../app/blueprints/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  String odometerKm = '0';
  bool isMoving = false;
  bool enabled = false;

  @override
  void disposeModel() {}

  @override
  Future<void> testScenario() async {}

  @override
  Future<void> getData() async {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setViewDidLoad(true);
    });
    await super.permissionManager.requestLocation();
  }

  void _onLocation(bg.Location location) {
    debugPrint('[location] - $location');
    odometerKm = (location.odometer / 1000.0).toStringAsFixed(1);
  }

  void _onLocationError(bg.LocationError error) {
    debugPrint('[location] ERROR - $error');
  }

  void _onMotionChange(bg.Location location) {
    debugPrint('[motionchange] - $location');
  }

  void _onProviderChange(bg.ProviderChangeEvent event) {
    debugPrint('$event');
  }

  initBgConfiguration() {
    bg.BackgroundGeolocation.onLocation(_onLocation, _onLocationError);
    bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
    bg.BackgroundGeolocation.onProviderChange(_onProviderChange);

    // 2.  Configure the plugin
    bg.BackgroundGeolocation.ready(
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
          debugPrint("[ready] ${state.toMap()}");
          enabled = state.enabled;
          isMoving = state.isMoving!;
        })
        .catchError((error) {
          debugPrint('[ready] ERROR: $error');
        });
  }

  startStopBackgroundFetch(bool enable) {
    if (enable) {
      // Reset odometer.
      bg.BackgroundGeolocation.start()
          .then((bg.State state) {
            debugPrint('[start] success $state');
            enabled = state.enabled;
            isMoving = state.isMoving!;
          })
          .catchError((error) {
            debugPrint('[start] ERROR: $error');
          });
    } else {
      bg.BackgroundGeolocation.stop().then((bg.State state) {
        debugPrint('[stop] success: $state');
        enabled = state.enabled;
        isMoving = state.isMoving!;
      });
    }

    notifyListeners();
  }
}
