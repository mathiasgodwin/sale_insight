import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sale_insight/src/feature/sale_insight/logic/get_data/get_data_cubit.dart';
import 'package:sales_data/models/sales_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// TODO: Finish the docs
/// PieChartPage to...
class PieChartPage extends StatefulWidget {
  /// Static named route for page
  static const String route = 'PieChart';

  /// Static method to return the widget as a PageRoute
  static Route go() => MaterialPageRoute<void>(builder: (_) => PieChartPage());

  @override
  State<PieChartPage> createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  late TooltipBehavior _tooltipBehavior;
  late List<SalesDataModel> dataPoint;
  List<SalesDataModel> newDataPointList = [];
  num totalValue = 0;
  CircularSeriesController? _chartSeriesController;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    dataPoint = context.read<GetDataCubit>().state.data;
    newDataPointList.addAll(dataPoint.take(300));

    for (var element in newDataPointList) {
      totalValue += double.parse(element.quantity!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceData = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SfCircularChart(
        legend: Legend(
          overflowMode: LegendItemOverflowMode.wrap,
          isVisible: true,
          legendItemBuilder: (String legendText, dynamic series, dynamic point,
              int seriesIndex) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: series.renderPoints[point.index].color,
                      ),
                      margin: const EdgeInsets.only(right: 8.0),
                    ),
                    Text(
                      '$legendText ${(point.y / (totalValue / 100)).round()}%',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        enableMultiSelection: true,
        onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
          final Offset value = Offset(args.position.dx, args.position.dy);

          _chartSeriesController!.pixelToPoint(value);
        },
        // Initialize category axis
        // Chart title
        title: ChartTitle(text: 'Yearly sales analysis'),
        // Enable legend
        // Enable tooltip
        tooltipBehavior: _tooltipBehavior,

        series: _getAddRemovePointSeries(),
      ),
    );
  }

  /// Returns the list of chart series which need to render
  /// on the update data source chart.
  List<PieSeries<SalesDataModel, String>> _getAddRemovePointSeries() {
    return <PieSeries<SalesDataModel, String>>[
      PieSeries<SalesDataModel, String>(
        dataLabelMapper: (SalesDataModel data, _) => data.category,

        sortingOrder: SortingOrder.descending,
        legendIconType: LegendIconType.circle,
        // dataLabelSettings: DataLabelSettings(
        //   isVisible: true,
        //   // builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
        //   //     int seriesIndex) {
        //   //   return Text(
        //   //     data.category +
        //   //         ' ${(data.quantity / (totalValue / 100)).round()}' +
        //   //         '%',
        //   //     style: const TextStyle(fontSize: 10),
        //   //   );
        //   // },
        //   connectorLineSettings:
        //       const ConnectorLineSettings(type: ConnectorType.curve),
        //   overflowMode: OverflowMode.shift,
        //   showZeroValue: false,
        //   labelPosition: ChartDataLabelPosition.outside,
        // ),
        radius: '90%',
        onRendererCreated: (CircularSeriesController controller) {
          _chartSeriesController = controller;
        },
        animationDuration: 500,
        explode: true,
        // All the segments will be exploded
        explodeAll: true,
        // Bind data source

        name: "Product Sales",
        // Bind data source

        dataSource: newDataPointList,
        xValueMapper: (SalesDataModel sales, _) => sales.productName,

        yValueMapper: (SalesDataModel sales, _) => double.parse(sales.sales!),
      ),
    ];
  }
}
