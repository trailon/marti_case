import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
          appBar: AppBar(
            title: const Text('Home View'),
          ),
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
        const Spacer(
          flex: 8,
        ),
        Center(
          child: ElevatedButton(
            onPressed: context.read<HomeViewModel>().pushToDetailView,
            child: const Text('Go to Detail View'),
          ),
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
