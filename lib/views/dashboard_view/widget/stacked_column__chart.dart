import 'package:flutter/material.dart';
import 'package:graduation_project_admin/views/dashboard_view/widget/doughnut_chart_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../class/ChartDataColumn.dart';

class Stacked_column_Chart extends StatelessWidget {
  const Stacked_column_Chart({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final List<ChartDataColumn> chartData = [
      ChartDataColumn(
        'january',
        14,

      ),
      ChartDataColumn(
        'February',
        16,

      ),
      ChartDataColumn(
        'March',
        18,

      ),
      ChartDataColumn(
        'April',
        20,

      ),
      ChartDataColumn(
        'May',
        22,

      ),
      ChartDataColumn(
        'June',
        24,

      ),
      ChartDataColumn(
        'July',
        26,

      ),
      ChartDataColumn(
        'August',
        28,

      ),
      ChartDataColumn(
        'September',
        30,

      ),
      ChartDataColumn(
        'Others',
        29,

      ),
    ];

    return Container(
        width: 800,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              interactiveTooltip: InteractiveTooltip(enable: true),
              autoScrollingDelta: 10,
              autoScrollingMode: AutoScrollingMode.start,
            ),
            selectionType: SelectionType.point,
            title: ChartTitle(text: 'Users'),
            tooltipBehavior: TooltipBehavior(enable: true),
            crosshairBehavior: CrosshairBehavior(
              enable: true,
            ),
            trackballBehavior: TrackballBehavior(
              activationMode: ActivationMode.doubleTap,
              enable: true,

              // builder: (BuildContext context, TrackballDetails trackballDetails) {
              //   return Container(
              //     height: 50,
              //     width: 100,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(10),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.5),
              //           spreadRadius: 5,
              //           blurRadius: 7,
              //           offset: Offset(0, 3),
              //         ),
              //       ],
              //     ),
              //     child: Column(
              //       children: [
              //         Text(
              //           trackballDetails.series!.seriesRenderer!
              //               .dataPoints[trackballDetails.pointIndex!].seriesName,
              //           style: TextStyle(fontSize: 20),
              //         ),
              //         Text(
              //           trackballDetails.series!.seriesRenderer!
              //               .dataPoints[trackballDetails.seriesIndex!].yValue.toString(),
              //           style: TextStyle(fontSize: 20),
              //         ),
              //       ],
              //     ),
              //   );
              // },

              tooltipSettings: InteractiveTooltip(
                color: Colors.transparent,
                enable: true,
                format: 'point.x : point.y',
                borderWidth: 0,
                borderColor: Colors.transparent,
                textStyle: TextStyle(color: Colors.transparent),
                decimalPlaces: 5,
              ),
            ),
            enableSideBySideSeriesPlacement: true,
            series: <CartesianSeries>[
              StackedColumnSeries<ChartDataColumn, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartDataColumn data, _) => data.x,
                  width: 0.2,
                  spacing: 0.5,
                  borderRadius: BorderRadius.circular(10),
                  dataLabelMapper: (ChartDataColumn data, _) =>
                      data.y1.toString(),
                  color: Color(0xFF0062FF),
                  yValueMapper: (ChartDataColumn data, _) => data.y1),
              // StackedColumnSeries<ChartDataColumn, String>(
              //     dataSource: chartData,
              //     xValueMapper: (ChartDataColumn data, _) => data.x,
              //     width: 0.2,
              //     spacing: 0.5,
              //     borderRadius: BorderRadius.circular(10),
              //     dataLabelMapper: (ChartDataColumn data, _) =>
              //         data.y2.toString(),
              //     color: Color(0xFF57B8FF),
              //     yValueMapper: (ChartDataColumn data, _) => data.y2),
            ]));
  }
}
