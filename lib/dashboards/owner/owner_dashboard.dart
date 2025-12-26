import 'package:flutter/material.dart';
import '../../core/services/property_repository.dart';
import '../../shared/models/property.dart';
import '../../shared/enums/property_status.dart';
import '../../shared/widgets/home_button.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = PropertyRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Approval Dashboard'),
        actions: const [HomeButton()],
      ),
      body: StreamBuilder<List<Property>>(
        stream: repo.streamSubmitted(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final properties = snapshot.data!;
          if (properties.isEmpty) {
            return const Center(child: Text('No pending approvals'));
          }

          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];
              return Card(
                child: ListTile(
                  title: Text(property.title),
                  subtitle: Text('STATUS: ${property.status.name.toUpperCase()}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () {
                          repo.updateStatus(
                            property.id,
                            PropertyStatus.approved,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          repo.updateStatus(
                            property.id,
                            PropertyStatus.rejected,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
