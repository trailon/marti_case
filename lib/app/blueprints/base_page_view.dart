import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../widgets/basic_error_widget.dart';
import '../../widgets/box_container.dart';
import '../../widgets/circle_card_widget.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/custom_transition_switcher.dart';
import 'api_response.dart';
import 'base_viewmodel.dart';

class BasePageView<T extends BaseViewModel> extends StatelessWidget {
  final Widget? floatingActionButton;
  final AppBar? appBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? content;
  final bool haveScaffold;
  final bool showCircleCard;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool fabRequiresStatus;
  final bool endDrawerEnableOpenDragGesture;
  final bool shouldWaitForGetData;

  const BasePageView({
    super.key,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
    this.endDrawer,
    this.content,
    this.haveScaffold = true,
    this.showCircleCard = true,
    this.scaffoldKey,
    this.fabRequiresStatus = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.shouldWaitForGetData = true,
  });

  @override
  Widget build(BuildContext context) {
    final responseStatus =
        context.select<T, ResponseStatus>((value) => value.responseStatus);

    return haveScaffold
        ? Scaffold(
            key: scaffoldKey,
            floatingActionButton: !fabRequiresStatus
                ? floatingActionButton
                : responseStatus.status != null && responseStatus.status!
                    ? floatingActionButton
                    : null,
            appBar: appBar,
            drawer: drawer,
            endDrawer: endDrawer,
            endDrawerEnableOpenDragGesture: fabRequiresStatus
                ? (responseStatus.status ?? false) &&
                    endDrawerEnableOpenDragGesture
                : endDrawerEnableOpenDragGesture,
            body: _PageLoadingWidget<T>(
              content: content,
              showCircleCard: showCircleCard,
            ),
          )
        : _PageLoadingWidget<T>(
            content: content,
            showCircleCard: showCircleCard,
            shouldWaitForGetData: shouldWaitForGetData,
          );
  }
}

class _PageLoadingWidget<T extends BaseViewModel> extends StatefulWidget {
  final Widget? content;
  final bool? showCircleCard;
  final bool shouldWaitForGetData;
  const _PageLoadingWidget(
      {super.key,
      required this.content,
      this.showCircleCard,
      this.shouldWaitForGetData = true});

  @override
  __PageLoadingWidgetState<T> createState() => __PageLoadingWidgetState<T>();
}

class __PageLoadingWidgetState<T extends BaseViewModel>
    extends State<_PageLoadingWidget> {
  late T _provider;

  @override
  void initState() {
    super.initState();
    _provider = context.read<T>();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // ignore: invalid_use_of_protected_member
      _provider.getData().then((value) => _provider.testScenario());
    });
  }

  @override
  void dispose() {
    // ignore: invalid_use_of_protected_member
    _provider.disposeModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewDidLoad = context.select<T, bool>((value) => value.viewDidLoad);

    return widget.shouldWaitForGetData
        ? CustomTransitionSwitcher(
            child: !viewDidLoad
                ? const BoxContainer(child: CustomCircularProgressIndicator())
                : _provider.responseStatus.status == null ||
                        _provider.responseStatus.status!
                    ? _CircleLoadingWidget<T>(
                        content: widget.content,
                        showCircleCard: widget.showCircleCard,
                      )
                    : BasicErrorWidget(
                        error: _provider.responseStatus.errorMessage),
          )
        : _CircleLoadingWidget<T>(
            content: widget.content,
            showCircleCard: widget.showCircleCard,
          );
  }
}

class _CircleLoadingWidget<T extends BaseViewModel> extends StatelessWidget {
  final Widget? content;
  final bool? showCircleCard;
  const _CircleLoadingWidget(
      {super.key, required this.content, this.showCircleCard});

  @override
  Widget build(BuildContext context) {
    if (!showCircleCard!) {
      return content!;
    }

    return Selector<T, bool>(
      selector: (_, model) => model.loading,
      builder: (context, value, child) {
        return CircleCardWidget(
          showCard: value,
          child: child,
        );
      },
      child: content,
    );
  }
}
