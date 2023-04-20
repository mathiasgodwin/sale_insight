import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sale_insight/src/config/color_schemes.g.dart';
import 'package:sale_insight/src/feature/sale_insight/logic/get_data/get_data_cubit.dart';
import 'package:sale_insight/src/feature/sale_insight/view/pages/home_page.dart';
import 'package:sales_data/sales_data.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        /// This transformer runs the json deserialization in an isolate
        /// to prevent UI janks due to huge JSON response from server.
        final client = Dio();
        (client.transformer as DefaultTransformer).jsonDecodeCallback =
            parseJson;
        return SalesDataImpl(
          client: client,
        );
      },
      child: const _AppBloc(),
    );
  }
}

class _AppBloc extends StatelessWidget {
  const _AppBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => GetDataCubit(
        /// Dependency injection [DI]
        context.read<SalesDataImpl>(),
      )..getData(),
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: HomePage(),
    );
  }
}
