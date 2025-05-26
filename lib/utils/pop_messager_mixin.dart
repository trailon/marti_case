import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marti_case/app/app_config.dart';

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

  askForGPXorKMLfile() async =>
      await showDialog<bool>(
        // ignore: use_build_context_synchronously
        context: AppConfig.context,
        builder: (context) => AlertDialog(
          title: Text(
            "Bir GPX/KML dosyası mı kullanıyorsunuz? (Sadece Android Emülatörü için)",
            style: Theme.of(
              context,
            ).textTheme.displayMedium!.copyWith(fontSize: 14),
          ),
          content: Text(
            "Eğer bir GPX/KML dosyası kullanıyorsanız lütfen “Evet” seçeneğini işaretleyin. Android Emülatörü bu dosyalarla rota simülasyonu yapabilir ancak cihaz konumunu otomatik olarak güncelleyemez. Sadece emülatörde, cihazın konumunun güncellenmesi için konum paketini “hareket halinde” durumuna zorlamaktayız.",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontSize: 12),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Hayır'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Evet'),
            ),
          ],
        ),
      ) ??
      false;
}
