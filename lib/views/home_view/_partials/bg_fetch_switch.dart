import 'package:flutter/material.dart';
import 'package:marti_case/views/home_view/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BgFetchSwitch extends StatelessWidget {
  const BgFetchSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeViewModel, bool>(
      selector: (context, viewModel) => viewModel.enabled,
      builder: (context, enabled, child) {
        return ShadSwitch(
          label: Text('Konum Takibi ${enabled ? 'Aktif' : 'Kapalı'}'),
          value: enabled,
          onChanged: context.read<HomeViewModel>().startStopBackgroundFetch,
        );
      },
    );
  }
}
