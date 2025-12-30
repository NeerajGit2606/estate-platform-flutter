import 'package:flutter/material.dart';
import '../../shared/models/property.dart';
import '../../shared/enums/property_status.dart';
import '../../core/services/property_repository.dart';
import '../../shared/widgets/home_button.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final TextEditingController _titleController = TextEditingController();
  final PropertyRepository repo = PropertyRepository();

  Future<void> _saveDraft() async {
    final property = Property(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      ownerId: 'seller_001',
      status: PropertyStatus.draft,
    );

    await repo.add(property);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Property saved as Draft')),
    );

    Navigator.pop(context);
  }

  Future<void> _submitForApproval() async {
    final property = Property(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      ownerId: 'seller_001',
      status: PropertyStatus.submitted,
    );

    await repo.add(property);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Property submitted for approval')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Property'),
        actions: const [HomeButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Property Title',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveDraft,
                    child: const Text('Save Draft'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitForApproval,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
