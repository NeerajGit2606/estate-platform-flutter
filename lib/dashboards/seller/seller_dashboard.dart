import 'package:flutter/material.dart';
import '../../core/services/property_repository.dart';
import '../../shared/models/property.dart';
import '../../features/property/add_property_screen.dart';
import '../../shared/widgets/home_button.dart';

class SellerDashboard extends StatelessWidget {
  const SellerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final PropertyRepository repo = PropertyRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Dashboard'),
        actions: const [HomeButton()],
      ),
      body: StreamBuilder<List<Property>>(
        stream: repo.streamByOwner('seller_001'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No properties yet'));
          }

          final properties = snapshot.data!;

          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];
              return Card(
                child: ListTile(
                  title: Text(property.title),
                  subtitle: Text(
                    property.status.name.toUpperCase(),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPropertyScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
