import 'package:flutter/material.dart';
import '../../shared/enums/user_role.dart';
import '../../dashboards/buyer/buyer_dashboard.dart';
import '../../dashboards/seller/seller_dashboard.dart';
import '../../dashboards/agent/agent_dashboard.dart';
import '../../dashboards/owner/owner_dashboard.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void _navigate(BuildContext context, UserRole role) {
    Widget screen;

    switch (role) {
      case UserRole.buyer:
        screen = const BuyerDashboard();
        break;
      case UserRole.seller:
        screen = const SellerDashboard();
        break;
      case UserRole.agent:
        screen = const AgentDashboard();
        break;
      case UserRole.owner:
        screen = const OwnerDashboard();
        break;
      default:
        screen = const BuyerDashboard();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Role')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: UserRole.values.map((role) {
          return Card(
            child: ListTile(
              title: Text(role.name.toUpperCase()),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => _navigate(context, role),
            ),
          );
        }).toList(),
      ),
    );
  }
}
