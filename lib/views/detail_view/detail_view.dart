import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/blueprints/base_page_view.dart';
import 'detail_viewmodel.dart';

@RoutePage(name: 'detailViewRoute')
class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailViewModel(),
      builder: (context, _) {
        return BasePageView<DetailViewModel>(
          appBar: AppBar(
            title: const Text('Detail View'),
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
        if (context.watch<DetailViewModel>().yesOrNoModel != null) ...[
          Image.network(context.watch<DetailViewModel>().yesOrNoModel!.image!),
          const Spacer(
            flex: 8,
          ),
        ],
        Center(
          child: ElevatedButton(
            onPressed: context.read<DetailViewModel>().detailViewTrigger,
            child: const Text('Press Me!'),
          ),
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
