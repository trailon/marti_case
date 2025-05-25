import 'package:device_preview/device_preview.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:marti_case/template_app.dart';
// ignore: depend_on_referenced_packages
import 'package:permission_manager/permission_manager.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'app/locator/locator.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PermissionManager();
  setupLocator();
  String? locale = await Devicelocale.currentLocale;
  await S.load(Locale(locale ?? "en"));
  Animate.restartOnHotReload = true;

  runApp(
    DevicePreview(
      enabled: false,
      tools: const [...DevicePreview.defaultTools],
      builder: (context) => const MartiCase(),
    ),
  );
}
