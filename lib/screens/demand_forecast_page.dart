import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DemandForecastPage extends StatelessWidget {
  final List<FlSpot> actualSales = [
    FlSpot(1, 150),
    FlSpot(2, 170),
    FlSpot(3, 160),
    FlSpot(4, 190),
    FlSpot(5, 220),
  ];

  final List<FlSpot> predictedSales = [
    FlSpot(1, 145),
    FlSpot(2, 180),
    FlSpot(3, 175),
    FlSpot(4, 200),
    FlSpot(5, 210),
  ];

  DemandForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demand Forecasting')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(show: true),
            lineBarsData: [
              LineChartBarData(spots: actualSales, isCurved: true, color: Colors.red, barWidth: 3),
              LineChartBarData(spots: predictedSales, isCurved: true, color: Colors.blue, barWidth: 3),
            ],
          ),
        ),
      ),
    );
  }
}
