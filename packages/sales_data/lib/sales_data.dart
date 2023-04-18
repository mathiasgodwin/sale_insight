library sales_data;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sales_data/models/sales_data_model.dart';
import 'package:dio_network_exceptions/dio_network_exceptions.dart';

export 'package:sales_data/models/sales_data_model.dart';

abstract class SalesData {
  Future<List<SalesDataModel>> getSalesData();
}

class SalesDataImpl implements SalesData {
  SalesDataImpl({
    required Dio client,
  }) : _client = client;

  final Dio _client;
  @override
  Future<List<SalesDataModel>> getSalesData() async {
    try {
      final response = await _client.post(
        'https://g54qw205uk.execute-api.eu-west-1.amazonaws.com/DEV/stub',
        data: {"angular_test": "angular-developer"},
      );
      return (response.data as List<dynamic>)
          .map(
            (e) => SalesDataModel.fromMap(e),
          )
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      throw NetworkException.fromError(e);
    }
  }
}
