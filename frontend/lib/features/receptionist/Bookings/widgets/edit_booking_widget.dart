import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_textfield.dart';

class EditBookingWidget extends StatefulWidget {
  final Map<String, String> booking;

  const EditBookingWidget({super.key, required this.booking});
  @override
  State<StatefulWidget> createState() => _EditBookingWidgetState();
}

class _EditBookingWidgetState extends State<EditBookingWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  // FocusNodes
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode vehicleFocusNode = FocusNode();
  final FocusNode timeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with booking data
    nameController.text = widget.booking['name'] ?? '';
    vehicleController.text = widget.booking['vehicle'] ?? '';
    timeController.text = widget.booking['time'] ?? '';
    status = widget.booking['status'] ?? 'Pending';
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    vehicleController.dispose();
    timeController.dispose();

    // Disposing all the focus nodes
    nameFocusNode.dispose();
    vehicleFocusNode.dispose();
    timeFocusNode.dispose();
  }

  DateTime selectedDate = DateTime.now();
  String selectedStatus = 'All';

  String status = 'Pending';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Booking'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: nameController,
              hintText: 'Customer Name',
              focusNode: nameFocusNode,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: vehicleController,
              hintText: 'Vehicle No.',
              focusNode: vehicleFocusNode,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: timeController,
              hintText: 'Time',
              focusNode: timeFocusNode,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: DropdownButtonFormField<String>(
                elevation: 1,
                focusColor: Colors.grey[100],
                value: status,
                decoration: const InputDecoration(labelText: 'Status'),
                items:
                    ['Confirmed', 'Pending', 'Completed']
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
        ElevatedButton(
          onPressed: () {
            // Create a new updated booking map
            final updatedBooking = {
              'name': nameController.text,
              'vehicle': vehicleController.text,
              'time': timeController.text,
              'status': status,
            };

            // Close the dialog and send back the updated booking
            Navigator.of(context).pop(updatedBooking);
          },
          child: const Text('Save', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
