import 'package:flutter/material.dart';

class InventoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> inventoryData = [
    {"product": "Product A", "stock": 90, "min": 50},
    {"product": "Product B", "stock": 30, "min": 50},
    {"product": "Product C", "stock": 70, "min": 50},
    {"product": "Product D", "stock": 20, "min": 50},
  ];

  InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventory Management')),
      body: ListView.builder(
        itemCount: inventoryData.length,
        itemBuilder: (context, index) {
          final item = inventoryData[index];
          final isLowStock = item['stock'] < item['min'];
          return ListTile(
            title: Text(item['product']),
            subtitle: Text('Stock: ${item['stock']} units'),
            trailing: isLowStock ? Icon(Icons.warning, color: Colors.red) : Icon(Icons.check, color: Colors.green),
          );
        },
      ),
    );
  }
}
