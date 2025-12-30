import 'package:flutter/material.dart';
import '../../core/services/property_repository.dart';
import '../../shared/models/property.dart';
import '../../shared/widgets/home_button.dart';

class BuyerDashboard extends StatelessWidget {
  const BuyerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final PropertyRepository repo = PropertyRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties for You'),
        actions: const [HomeButton()],
      ),
      body: StreamBuilder<List<Property>>(
        stream: repo.streamApprovedForBuyers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No properties available yet'),
            );
          }

          final properties = snapshot.data!;

          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  title: Text(property.title),
                  subtitle: const Text('Verified Property'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Later: property details screen
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
