import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// PieChartPage to...
class PieChartPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'PieChart';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => PieChartPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is PieChartPage'),
      ),
    );
  }
}
