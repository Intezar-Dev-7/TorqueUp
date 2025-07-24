import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/cus_search_bar.dart';
import 'package:frontend/common/widgets/custom_elevated_button.dart';
import 'package:frontend/features/receptionist/Bookings/widgets/compact_calendar.dart';
import 'package:frontend/features/receptionist/Bookings/widgets/custom_calendar_widget.dart';
import 'package:frontend/features/receptionist/data/dummy_data.dart';

import '../../../../utils/colors.dart';

class MechanicsScreen extends StatefulWidget {
  const MechanicsScreen({super.key});

  @override
  State<MechanicsScreen> createState() => _MechanicsScreenState();
}

class _MechanicsScreenState extends State<MechanicsScreen> {
  late Map<String, String> selectedMechanic;
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    selectedMechanic = mechanics.first;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 800; // Phone
    bool isTablet = screenWidth >= 800 && screenWidth < 1200; // Tablet
    bool isDesktop = screenWidth >= 1200; // Desktop
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.grey,
        title: CustomSearchBar(
          searchText: 'Search Mechanic by name,email...',
          button: CustomElevatedButton(text: 'Add Mechanic', onPressed: () {}),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Mechanics',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    mechanicList(isTablet || isMobile),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            !isMobile
                ? Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 22),
                        CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          radius: isTablet ? 80 : 120,
                          child: const Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 100,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          selectedMechanic['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        isTablet
                            ? CompactCalendarWidget()
                            : CustomCalendarWidget(),
                        const SizedBox(height: 22),
                        Container(color: AppColors.grey),
                      ],
                    ),
                  ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }

  Expanded mechanicList(bool isTablet) {
    return Expanded(
      child: ListView.builder(
        itemCount: mechanics.length,
        itemBuilder: (context, index) {
          final mechanic = mechanics[index];
          return InkWell(
            onTap: () {
              setState(() {
                selectedMechanic = mechanic;
                selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                border:
                    selectedIndex == index
                        ? Border.all(color: Colors.blue, width: 2)
                        : null,
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child:
                  isTablet
                      ? mechanicListTileMobile(mechanic)
                      : mechanicListTileGen(mechanic),
            ),
          );
        },
      ),
    );
  }

  Row mechanicListTileMobile(Map<String, String> mechanic) {
    return Row(
      children: [
        // Avatar
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    radius: 24,
                    child: const Icon(Icons.person, color: Colors.black),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    mechanic['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                mechanic['phone']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                mechanic['address']!,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        // Photo, Name
        // Date and Days
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                mechanic['joinedDate']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Joined From ${mechanic['daysJoined']} Days",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row mechanicListTileGen(Map<String, String> mechanic) {
    return Row(
      children: [
        // Avatar
        Expanded(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                radius: 24,
                child: const Icon(Icons.person, color: Colors.black),
              ),
              const SizedBox(width: 12),
              Text(
                mechanic['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        // Photo, Name
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text(
                mechanic['phone']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                mechanic['address']!,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),

        // Date and Days
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                mechanic['joinedDate']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Joined From ${mechanic['daysJoined']} Days",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
