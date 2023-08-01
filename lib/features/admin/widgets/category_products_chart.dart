import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:amazon_app/features/admin/sales.dart';

class CategoryProductChart extends StatefulWidget {
  final List<Sales> data;

  const CategoryProductChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CategoryProductChart> createState() => _CategoryProductChartState();
}

class _CategoryProductChartState extends State<CategoryProductChart> {
  List<BarChartGroupData> getData() {
    List<BarChartGroupData> data = [];

    for (int i = 0; i < widget.data.length; i++) {
      final value = double.parse(widget.data[i].earning.toString());

      // If the label represents a category or a non-numeric value
      String label = widget.data[i].label;

      // You can also use index as a label if you prefer
      String labels = i.toString();

      final groupData = BarChartGroupData(
        x: int.parse(labels),
        barRods: [
          BarChartRodData(
            toY: value,
            color: Colors.blue, // Customize the color of the bars
            width: 40, // Customize the width of the bars
            borderRadius: BorderRadius.circular(
                0), // Customize the border radius of the bars
          ),
        ],
      );

      data.add(groupData);
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      charts.BarChartData(
        alignment: charts.BarChartAlignment.spaceAround,
        barGroups: getData(),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: charts.SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                String text = '';
                switch (value.toInt()) {
                  case 0:
                    text = widget.data[0].label;
                    break;

                  case 1:
                    text = widget.data[1].label;

                  case 2:
                    text = widget.data[2].label;
                    break;
                  case 3:
                    text = widget.data[3].label;
                    break;
                  case 4:
                    text = widget.data[4].label;
                    break;
                }
                return Text(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ),
      ),
      swapAnimationDuration: Duration(milliseconds: 150),
      swapAnimationCurve: Curves.linear,
    );
  }
}
