import 'package:flutter/material.dart';
import 'package:marti_case/views/home_view/home_viewmodel.dart';
import 'package:provider/provider.dart';

class MetersInSecond extends StatelessWidget {
  const MetersInSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeViewModel, String>(
      selector: (context, value) => value.metersInSecond,
      builder: (context, value, child) {
        return Text(value);
      },
    );
  }
}
