import 'package:amazon_app/common/widgets/loader.dart';

import 'package:amazon_app/features/admin/sales.dart';
import 'package:amazon_app/features/admin/services/admin_services.dart';
import 'package:amazon_app/features/admin/widgets/category_products_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final adminservices admin = adminservices();
  int? totalsales;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
    getearning();
  }

  getearning() async {
    var earningdata = await admin.getearnings(context);
    totalsales = earningdata['totalearning'];
    earnings = earningdata['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalsales == null
        ? loader()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total Earnings:\$${totalsales}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 95),
                padding: EdgeInsets.all(0),
                child: SizedBox(
                  height: 280,
                  child: CategoryProductChart(data: earnings!),
                ),
              )
            ],
          );
  }
}
