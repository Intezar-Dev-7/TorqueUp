import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';
import 'package:frontend/features/receptionist/Bookings/services/booking_services.dart';
import 'package:frontend/utils/colors.dart';
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
  final TextEditingController customerContactNumberController =
      TextEditingController();
  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController problemController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController bookedDateController = TextEditingController();
  final TextEditingController readyDateController = TextEditingController();

  String vehicleStatus = 'Pending';
  DateTime? bookedDate;
  DateTime? readyDate;

  @override
  void dispose() {
    super.dispose();
    customerNameController.dispose();
    customerContactNumberController.dispose();
    vehicleNumberController.dispose();
    problemController.dispose();
    statusController.dispose();
    bookedDateController.dispose();
    readyDateController.dispose();
  }

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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.sky_blue,
              onPrimary: AppColors.white,
              onSurface: AppColors.text_dark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (!isBookedDate && bookedDate != null && picked.isBefore(bookedDate!)) {
        CustomSnackBar.show(
          context,
          message: 'Ready date cannot be before booked date!',
          backgroundColor: AppColors.error,
        );
        return;
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
      customerContactNumber: customerContactNumberController.text,
      problem: problemController.text,
      status: vehicleStatus,
      bookedDate: bookedDate,
      readyDate: readyDate,
    );
  }

  // Responsive breakpoints
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 900;
  bool isDesktop(double width) => width >= 900;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isSmallScreen = isMobile(screenWidth);

        return Container(
          constraints: BoxConstraints(
            maxWidth: isSmallScreen ? screenWidth * 0.95 : 700,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          padding: EdgeInsets.all(isSmallScreen ? 20 : 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with Icon
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.sky_blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.add_circle_outline,
                          color: AppColors.sky_blue,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          "New Booking",
                          style: TextStyle(
                            fontSize: isSmallScreen ? 20 : 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text_dark,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close_rounded,
                          color: AppColors.text_grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 20 : 28),

                  // Form Fields
                  _buildTextField(
                    controller: customerNameController,
                    label: "Customer Name",
                    icon: Icons.person_outline,
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Enter customer name"
                                : null,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: customerContactNumberController,
                    label: "Customer Contact Number",
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter contact number";
                      } else if (val.length != 10) {
                        return "Enter valid 10-digit number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: vehicleNumberController,
                    label: "Vehicle Number",
                    icon: Icons.directions_car_outlined,
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Enter vehicle number"
                                : null,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: problemController,
                    label: "Problem Description",
                    icon: Icons.build_outlined,
                    maxLines: 3,
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Enter problem details"
                                : null,
                  ),
                  const SizedBox(height: 16),

                  // Status Dropdown
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
                      initialValue: vehicleStatus,
                      borderRadius: BorderRadius.circular(12),
                      decoration: InputDecoration(
                        labelText: 'Status',
                        labelStyle: TextStyle(
                          color: AppColors.text_grey,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
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
                          ['Pending', 'Confirmed', 'Completed']
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
                          vehicleStatus = val!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Date Fields in Row for larger screens
                  if (!isSmallScreen)
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateField(
                            controller: bookedDateController,
                            label: "Booking Date",
                            icon: Icons.calendar_today_outlined,
                            onTap:
                                () => _pickDate(
                                  context,
                                  bookedDateController,
                                  true,
                                ),
                            validator:
                                (val) =>
                                    val == null || val.isEmpty
                                        ? "Select booking date"
                                        : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildDateField(
                            controller: readyDateController,
                            label: "Ready By",
                            icon: Icons.event_available_outlined,
                            onTap:
                                () => _pickDate(
                                  context,
                                  readyDateController,
                                  false,
                                ),
                            validator:
                                (val) =>
                                    val == null || val.isEmpty
                                        ? "Select ready date"
                                        : null,
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _buildDateField(
                      controller: bookedDateController,
                      label: "Booking Date",
                      icon: Icons.calendar_today_outlined,
                      onTap:
                          () => _pickDate(context, bookedDateController, true),
                      validator:
                          (val) =>
                              val == null || val.isEmpty
                                  ? "Select booking date"
                                  : null,
                    ),
                    const SizedBox(height: 16),
                    _buildDateField(
                      controller: readyDateController,
                      label: "Ready By",
                      icon: Icons.event_available_outlined,
                      onTap:
                          () => _pickDate(context, readyDateController, false),
                      validator:
                          (val) =>
                              val == null || val.isEmpty
                                  ? "Select ready date"
                                  : null,
                    ),
                  ],

                  SizedBox(height: isSmallScreen ? 24 : 32),

                  // Action Buttons
                  if (!isSmallScreen)
                    Row(
                      children: [
                        Expanded(child: _buildCancelButton(context)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildSaveButton(context)),
                      ],
                    )
                  else ...[
                    _buildSaveButton(context),
                    const SizedBox(height: 12),
                    _buildCancelButton(context),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border_grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(color: AppColors.text_dark, fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.text_grey, fontSize: 14),
          prefixIcon: Icon(icon, color: AppColors.sky_blue, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border_grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        style: TextStyle(color: AppColors.text_dark, fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.text_grey, fontSize: 14),
          prefixIcon: Icon(icon, color: AppColors.sky_blue, size: 20),
          suffixIcon: Icon(Icons.arrow_drop_down, color: AppColors.sky_blue),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        onTap: onTap,
        validator: validator,
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.sky_blue, AppColors.sky_blue_light],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.sky_blue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final newBookingData = {
              "name": customerNameController.text,
              "contact": customerContactNumberController.text,
              "vehicle": vehicleNumberController.text,
              "problem": problemController.text,
              "status": vehicleStatus,
              "bookedDate": bookedDateController.text,
              "readyDate": readyDateController.text,
            };
            addNewBooking();
            Navigator.pop(context, newBookingData);
          }
        },
        icon: Icon(Icons.save_outlined, color: AppColors.white, size: 20),
        label: Text(
          "Save Booking",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.light_bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.sky_blue.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: TextButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(Icons.close_rounded, color: AppColors.sky_blue, size: 20),
        label: Text(
          "Cancel",
          style: TextStyle(
            color: AppColors.sky_blue,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
