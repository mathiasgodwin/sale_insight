// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:intl/intl.dart';

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
  final DateTime? shipDate;
  final String? category;
  final String? productId;
  final String? sales;
  final DateTime? orderDate;

  factory SalesDataModel.fromRawJson(String str) =>
      SalesDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesDataModel.fromJson(Map<String, dynamic> json) {
    var inputFormat = DateFormat('MM/dd/yyyy');
    return SalesDataModel(
      orderId: json["Order ID"],
      profit: json["Profit"],
      city: json["City"],
      customerName: json["Customer Name"],
      productName: json["Product Name"],
      rowId: json["Row ID"],
      country: json["Country"],
      discount: json["Discount"],
      customerId: json["Customer ID"],
      region: json["Region"],
      quantity: json["Quantity"],
      segment: json["Segment"],
      state: json["State"],
      shipMode: json["Ship Mode"],
      subCategory: json["Sub-Category"],
      postalCode: json["Postal Code"],
      shipDate: inputFormat.parse(json["Ship Date"]),
      category: json["Category"],
      productId: json["Product ID"],
      sales: json["Sales"],
      orderDate: inputFormat.parse(json["Order Date"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "Order ID": orderId,
        "Profit": profit,
        "City": city,
        "Customer Name": customerName,
        "Product Name": productName,
        "Row ID": rowId,
        "Country": country,
        "Discount": discount,
        "Customer ID": customerId,
        "Region": region,
        "Quantity": quantity,
        "Segment": segment,
        "State": state,
        "Ship Mode": shipMode,
        "Sub-Category": subCategory,
        "Postal Code": postalCode,
        "Ship Date": shipDate,
        "Category": category,
        "Product ID": productId,
        "Sales": sales,
        "Order Date": orderDate,
      };

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
