import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// TimeSeriesPage to...
class TimeSeriesPage extends StatelessWidget {

/// Static named route for page
static const String route = 'TimeSeries';

/// Static method to return the widget as a PageRoute
static Route go() => MaterialPageRoute<void>(builder: (_) => TimeSeriesPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is TimeSeriesPage'),
     ),
   );
  }
}