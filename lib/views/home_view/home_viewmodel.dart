import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../app/blueprints/base_viewmodel.dart';
import '../../app/router/router.dart';

class HomeViewModel extends BaseViewModel {
  @override
  void disposeModel() {}

  @override
  Future<void> testScenario() async {}

  @override
  Future<void> getData() async {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setViewDidLoad(true);
      EasyLoading.showSuccess('It is homeview!');
    });
  }

  Future<void> pushToDetailView() async {
    await appRouter.push(const DetailViewRoute());
    debugPrint('Returned from Detail View');
  }

  Future<void> checkLocationPermission() async {
    await permissionManager.requestLocation();
  }
}
