import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

import '../../data/dummy_data.dart';
import '../../model/mechanics_model.dart';

class MechanicsAvailabilityTable extends StatelessWidget {
  const MechanicsAvailabilityTable({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.build, color: Colors.orange, size: 20),
                SizedBox(width: 8),
                Text(
                  "Mechanics Availability",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                Spacer(),
                Text(
                  "See all",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),

          // Table Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text("S. No", style: _headerStyle())),
                Expanded(flex: 2, child: Text("Name", style: _headerStyle())),
                Expanded(flex: 2, child: Text("Status", style: _headerStyle())),
                Expanded(flex: 2, child: Text("Work on v.", style: _headerStyle())),
                Expanded(flex: 1, child: Text("Time Slot", style: _headerStyle())),
              ],
            ),
          ),

          // Table Rows
          Expanded(
            child: ListView.builder(
              itemCount: mechanics.length,
              itemBuilder: (context, index) {
                return _buildMechanicRow(mechanics[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMechanicRow(MechanicData mechanic, int index) {
    bool isWorking = mechanic.status == "Working";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
        color: index % 2 == 0 ? Colors.grey[50] : Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              mechanic.serialNo,
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              mechanic.name,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isWorking ? Colors.green[100] : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                mechanic.status,
                style: TextStyle(
                  fontSize: 11,
                  color: isWorking ? Colors.green[700] : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              mechanic.workOnVehicle,
              style: TextStyle(
                fontSize: 11,
                color: isWorking ? Colors.grey[700] : Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              mechanic.timeSlot,
              style: TextStyle(
                fontSize: 11,
                color: isWorking ? Colors.grey[700] : Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
  TextStyle _headerStyle() {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.grey[600],
    );
  }
}