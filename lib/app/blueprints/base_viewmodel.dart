import 'package:auto_route/auto_route.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:permission_manager/permission_manager.dart';

import '../../services/scaffold_messenger_services.dart';
import '../app_config.dart';
import '../locator/locator.dart';
import 'api_response.dart';

abstract class BaseViewModel extends ChangeNotifier {

  //Scaffold Messenger instance
  @protected
  final messengerService = locator<ScaffoldMessengerService>();

  //Permission Manager instance
  @protected
  final permissionManager = PermissionManager();

  //Context getter
  BuildContext get context => AppConfig.appRouter.navigatorKey.currentContext!;

  final appRouter = AppConfig.appRouter;

  RouteData get currentRoute => appRouter.current;

  /// This can be used as a init loading status
  /// Upon showing the view the loading indicator is shown until the api request is complete
  /// After that this can be set to true and the content is shown
  @protected
  bool _viewDidLoad = false;

  bool get viewDidLoad => _viewDidLoad;

  /// This can be used to set the viewLoading status
  @protected
  void setViewDidLoad(bool value) {
    if (value != _viewDidLoad) {
      _viewDidLoad = value;
      notifyListeners();
    }
  }

  @protected
  bool _loading = false;

  bool get loading => _loading;

  //This can be used to set the loading status
  @protected
  void setLoading(bool value) {
    if (value != _loading) {
      _loading = value;
      notifyListeners();
    }
  }

  @protected
  ResponseStatus _responseStatus = ResponseStatus();

  ResponseStatus get responseStatus => _responseStatus;

  //This can be used to set the Response Status
  @protected
  void setResponseStatus(
    ResponseStatus value, {
    required Function? latestRequest,
  }) async {
    if (value != _responseStatus) {
      _responseStatus = value;
      notifyListeners();
    }
  }

  /// This can be used to fetch ApiResponseModel
  @protected
  Future<void> getData();

  /// This can be used to dispose
  @protected
  void disposeModel();

  /// This can be used to test the view/viewmodel scenarios
  @protected
  Future<void> testScenario();
}
