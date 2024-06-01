import 'package:flutter/material.dart';
import 'package:graduation_project_admin/views/dashboard_view/class/chartDataDoughnut%20Chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChartWidget extends StatelessWidget {
  const DoughnutChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        child: SfCircularChart(
            annotations: [
              CircularChartAnnotation(
                  widget: Container(
                      child: Text(
                '70%',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ))),
            ],

            title: ChartTitle(text: 'Sales by sales person'),
            legend: Legend(
                isVisible: true,
                position: LegendPosition.left,
                toggleSeriesVisibility: true,

                legendItemBuilder: (
                  String name,
                  dynamic series,
                  dynamic point,
                  int index,
                ) {
                  final DoughnutSeries<ChartData, String> doughnutSeries =
                      series as DoughnutSeries<ChartData, String>;
                  final ChartData data = doughnutSeries.dataSource![index];
                  return Container(
                    height: 30,
                    width: 100,
                    child: Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color:
                                doughnutSeries.pointColorMapper!(data, index),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(name,style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  );
                },
                overflowMode: LegendItemOverflowMode.scroll),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                radius: '100%',
                  dataSource: <ChartData>[
                    ChartData('Gold', 70, Colors.yellow),
                    ChartData('Silver', 80, Colors.grey),
                    ChartData('Platinum', 90, Colors.blue),
                    ChartData('Diamond', 100, Colors.green),
                    ChartData('Ruby', 110, Colors.red),
                    ChartData('Pearl', 120, Colors.pink),
                    ChartData('Coral', 130, Colors.orange),
                    ChartData('Emerald', 140, Colors.teal),
                  ],
                  pointColorMapper: (ChartData data, _) => data.color,
                  dataLabelMapper: (ChartData data, _) => data.x,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  // Explode the segments on tap
                  explode: true,
                  explodeIndex: 1)
            ]));
  }
}
