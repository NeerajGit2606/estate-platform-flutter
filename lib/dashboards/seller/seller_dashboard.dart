import 'package:flutter/material.dart';
import '../../core/services/property_repository.dart';
import '../../shared/models/property.dart';
import '../../features/property/add_property_screen.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({super.key});

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  final repo = PropertyRepository.instance;

  @override
  Widget build(BuildContext context) {
    final List<Property> properties = repo.getByOwner('seller_001');

    return Scaffold(
      appBar: AppBar(title: const Text('Seller Dashboard')),
      body: properties.isEmpty
          ? const Center(child: Text('No properties yet'))
          : ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final property = properties[index];
                return Card(
                  child: ListTile(
                    title: Text(property.title),
                    subtitle: Text(property.status.name.toUpperCase()),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPropertyScreen()),
          );
          setState(() {}); // 👈 refresh list after return
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
