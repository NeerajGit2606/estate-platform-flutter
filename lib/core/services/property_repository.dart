import '../../shared/models/property.dart';

class PropertyRepository {
  PropertyRepository._internal();
  static final PropertyRepository instance = PropertyRepository._internal();

  final List<Property> _properties = [];

  List<Property> getAll() => _properties;

  List<Property> getByOwner(String ownerId) {
    return _properties.where((p) => p.ownerId == ownerId).toList();
  }

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
