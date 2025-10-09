import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Staff {
  final String staffId;
  final String staffName;
  final String staffRole;
  final String staffExperience;
  final String staffContactNumber;
  final String staffEmail;
  final String staffAbout;
  final List<String> skills;

  Staff({
    required this.staffId,
    required this.staffName,
    required this.staffRole,
    required this.staffExperience,
    required this.staffContactNumber,
    this.staffEmail = '',
    this.staffAbout = '',
    this.skills = const [],
  });

  /// Convert Staff object to Map for API or storage
  Map<String, dynamic> toMap() {
    return {
      '_id': staffId,
      'staffName': staffName,
      'staffRole': staffRole,
      'staffExperience': staffExperience,
      'staffContactNumber': staffContactNumber,
      'staffEmail': staffEmail,
      'about': staffAbout,
      'skills': skills,
    };
  }

  /// Create Staff object from Map (API response)
  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      staffId: map['_id'] as String,
      staffName: map['staffName'] as String,
      staffRole: map['staffRole'] as String,
      staffExperience: map['staffExperience'] as String,
      staffContactNumber: map['staffContactNumber'] as String,
      staffEmail: map['staffEmail'] ?? '',
      staffAbout: map['about'] ?? '',
      skills: List<String>.from(map['skills'] ?? []),
    );
  }

  /// Convert Staff object to JSON string
  String toJson() => json.encode(toMap());

  /// Create Staff object from JSON string
  factory Staff.fromJson(String source) =>
      Staff.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Copy Staff object with optional updated fields
  Staff copyWith({
    String? staffId,
    String? staffName,
    String? staffRole,
    String? staffExperience,
    String? staffContactNumber,
    String? staffEmail,
    String? staffAbout,
    List<String>? skills,
  }) {
    return Staff(
      staffId: staffId ?? this.staffId,
      staffName: staffName ?? this.staffName,
      staffRole: staffRole ?? this.staffRole,
      staffExperience: staffExperience ?? this.staffExperience,
      staffContactNumber: staffContactNumber ?? this.staffContactNumber,
      staffEmail: staffEmail ?? this.staffEmail,
      staffAbout: staffAbout ?? this.staffAbout,
      skills: skills ?? this.skills,
    );
  }
}
