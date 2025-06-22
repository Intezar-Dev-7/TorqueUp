class BookingData {
  final DateTime booking_date;
  final String booking_time;
  final String vehicle_name;
  final String owner_name;
  final String vehicle_number;
  final String service_type;
  final String service_status;

  BookingData({
    required this.booking_date,
    required this.booking_time,
    required this.vehicle_name,
    required this.owner_name,
    required this.vehicle_number,
    required this.service_type,
    required this.service_status,
  });
}
