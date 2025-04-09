import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/demand_forecast_page.dart';
import 'screens/inventory_page.dart';
import 'screens/routes_page.dart';

void main() => runApp(SupplyChainApp());

class SupplyChainApp extends StatelessWidget {
  const SupplyChainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supply Chain Optimization',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/demand': (_) => DemandForecastPage(),
        '/inventory': (_) => InventoryPage(),
        '/routes': (_) => RoutesPage(),
      },
    );
  }
}
