import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

/// This file defines the `Staff` model class which represents
/// a single staff member in the system.
///
/// Purpose:
/// - To provide a structured way to store and manage staff data.
/// - To facilitate converting staff data to/from JSON or Map, which
///   is essential for API communication and local storage.
/// - To allow easy copying and modification of staff objects.
class Staff {
  final String staffId;
  final String staffName;

  /// Role of the staff member (e.g., Receptionist, Mechanic, Intern).
  final String staffRole;

  /// Experience of the staff member (e.g., "5 years").
  final String staffExperience;

  /// Constructor for creating a Staff object.
  Staff({
    required this.staffId,
    required this.staffName,
    required this.staffRole,
    required this.staffExperience,
  });

  /// Converts the Staff object to a Map.
  /// Useful for sending data to APIs or storing in databases.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': staffId,
      'staffName': staffName,
      'staffRole': staffRole,
      'staffExperience': staffExperience,
    };
  }

  /// Factory constructor to create a Staff object from a Map.
  /// Useful when receiving data from APIs or databases.
  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      staffId: map['_id'] as String,
      staffName: map['staffName'] as String,
      staffRole: map['staffRole'] as String,
      staffExperience: map['staffExperience'] as String,
    );
  }

  /// Converts the Staff object to a JSON string.
  /// Useful for API communication.
  String toJson() => json.encode(toMap());

  /// Factory constructor to create a Staff object from a JSON string.
  /// Useful when parsing JSON responses from APIs.
  factory Staff.fromJson(String source) =>
      Staff.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Creates a copy of the current Staff object with optional updated fields.
  /// Useful for immutability and updating specific fields without modifying the original object.
  Staff copyWith({
    String? staffId,
    String? staffName,
    String? staffRole,
    String? staffExperience,
  }) {
    return Staff(
      staffId: staffId ?? this.staffId,
      staffName: staffName ?? this.staffName,
      staffRole: staffRole ?? this.staffRole,
      staffExperience: staffExperience ?? this.staffExperience,
    );
  }
}
