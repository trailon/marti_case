import 'package:flutter/material.dart';
import 'package:marti_case/views/home_view/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ToggleShowPolyline extends StatelessWidget {
  const ToggleShowPolyline({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeViewModel, bool>(
      selector: (context, value) => context.read<HomeViewModel>().showPolyline,
      builder: (context, value, child) {
        return ShadSwitch(
          value: value,
          label: const Text('Rotayı Göster'),
          onChanged: context.read<HomeViewModel>().togglePolyline,
        );
      },
    );
  }
}
