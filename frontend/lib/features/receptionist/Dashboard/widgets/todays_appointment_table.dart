// import 'package:flutter/material.dart';
// import 'package:frontend/features/admin/data/dummy_data.dart';

// class TodaysAppointmentsTable extends StatelessWidget {
//   const TodaysAppointmentsTable({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     final bool isMobile = screenWidth < 600; // Phone
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Container(
//             padding: EdgeInsets.all(14),
//             child: Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.green[100],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(
//                     Icons.calendar_today,
//                     color: Colors.green,
//                     size: 16,
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Text(
//                   "Today's Appointments",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[700],
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Spacer(),
//                 TextButton(
//                   onPressed: () {},
//                   child: Text(
//                     "See all",
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.blue,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Table Header
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey[50],
//               border: Border(
//                 top: BorderSide(color: Colors.grey[200]!),
//                 bottom: BorderSide(color: Colors.grey[200]!),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Expanded(flex: 1, child: Text("S. No", style: _headerStyle())),
//                 Expanded(
//                   flex: 2,
//                   child: Text("Vehicle", style: _headerStyle()),
//                 ),
//                 Visibility(
//                   visible: !isMobile,
//                   child: Expanded(
//                     flex: 2,
//                     child: Text("Owner", style: _headerStyle()),
//                   ),
//                 ),
//                 Expanded(flex: 2, child: Text("Work", style: _headerStyle())),
//                 Expanded(
//                   flex: 1,
//                   child: Text("Time Slot", style: _headerStyle()),
//                 ),
//                 Expanded(flex: 1, child: Text("Status", style: _headerStyle())),
//               ],
//             ),
//           ),

//           // Appointments List
//           Expanded(
//             child: ListView.builder(
//               itemCount: appointments.length,
//               itemBuilder: (context, index) {
//                 return _buildAppointmentRow(appointments[index], isMobile);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAppointmentRow(AppointmentData appointment, bool isMobile) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.grey[100]!, width: 1)),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Text(
//               appointment.serialNo,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.blue,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   appointment.vehicle,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 Text(
//                   "MP05MW6802",
//                   style: TextStyle(fontSize: 11, color: Colors.grey[500]),
//                 ),
//               ],
//             ),
//           ),
//           Visibility(
//             visible: !isMobile,
//             child: Expanded(
//               flex: 2,
//               child: Text(
//                 appointment.owner,
//                 style: TextStyle(fontSize: 13, color: Colors.grey[600]),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               appointment.work,
//               style: TextStyle(fontSize: 13, color: Colors.grey[600]),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               appointment.timeSlot,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Container(
//               width: 24,
//               height: 24,
//               decoration: BoxDecoration(
//                 color:
//                     appointment.status == AppointmentStatus.completed
//                         ? Colors.green
//                         : Colors.orange,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 appointment.status == AppointmentStatus.completed
//                     ? Icons.check
//                     : Icons.access_time,
//                 color: Colors.white,
//                 size: 14,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   TextStyle _headerStyle() {
//     return TextStyle(
//       fontSize: 12,
//       fontWeight: FontWeight.w600,
//       color: Colors.grey[600],
//     );
//   }
// }
