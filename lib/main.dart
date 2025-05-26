import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:marti_case/marti_app.dart';
import 'package:permission_manager/permission_manager.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'app/locator/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PermissionManager();
  setupLocator();
  Animate.restartOnHotReload = true;

  runApp(
    DevicePreview(
      enabled: false,
      tools: const [...DevicePreview.defaultTools],
      builder: (context) => const MartiCase(),
    ),
  );
}
