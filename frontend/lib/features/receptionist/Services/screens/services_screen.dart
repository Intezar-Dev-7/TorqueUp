import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/cus_search_bar.dart';
import 'package:frontend/utils/colors.dart';

import '../../../admin/data/dummy_data.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedVehicle = service_vehicles[selectedIndex];

    return LayoutBuilder(
      builder: (context, constraints) {
        var screenWidth = constraints.maxWidth;
        final isMobile = screenWidth < 600;
        final isTablet = screenWidth >= 600 && screenWidth < 1100;
        final isDesktop = screenWidth > 1000;

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            title: CustomSearchBar(
              searchText: 'Search Vehicles',
              button: SizedBox(),
            ),
          ),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile)
                Container(
                  margin: EdgeInsets.all(16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Vehicles",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...service_vehicles.asMap().entries.map((entry) {
                        int i = entry.key;
                        var v = entry.value;
                        return GestureDetector(
                          onTap: () => setState(() => selectedIndex = i),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  i == selectedIndex
                                      ? Colors.blue.shade50
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  v['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  v['number'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Vehicle Image and Status
                      isTablet || isMobile
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      selectedVehicle['imageUrl'],
                                      width: isMobile ? 200 : 300,
                                      height: isMobile ? 150 : 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "🚗 Working",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      Text(
                                        "Owner Details",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "Name - ${selectedVehicle['owner']['name']}",
                                      ),
                                      Text(
                                        "Contact - ${selectedVehicle['owner']['contact']}",
                                      ),
                                      Text(
                                        "Mail - ${selectedVehicle['owner']['mail']}",
                                      ),
                                      Text(
                                        "Add - ${selectedVehicle['owner']['address']}",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      Text(
                                        "Car Details",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "Model - ${selectedVehicle['car']['model']}",
                                      ),
                                      Text(
                                        "Manf. year - ${selectedVehicle['car']['year']}",
                                      ),
                                      Text(
                                        "Fuel type - ${selectedVehicle['car']['fuel']}",
                                      ),
                                      Text(
                                        "Transmission - ${selectedVehicle['car']['transmission']}",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                          : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  selectedVehicle['imageUrl'],
                                  width: isTablet ? 300 : 400,
                                  height: isTablet ? 200 : 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "🚗 Working",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Owner Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "Name - ${selectedVehicle['owner']['name']}",
                                  ),
                                  Text(
                                    "Contact - ${selectedVehicle['owner']['contact']}",
                                  ),
                                  Text(
                                    "Mail - ${selectedVehicle['owner']['mail']}",
                                  ),
                                  Text(
                                    "Add - ${selectedVehicle['owner']['address']}",
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Car Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "Model - ${selectedVehicle['car']['model']}",
                                  ),
                                  Text(
                                    "Manf. year - ${selectedVehicle['car']['year']}",
                                  ),
                                  Text(
                                    "Fuel type - ${selectedVehicle['car']['fuel']}",
                                  ),
                                  Text(
                                    "Transmission - ${selectedVehicle['car']['transmission']}",
                                  ),
                                ],
                              ),
                            ],
                          ),
                      const SizedBox(height: 16),

                      // Issue Section
                      const Text(
                        "Issue",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(
                          selectedVehicle['issues'].length,
                          (index) {
                            final issue = selectedVehicle['issues'][index];
                            return Container(
                              width: isMobile ? double.infinity : 200,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    issue['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(issue['desc']),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16),
                      const Text(
                        "Resolved",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(
                          selectedVehicle['resolved'].length,
                          (index) {
                            final res = selectedVehicle['resolved'][index];
                            return Container(
                              width: isMobile ? double.infinity : 200,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    res['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(res['desc']),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
