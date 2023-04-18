import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// BarChatPage to...
class BarChatPage extends StatelessWidget {

/// Static named route for page
static const String route = 'BarChat';

/// Static method to return the widget as a PageRoute
static Route go() => MaterialPageRoute<void>(builder: (_) => BarChatPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is BarChatPage'),
     ),
   );
  }
}