import '../enums/property_status.dart';

class Property {
  final String id;
  final String title;
  final String ownerId;
  final PropertyStatus status;
  final bool isPremium;

  Property({
    required this.id,
    required this.title,
    required this.ownerId,
    required this.status,
    this.isPremium = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'ownerId': ownerId,
      'status': status.name,
      'isPremium': isPremium,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['id'],
      title: map['title'],
      ownerId: map['ownerId'],
      status: PropertyStatus.values.firstWhere((e) => e.name == map['status']),
      isPremium: map['isPremium'] ?? false,
    );
  }

  Property copyWith({PropertyStatus? status, bool? isPremium}) {
    return Property(
      id: id,
      title: title,
      ownerId: ownerId,
      status: status ?? this.status,
      isPremium: isPremium ?? this.isPremium,
    );
  }
}
