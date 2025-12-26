import '../../shared/models/property.dart';
import '../../shared/enums/property_status.dart';

class PropertyRepository {
  final List<Property> _properties = [];

  List<Property> getAll() => _properties;

  void add(Property property) {
    _properties.add(property);
  }

  void update(Property updated) {
    final index = _properties.indexWhere((p) => p.id == updated.id);
    if (index != -1) {
      _properties[index] = updated;
    }
  }
}
