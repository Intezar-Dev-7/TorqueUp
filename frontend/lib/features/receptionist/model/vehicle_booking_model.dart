import 'dart:convert';

/// Model class representing a **New Booking** in the system.
/// Contains details about the customer, their vehicle, problem description,
/// and booking dates.
class NewBooking {
  final String bookingId;
  final String customerName;
  final String vehicleNumber;
  final String customerContactNumber;
  final String problem;
  String vehicleBookingStatus;
  final DateTime bookedDate;
  final DateTime readyDate;

  /// Constructor for creating a NewBooking object.
  NewBooking({
    required this.bookingId,
    required this.customerName,
    required this.vehicleNumber,
    required this.customerContactNumber,
    required this.problem,
    required this.vehicleBookingStatus, // ✅ renamed
    required this.bookedDate,
    required this.readyDate,
  });

  /// Converts the object into a **Map** (for saving to backend / database).
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': bookingId,
      'customerName': customerName,
      'vehicleNumber': vehicleNumber,
      'customerContactNumber': customerContactNumber,
      'problem': problem,
      'vehicleBookingStatus': vehicleBookingStatus, // ✅ key matches backend
      'bookedDate': bookedDate.toIso8601String(),
      'readyDate': readyDate.toIso8601String(),
    };
  }

  /// Converts a map (JSON object) to a NewBooking object.
  factory NewBooking.fromMap(Map<String, dynamic> map) {
    return NewBooking(
      bookingId: map['_id']?.toString() ?? '',
      customerName: map['customerName'] ?? 'Unknown',
      vehicleNumber: map['vehicleNumber'] ?? 'N/A',
      customerContactNumber: map['customerContactNumber'] ?? 'N/A',
      problem: map['problem'] ?? 'No description',
      vehicleBookingStatus:
          map['vehicleBookingStatus'] ?? 'Pending', // ✅ renamed
      bookedDate:
          map['bookedDate'] != null
              ? DateTime.parse(map['bookedDate'])
              : DateTime.now(),
      readyDate:
          map['readyDate'] != null
              ? DateTime.parse(map['readyDate'])
              : DateTime.now(),
    );
  }

  /// Converts the object into a **JSON string**.
  String toJson() => json.encode(toMap());

  /// Factory constructor: creates a **NewBooking** object from a JSON string.
  factory NewBooking.fromJson(String source) =>
      NewBooking.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Converts a JSON array string into a list of **NewBooking** objects.
  static List<NewBooking> listFromJson(String source) {
    final data = json.decode(source) as List<dynamic>;
    return data.map((item) => NewBooking.fromMap(item)).toList();
  }

  /// Creates a **copy of the object** with optional updated values.
  NewBooking copyWith({
    String? bookingId,
    String? customerName,
    String? vehicleNumber,
    String? customerContactNumber,
    String? problem,
    String? vehicleBookingStatus, // ✅ updated
    DateTime? bookedDate,
    DateTime? readyDate,
  }) {
    return NewBooking(
      bookingId: bookingId ?? this.bookingId,
      customerName: customerName ?? this.customerName,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      customerContactNumber:
          customerContactNumber ?? this.customerContactNumber,
      problem: problem ?? this.problem,
      vehicleBookingStatus:
          vehicleBookingStatus ?? this.vehicleBookingStatus, // ✅ updated
      bookedDate: bookedDate ?? this.bookedDate,
      readyDate: readyDate ?? this.readyDate,
    );
  }
}
