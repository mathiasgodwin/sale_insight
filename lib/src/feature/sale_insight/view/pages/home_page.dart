import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sale_insight/src/config/ui_extensions/ui_extensions.dart';
import 'package:sale_insight/src/feature/sale_insight/logic/get_data/get_data_cubit.dart';
import 'package:sale_insight/src/feature/sale_insight/view/pages/pages.dart';

/// TODO: Finish the docs
/// HomePage to...
class HomePage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'Home';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => HomePage());

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetDataCubit, GetDataState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status == GetDataStatus.loading) {
          context.showLoading();
        } else if (state.status == GetDataStatus.failure) {
          FlutterNativeSplash.remove();
          Navigator.of(context).maybePop();
          await context.showErrorRetry(
            state.errorMessage ?? 'An error occurred',
            onRetry: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              context.read<GetDataCubit>().getData();
            },
          );
        } else if (state.status == GetDataStatus.success) {
          FlutterNativeSplash.remove();
          Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
        body: Stack(
          children: const [
            _HomeBackground(),
            Align(
              alignment: Alignment.bottomCenter,
              child: _HomePageDialog(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeBackground extends StatelessWidget {
  const _HomeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return const _GradientBg();
      },
    );
  }
}

class _GradientBg extends StatelessWidget {
  const _GradientBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: RadialGradient(
        colors: [
          Color(0xff16D2E7),
          Color(0x0fff3d00),
        ],
      )),
    );
  }
}

class _HomePageDialog extends StatelessWidget {
  const _HomePageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceData = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            24,
          ),
        ),
        elevation: 4,
        child: Container(
          width: deviceData.width * .95,
          height: deviceData.height * .6,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                24,
              ),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  height: 20,
                ),
                _HomePageHeading(),
                _ChartPagesList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomePageHeading extends StatelessWidget {
  const _HomePageHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sales Insight',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            'Welcome.',
            style: theme.textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}

class _ChartPagesList extends StatelessWidget {
  const _ChartPagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceData = MediaQuery.of(context).size;
    int crossAxisCount = 3;
    if (deviceData.width < 600) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 4;
    }
    return GridView(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1,
      ),
      children: [
        _ChartPageWidget(
          onPressed: () {
            Navigator.of(context).push(TimeSeriesPage.go());
          },
          header: const Icon(
            Icons.view_timeline_rounded,
          ),
          name: 'Time Series',
        ),
        _ChartPageWidget(
          onPressed: () {
            Navigator.of(context).push(PieChartPage.go());
          },
          header: const Icon(
            Icons.pie_chart_outline_rounded,
          ),
          name: 'Pie Chart',
        ),
        _ChartPageWidget(
          onPressed: () {
            Navigator.of(context).push(CompositeChartPage.go());
          },
          header: const Icon(
            Icons.stacked_bar_chart_rounded,
          ),
          name: 'Composite Chart',
        ),
        _ChartPageWidget(
          onPressed: () {
            Navigator.of(context).push(BarChatPage.go());
          },
          header: const Icon(
            Icons.bar_chart_rounded,
          ),
          name: 'Bar Chat',
        ),
      ],
    );
  }
}

class _ChartPageWidget extends StatelessWidget {
  const _ChartPageWidget({
    Key? key,
    required this.header,
    required this.name,
    required this.onPressed,
  }) : super(key: key);
  final Widget header;
  final String name;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              child: header,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
