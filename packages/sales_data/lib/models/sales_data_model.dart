// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SalesDataModel extends Equatable {
  const SalesDataModel({
    this.orderId,
    this.profit,
    this.city,
    this.customerName,
    this.productName,
    this.rowId,
    this.country,
    this.discount,
    this.customerId,
    this.region,
    this.quantity,
    this.segment,
    this.state,
    this.shipMode,
    this.subCategory,
    this.postalCode,
    this.shipDate,
    this.category,
    this.productId,
    this.sales,
    this.orderDate,
  });

  final String? orderId;
  final String? profit;
  final String? city;
  final String? customerName;
  final String? productName;
  final String? rowId;
  final String? country;
  final String? discount;
  final String? customerId;
  final String? region;
  final String? quantity;
  final String? segment;
  final String? state;
  final String? shipMode;
  final String? subCategory;
  final String? postalCode;
  final String? shipDate;
  final String? category;
  final String? productId;
  final String? sales;
  final String? orderDate;

  SalesDataModel copyWith({
    String? orderId,
    String? profit,
    String? city,
    String? customerName,
    String? productName,
    String? rowId,
    String? country,
    String? discount,
    String? customerId,
    String? region,
    String? quantity,
    String? segment,
    String? state,
    String? shipMode,
    String? subCategory,
    String? postalCode,
    String? shipDate,
    String? category,
    String? productId,
    String? sales,
    String? orderDate,
  }) {
    return SalesDataModel(
      orderId: orderId ?? this.orderId,
      profit: profit ?? this.profit,
      city: city ?? this.city,
      customerName: customerName ?? this.customerName,
      productName: productName ?? this.productName,
      rowId: rowId ?? this.rowId,
      country: country ?? this.country,
      discount: discount ?? this.discount,
      customerId: customerId ?? this.customerId,
      region: region ?? this.region,
      quantity: quantity ?? this.quantity,
      segment: segment ?? this.segment,
      state: state ?? this.state,
      shipMode: shipMode ?? this.shipMode,
      subCategory: subCategory ?? this.subCategory,
      postalCode: postalCode ?? this.postalCode,
      shipDate: shipDate ?? this.shipDate,
      category: category ?? this.category,
      productId: productId ?? this.productId,
      sales: sales ?? this.sales,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'profit': profit,
      'city': city,
      'customerName': customerName,
      'productName': productName,
      'rowId': rowId,
      'country': country,
      'discount': discount,
      'customerId': customerId,
      'region': region,
      'quantity': quantity,
      'segment': segment,
      'state': state,
      'shipMode': shipMode,
      'subCategory': subCategory,
      'postalCode': postalCode,
      'shipDate': shipDate,
      'category': category,
      'productId': productId,
      'sales': sales,
      'orderDate': orderDate,
    };
  }

  factory SalesDataModel.fromMap(Map<String, dynamic> map) {
    return SalesDataModel(
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      profit: map['profit'] != null ? map['profit'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      customerName:
          map['customerName'] != null ? map['customerName'] as String : null,
      productName:
          map['productName'] != null ? map['productName'] as String : null,
      rowId: map['rowId'] != null ? map['rowId'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      discount: map['discount'] != null ? map['discount'] as String : null,
      customerId:
          map['customerId'] != null ? map['customerId'] as String : null,
      region: map['region'] != null ? map['region'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as String : null,
      segment: map['segment'] != null ? map['segment'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      shipMode: map['shipMode'] != null ? map['shipMode'] as String : null,
      subCategory:
          map['subCategory'] != null ? map['subCategory'] as String : null,
      postalCode:
          map['postalCode'] != null ? map['postalCode'] as String : null,
      shipDate: map['shipDate'] != null ? map['shipDate'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      productId: map['productId'] != null ? map['productId'] as String : null,
      sales: map['sales'] != null ? map['sales'] as String : null,
      orderDate: map['orderDate'] != null ? map['orderDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesDataModel.fromJson(String source) =>
      SalesDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      orderId,
      profit,
      city,
      customerName,
      productName,
      rowId,
      country,
      discount,
      customerId,
      region,
      quantity,
      segment,
      state,
      shipMode,
      subCategory,
      postalCode,
      shipDate,
      category,
      productId,
      sales,
      orderDate,
    ];
  }
}
