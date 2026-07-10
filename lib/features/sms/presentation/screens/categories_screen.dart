import 'package:flutter/material.dart';

/// Screen for managing transaction categories
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Transfer', 'icon': Icons.compare_arrows, 'color': Colors.blue},
    {'name': 'Cash Withdrawal', 'icon': Icons.local_atm, 'color': Colors.green},
    {'name': 'Bills', 'icon': Icons.receipt, 'color': Colors.orange},
    {'name': 'Food & Dining', 'icon': Icons.restaurant, 'color': Colors.red},
    {'name': 'Groceries', 'icon': Icons.shopping_cart, 'color': Colors.purple},
    {'name': 'Fuel', 'icon': Icons.local_gas_station, 'color': Colors.amber},
    {'name': 'Shopping', 'icon': Icons.shopping_bag, 'color': Colors.pink},
    {
      'name': 'Airtime & Credit',
      'icon': Icons.phone_android,
      'color': Colors.teal,
    },
    {
      'name': 'Mobile Money',
      'icon': Icons.mobile_screen_share,
      'color': Colors.indigo,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories'), elevation: 0),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: (category['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  category['icon'] as IconData,
                  color: category['color'] as Color,
                ),
              ),
              title: Text(category['name'] as String),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(child: Text('Edit')),
                  const PopupMenuItem(child: Text('Delete')),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCategoryDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Category'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: InputDecoration(hintText: 'Category name')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
