import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:marti_case/views/home_view/_partials/bg_fetch_switch.dart';
import 'package:marti_case/views/home_view/_partials/flutter_map_widget.dart';
import 'package:marti_case/views/home_view/_partials/meters_in_second.dart';
import 'package:marti_case/views/home_view/_partials/route_resetter.dart';
import 'package:provider/provider.dart';

import '../../app/blueprints/base_page_view.dart';
import 'home_viewmodel.dart';

@RoutePage(name: 'homeViewRoute')
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      builder: (context, _) {
        return BasePageView<HomeViewModel>(
          appBar: AppBar(title: const Text('Map View')),
          content: const _ViewContent(),
        );
      },
    );
  }
}

class _ViewContent extends StatelessWidget {
  const _ViewContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutterMapWidget(
          initialLocation: context.read<HomeViewModel>().currentLocation!,
        ),
        Center(child: const BgFetchSwitch()),
        const RouteResetter(),
        const MetersInSecond(),
        const Spacer(flex: 1),
      ],
    );
  }
}
