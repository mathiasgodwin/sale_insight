// ignore_for_file: empty_catches

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sale_insight/src/feature/sale_insight/logic/get_data/get_data_cubit.dart';
import 'package:sales_data/sales_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// TODO: Finish the docs
/// BarChatPage to...
class BarChatPage extends StatefulWidget {
  /// Static named route for page
  static const String route = 'BarChat';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => BarChatPage());

  @override
  State<BarChatPage> createState() => _BarChatPageState();
}

class _BarChatPageState extends State<BarChatPage> {
  late TooltipBehavior _tooltipBehavior;
  late List<SalesDataModel> dataPoint;
  List<SalesDataModel> newDataPointList = [];
  ChartSeriesController? _chartSeriesController;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    dataPoint = context.read<GetDataCubit>().state.data;
    newDataPointList.addAll(dataPoint.take(50));
    _zoomPanBehavior = ZoomPanBehavior(
        // Enables pinch zooming
        zoomMode: ZoomMode.xy,
        enablePinching: true,
        enableDoubleTapZooming: true,
        enableSelectionZooming: true,
        selectionRectBorderColor: Colors.red,
        selectionRectBorderWidth: 1,
        selectionRectColor: Colors.grey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SfCartesianChart(
        zoomPanBehavior: _zoomPanBehavior,
        loadMoreIndicatorBuilder:
            (BuildContext context, ChartSwipeDirection direction) =>
                getLoadMoreViewBuilder(context, direction),

        enableAxisAnimation: true,

        onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
          final Offset value = Offset(args.position.dx, args.position.dy);
          CartesianChartPoint<dynamic> chartpoint =
              _chartSeriesController!.pixelToPoint(value);
        },
        onPlotAreaSwipe: performSwipe,
        // Initialize category axis
        // Chart title
        title: ChartTitle(text: 'Yearly sales analysis'),
        // Enable legend
        legend: Legend(isVisible: true),
        // Enable tooltip
        tooltipBehavior: _tooltipBehavior,

        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
            // Intervals will be fixed, not calculated automatically based on the visible range on zooming and panning
            ),

        series: _getAddRemovePointSeries(),
      ),
    );
  }

  /// Returns the list of chart series which need to render
  /// on the update data source chart.
  List<ColumnSeries<SalesDataModel, String>> _getAddRemovePointSeries() {
    return <ColumnSeries<SalesDataModel, String>>[
      ColumnSeries<SalesDataModel, String>(
        onRendererCreated: (ChartSeriesController controller) {
          _chartSeriesController = controller;
        },
        animationDuration: 0,
        name: "Product Profit",
        // Bind data source
        dataSource: newDataPointList
          ..sort((a, b) => a.orderDate!.compareTo(b.orderDate!)),
        xValueMapper: (SalesDataModel sales, _) =>
            DateFormat.yMEd().format(sales.orderDate!),

        yValueMapper: (SalesDataModel sales, _) => double.parse(sales.profit!),
      ),
      ColumnSeries<SalesDataModel, String>(
        onRendererCreated: (ChartSeriesController controller) {
          _chartSeriesController = controller;
        },
        animationDuration: 0,
        name: "Product Sales",
        // Bind data source
        dataSource: newDataPointList
          ..sort((a, b) => a.orderDate!.compareTo(b.orderDate!)),
        xValueMapper: (SalesDataModel sales, _) =>
            DateFormat.yMEd().format(sales.orderDate!),

        yValueMapper: (SalesDataModel sales, _) => double.parse(sales.sales!),
      ),
    ];
  }

  List<SalesDataModel> _addChartData() {
    const add = 1;
    try {
      newDataPointList.addAll(dataPoint.take(newDataPointList.length + add));
    } catch (e) {}
    return newDataPointList;
  }

  Widget getLoadMoreViewBuilder(
      BuildContext context, ChartSwipeDirection direction) {
    if (direction == ChartSwipeDirection.end) {
      return FutureBuilder<List<SalesDataModel>>(
        future: Future.value(_addChartData()),

        /// Adding data by updateDataSource method
        builder: (BuildContext futureContext,
            AsyncSnapshot<List<SalesDataModel>> snapShot) {
          return snapShot.connectionState != ConnectionState.done
              ? const CircularProgressIndicator()
              : SizedBox.fromSize(size: Size.zero);
        },
      );
    } else {
      return SizedBox.fromSize(size: Size.zero);
    }
  }

  void performSwipe(ChartSwipeDirection direction) {
    if (direction == ChartSwipeDirection.end) {
      _addChartData();
      setState(() {});
      _chartSeriesController!
          .updateDataSource(addedDataIndex: newDataPointList.length + 1);
    }
  }
}
