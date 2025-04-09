import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> cards = [
    {'title': 'Forecast Accuracy', 'value': '94%'},
    {'title': 'Deliveries Today', 'value': '68'},
    {'title': 'Low Stock Items', 'value': '5'},
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Supply Chain Dashboard')),
      body: Column(
        children: [
          SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: cards.map((card) => _kpiCard(card)).toList(),
          ),
          SizedBox(height: 40),
          ListTile(
            title: Text('Demand Forecasting'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, '/demand'),
          ),
          ListTile(
            title: Text('Inventory'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, '/inventory'),
          ),
          ListTile(
            title: Text('Routes'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => Navigator.pushNamed(context, '/routes'),
          ),
        ],
      ),
    );
  }

  Widget _kpiCard(Map<String, String> data) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: EdgeInsets.all(16),
        width: 120,
        child: Column(
          children: [
            Text(data['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(data['value']!, style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
