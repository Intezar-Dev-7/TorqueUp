class AppointmentData {
  final String serialNo;
  final String vehicle;
  final String owner;
  final String work;
  final String timeSlot;
  final AppointmentStatus status;

  AppointmentData(this.serialNo, this.vehicle, this.owner, this.work, this.timeSlot, this.status);
}

enum AppointmentStatus {
  completed,
  inProgress,
}