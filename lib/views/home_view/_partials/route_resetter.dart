import 'package:flutter/material.dart';
import 'package:marti_case/views/home_view/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class RouteResetter extends StatelessWidget {
  const RouteResetter({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadButton.destructive(
      onPressed: context.read<HomeViewModel>().resetRoute,
      child: Text("Rotayı Sıfırla"),
    );
  }
}
