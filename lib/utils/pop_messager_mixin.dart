import 'package:flutter_easyloading/flutter_easyloading.dart';

mixin PopMessagerMixin {
  showError(String message, {Duration? duration}) {
    EasyLoading.showError(
      message,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  showSuccess(String message, {Duration? duration}) {
    EasyLoading.showSuccess(
      message,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  showInfo(String message, {Duration? duration}) {
    EasyLoading.showInfo(
      message,
      duration: duration ?? const Duration(seconds: 3),
    );
  }
}
