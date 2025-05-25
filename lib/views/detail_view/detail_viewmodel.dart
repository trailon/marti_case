import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../app/blueprints/base_viewmodel.dart';

class DetailViewModel extends BaseViewModel {

  @override
  void disposeModel() {}

  @override
  Future<void> testScenario() async {}

  @override
  Future<void> getData() async {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setViewDidLoad(true);
      EasyLoading.showSuccess('It is Detail View!');
    });
  }

  void detailViewTrigger() async {
    
  }
}
