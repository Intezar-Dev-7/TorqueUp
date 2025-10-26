import 'package:flutter/material.dart';

import 'package:frontend/features/receptionist/Bookings/services/booking_services.dart';
import 'package:frontend/features/receptionist/model/vehicle_booking_model.dart';
import 'package:frontend/utils/colors.dart';

class EditBookingWidget extends StatefulWidget {
  final NewBooking booking;

  const EditBookingWidget({super.key, required this.booking});

  @override
  State<StatefulWidget> createState() => _EditBookingWidgetState();
}

class _EditBookingWidgetState extends State<EditBookingWidget> {
  String status = 'Pending';

  @override
  void initState() {
    status = widget.booking.vehicleBookingStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.sky_blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.edit_note_rounded,
              color: AppColors.sky_blue,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Change Status',
            style: TextStyle(
              color: AppColors.text_dark,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: AppColors.light_bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.border_grey.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: DropdownButtonFormField<String>(
                elevation: 2,
                value: status,
                borderRadius: BorderRadius.circular(12),
                decoration: InputDecoration(
                  labelText: 'Status',
                  labelStyle: TextStyle(
                    color: AppColors.text_grey,
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.flag_outlined,
                    color: AppColors.sky_blue,
                    size: 20,
                  ),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.sky_blue,
                ),
                items:
                    ['Pending', 'Completed']
                        .map(
                          (s) => DropdownMenuItem(
                            value: s,
                            child: Text(
                              s,
                              style: TextStyle(
                                color: AppColors.text_dark,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (val) {
                  setState(() {
                    status = val!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: AppColors.text_grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.sky_blue, AppColors.sky_blue_light],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.sky_blue.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextButton(
            onPressed: () async {
              final updatedBooking = await VehicleBookingServices()
                  .updateBookingDetails(
                    bookingId: widget.booking.bookingId,
                    context: context,
                    status: status,
                  );

              if (updatedBooking != null) {
                Navigator.of(context).pop(updatedBooking);
              }
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              'Save',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
