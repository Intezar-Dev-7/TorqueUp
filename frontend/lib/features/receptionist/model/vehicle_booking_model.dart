import 'dart:convert';

/*Model class representing a **New Booking** in the system.
Contains details about the customer, their vehicle, problem description,
and booking dates. */
class NewBooking {
  final String bookingId;
  final String customerName;
  final String vehicleNumber;
  final String problem;
  String status;
  final DateTime bookedDate;
  final DateTime readyDate;

  /// Constructor for creating a NewBooking object.
  NewBooking({
    required this.bookingId,
    required this.customerName,
    required this.vehicleNumber,
    required this.problem,
    required this.status,
    required this.bookedDate,
    required this.readyDate,
  });

  /// Converts the object into a **Map** (useful for saving to databases).
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': bookingId,
      'customerName': customerName,
      'vehicleNumber': vehicleNumber,
      'problem': problem,
      'status': status,
      'bookedDate': bookedDate.toIso8601String(),
      'readyDate': readyDate.toIso8601String(),
    };
  }

  factory NewBooking.fromMap(Map<String, dynamic> map) {
    return NewBooking(
      bookingId: map['_id']?.toString() ?? '',
      customerName: map['customerName'] ?? 'Unknown',
      vehicleNumber: map['vehicleNumber'] ?? 'N/A',
      problem: map['problem'] ?? 'No description',
      status: map['status'] ?? 'Pending',
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

  /// Factory constructor: creates a **NewBooking object** from a JSON string.
  factory NewBooking.fromJson(String source) =>
      NewBooking.fromMap(json.decode(source) as Map<String, dynamic>);

  // For list of bookings
  static List<NewBooking> listFromJson(String source) {
    final data = json.decode(source) as List<dynamic>;
    return data.map((item) => NewBooking.fromMap(item)).toList();
  }

  /// Creates a **copy of the object** with optional new values.
  /// Very useful for updating only certain fields while keeping others same.
  NewBooking copyWith({
    String? bookingId,
    String? customerName,
    String? vehicleNumber,
    String? problem,
    String? status,
    DateTime? bookedDate,
    DateTime? readyDate,
  }) {
    return NewBooking(
      bookingId: bookingId ?? this.bookingId,
      customerName: customerName ?? this.customerName,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      problem: problem ?? this.problem,
      status: status ?? this.status,
      bookedDate: bookedDate ?? this.bookedDate,
      readyDate: readyDate ?? this.readyDate,
    );
  }
}
