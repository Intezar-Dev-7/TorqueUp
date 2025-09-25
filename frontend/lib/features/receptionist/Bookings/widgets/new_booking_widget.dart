import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';
import 'package:frontend/features/receptionist/Bookings/services/BookingServices.dart';
import 'package:intl/intl.dart';

class NewBookingWidget extends StatefulWidget {
  const NewBookingWidget({super.key});

  @override
  State<NewBookingWidget> createState() => _NewBookingWidgetState();
}

class _NewBookingWidgetState extends State<NewBookingWidget> {
  final _formKey = GlobalKey<FormState>();
  final newBooking = VehicleBookingServices();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController problemController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController bookedDateController = TextEditingController();
  final TextEditingController readyDateController = TextEditingController();

  String vehicleStatus = 'Pending';
  @override
  void dispose() {
    super.dispose();
    customerNameController.dispose();
    vehicleNumberController.dispose();
    problemController.dispose();
    statusController.dispose();
    bookedDateController.dispose();
    readyDateController.dispose();
  }

  DateTime? bookedDate;
  DateTime? readyDate;

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController controller,
    bool isBookedDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (!isBookedDate && bookedDate != null && picked.isBefore(bookedDate!)) {
        CustomSnackBar.show(
          context,
          message: '"Ready date cannot be before booked date!"',
          backgroundColor: Colors.redAccent,
        );
      }

      setState(() {
        controller.text = DateFormat('dd MMM yyyy').format(picked);
        if (isBookedDate) {
          bookedDate = picked;
        } else {
          readyDate = picked;
        }
      });
    }
  }

  void addNewBooking() {
    newBooking.newVehicleBooking(
      context: context,
      customerName: customerNameController.text,
      vehicleNumber: vehicleNumberController.text,
      problem: problemController.text,
      status: vehicleStatus,
      bookedDate: bookedDate,
      readyDate: readyDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Center(
        child: Container(
          height: mediaQuery.size.width * 0.7, //80% of screen width,
          width: mediaQuery.size.width * 0.8, //80% of screen width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white, // clean white card look
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "New Booking",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Customer Name
                  TextFormField(
                    controller: customerNameController,
                    decoration: InputDecoration(
                      hintText: "Customer Name",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Enter customer name"
                                : null,
                  ),
                  const SizedBox(height: 20),

                  // Vehicle Number
                  TextFormField(
                    controller: vehicleNumberController,
                    decoration: InputDecoration(
                      hintText: "Vehicle Number",
                      prefixIcon: const Icon(Icons.directions_car),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Enter vehicle number"
                                : null,
                  ),
                  const SizedBox(height: 20),

                  // Problem Description
                  TextFormField(
                    controller: problemController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: "Problem Description",
                      prefixIcon: const Icon(Icons.build),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Enter problem details"
                                : null,
                  ),
                  const SizedBox(height: 20),

                  // DropDownItems
                  SizedBox(
                    width: 200,
                    child: DropdownButtonFormField<String>(
                      elevation: 1,
                      focusColor: Colors.grey[100],
                      initialValue: vehicleStatus,
                      decoration: const InputDecoration(labelText: 'Status'),
                      items:
                          ['Pending', 'Confirmed', 'Completed']
                              .map(
                                (s) =>
                                    DropdownMenuItem(value: s, child: Text(s)),
                              )
                              .toList(),
                      onChanged: (val) {
                        vehicleStatus = val!;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // Booking Date
                  TextFormField(
                    controller: bookedDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Booking Date",
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    onTap: () => _pickDate(context, bookedDateController, true),
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Select booking date"
                                : null,
                  ),
                  const SizedBox(height: 20),

                  // Ready Date
                  TextFormField(
                    controller: readyDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Ready By",
                      prefixIcon: const Icon(Icons.event_available),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    onTap: () => _pickDate(context, readyDateController, false),
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Select ready date"
                                : null,
                  ),
                  const SizedBox(height: 30),

                  // Submit Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final newBooking = {
                                "name": customerNameController.text,
                                "vehicle": vehicleNumberController.text,
                                "problem": problemController.text,
                                "status": vehicleStatus,
                                "bookedDate": bookedDateController.text,
                                "readyDate": readyDateController.text,
                              };
                              addNewBooking();

                              Navigator.pop(
                                context,
                                newBooking,
                              ); // return booking
                            }
                          },
                          child: const Text(
                            "Save Booking",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
