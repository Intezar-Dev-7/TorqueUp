import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_elevated_button.dart';
import 'package:frontend/features/receptionist/Bookings/services/BookingServices.dart';
import 'package:frontend/features/receptionist/model/vehicle_booking_model.dart';

class EditBookingWidget extends StatefulWidget {
  final NewBooking booking;

  const EditBookingWidget({super.key, required this.booking});
  @override
  State<StatefulWidget> createState() => _EditBookingWidgetState();
}

class _EditBookingWidgetState extends State<EditBookingWidget> {
  String selectedStatus = 'All';

  String status = 'Pending';
  @override
  void initState() {
    status = widget.booking.vehicleBookingStatus; // prefill current status
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Status'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: DropdownButtonFormField<String>(
                elevation: 1,
                focusColor: Colors.grey[100],
                initialValue: status,
                decoration: const InputDecoration(labelText: 'Status'),
                items:
                    ['Pending', 'Completed']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                onChanged: (val) {
                  status = val!;
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.black)),
        ),
        CustomElevatedButton(
          text: 'Save',
          onPressed: () async {
            final updatedBooking = await VehicleBookingServices()
                .updateBookingDetails(
                  bookingId: widget.booking.bookingId,
                  context: context,
                  status: status,
                );

            if (updatedBooking != null) {
              Navigator.of(context).pop(updatedBooking); // return to parent
            }
          },
        ),
      ],
    );
  }
}
