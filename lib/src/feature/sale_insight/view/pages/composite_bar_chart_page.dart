import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// CompositeChartPage to...
class CompositeChartPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'CompositeChart';

  /// Static method to return the widget as a PageRoute
  static Route go() =>
      MaterialPageRoute<void>(builder: (_) => CompositeChartPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is CompositeChartPage'),
      ),
    );
  }
}
