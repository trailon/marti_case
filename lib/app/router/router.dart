import 'package:auto_route/auto_route.dart';
import 'package:marti_case/views/detail_view/detail_view.dart';
import 'package:marti_case/views/home_view/home_view.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        MaterialRoute(page: HomeViewRoute.page, initial: true),
        MaterialRoute(page: DetailViewRoute.page),
      ];
}
