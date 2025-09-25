import '../../../utils/constant/constant.dart';
import '../../receptionist/model/appointment_model.dart';

final List<dynamic> top_widget_data = [
  {'icon': GenIcons.money, 'title': 'Today\'s Revenue', 'value': 5320},
  {'icon': ServiceIcons.inProgress, 'title': 'Active Services', 'value': 5},
  {'icon': ServiceIcons.completed, 'title': 'Completed Services', 'value': 16},
  {'icon': ServiceIcons.scheduled, 'title': 'Scheduled Services', 'value': 14},
];
final inventory_item = [
  {
    'serial_no': 1,
    'image': GenImages.castrol,
    'name': 'Castrol Active',
    'desc': '20W-40',
    'available': 19,
  },
  {
    'serial_no': 2,
    'image': GenImages.apollo,
    'name': 'Apollo Tyre',
    'desc': '190/70',
    'available': 29,
  },
  {
    'serial_no': 3,
    'image': GenImages.motul,
    'name': 'Motul Oil',
    'desc': '4T 20W-40',
    'available': 24,
  },
];
final List<Map<String, String>> customers = const [
  {
    'id': '01',
    'name': 'Hemant Sahu',
    'phone': '8243294872',
    'email': 'hemantsahu123@gmail.com',
    'address': 'schema 103 kesar bag bridge indore',
    'vehicles': 'CT100, TATA Curvv, Honda Shine 125',
  },
  {
    'id': '02',
    'name': 'Rajaram Sahu',
    'phone': '8243294872',
    'email': 'rajaramsahu123@gmail.com',
    'address': 'schema 103 kesar bag bridge indore',
    'vehicles': 'CT100, TATA Curvv, Honda Shine 125',
  },
  {
    'id': '03',
    'name': 'Sourabh kori',
    'phone': '8243294872',
    'email': 'sourabhkori123@gmail.com',
    'address': 'schema 103 kesar bag bridge indore',
    'vehicles': 'CT100, TATA Curvv, Honda Shine 125',
  },
  {
    'id': '04',
    'name': 'Vivek Ahirwar',
    'phone': '8243294872',
    'email': 'vivekahir123@gmail.com',
    'address': 'schema 103 kesar bag bridge indore',
    'vehicles': 'CT100, TATA Curvv, Honda Shine 125',
  },
];
// final List<Map<String, dynamic>> notification_data = [
//   {
//     'id': '01',
//     'title': 'New Booking',
//     'type': 'Booking',
//     'time': '10:00 AM',
//     'desc': 'New booking for Honda Shine 125',
//     'read': false,
//   },
//   {
//     'id': '02',
//     'title': 'MP05MV6802',
//     'type': 'Invoice',
//     'time': '11:20 AM',
//     'desc': 'General service invoice for Bajaj CT100',
//     'read': true,
//   },
//   {
//     'id': '03',
//     'title': 'MP05MV6802',
//     'type': 'Repairing',
//     'time': '11:50 AM',
//     'desc': 'Honda Shine 125 repairing work',
//     'read': false,
//   },
//   {
//     'id': '04',
//     'title': 'New Booking',
//     'type': 'Booking',
//     'time': '10:00 AM',
//     'desc':
//         'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here,content here making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident',
//     'read': false,
//   },
// ];

final List<AppointmentData> appointments = [
  AppointmentData(
    "01",
    "Tata Safari",
    "Raja Ram.",
    "Gen. Serv.",
    "10-11",
    AppointmentStatus.completed,
  ),
  AppointmentData(
    "02",
    "Tata Curvv",
    "Hemant s.",
    "Repairing",
    "11-1",
    AppointmentStatus.inProgress,
  ),
  AppointmentData(
    "03",
    "CT 100 ES",
    "Hemant s.",
    "Gen. Serv.",
    "1-2",
    AppointmentStatus.inProgress,
  ),
  AppointmentData(
    "04",
    "Shine 125",
    "Bhupendr.",
    "Gen. Serv.",
    "2-3",
    AppointmentStatus.inProgress,
  ),
  AppointmentData(
    "05",
    "Tata Safari",
    "Raja Ram.",
    "Gen. Serv.",
    "3-4",
    AppointmentStatus.completed,
  ),
  AppointmentData(
    "06",
    "Tata Curvv",
    "Hemant s.",
    "Repairing",
    "4-6",
    AppointmentStatus.inProgress,
  ),
  AppointmentData(
    "07",
    "CT 100 ES",
    "Hemant s.",
    "Gen. Serv.",
    "6-7",
    AppointmentStatus.inProgress,
  ),
  AppointmentData(
    "08",
    "Tata Safari",
    "Raja Ram.",
    "Gen. Serv.",
    "7-8",
    AppointmentStatus.completed,
  ),
  AppointmentData(
    "09",
    "Tata Curvv",
    "Hemant s.",
    "Repairing",
    "8-10",
    AppointmentStatus.inProgress,
  ),
  AppointmentData(
    "10",
    "CT 100 ES",
    "Hemant s.",
    "Gen. Serv.",
    "10-11",
    AppointmentStatus.inProgress,
  ),
  AppointmentData(
    "11",
    "Shine 125",
    "Bhupendr.",
    "Gen. Serv.",
    "Tom",
    AppointmentStatus.inProgress,
  ),
];

// final List<MechanicData> mechanics_availability = [
//   MechanicData(
//     "1",
//     "Mechanic one",
//     "Working",
//     "MP05\nMV6802",
//     "10:30AM - 12:30PM",
//   ),
//   MechanicData("2", "Mechanic one", "Idle", "-------", "----------------"),
//   MechanicData(
//     "3",
//     "Mechanic one",
//     "Working",
//     "MP05\nMV6802",
//     "10:30AM - 12:30PM",
//   ),
//   MechanicData("4", "Mechanic one", "Idle", "-------", "----------------"),
//   MechanicData(
//     "5",
//     "Mechanic one",
//     "Working",
//     "MP05\nMV6802",
//     "10:30AM - 12:30PM",
//   ),
// ];
// final List<InventoryItem> inventoryItems = [
//   InventoryItem(
//     serialNo: "01",
//     productName: "Castrol Active",
//     productCode: "20W-40",
//     availableQuantity: 29,
//     addQuantity: 5,
//     productImage: "assets/castrol_oil.png",
//     // You can replace with actual asset
//     productType: ProductType.oil,
//   ),
//   InventoryItem(
//     serialNo: "02",
//     productName: "Apollo Tyre",
//     productCode: "190/70",
//     availableQuantity: 29,
//     addQuantity: 5,
//     productImage: "assets/apollo_tyre.png",
//     // You can replace with actual asset
//     productType: ProductType.tyre,
//   ),
//   InventoryItem(
//     serialNo: "03",
//     productName: "Motul Oil",
//     productCode: "4T 20W-40",
//     availableQuantity: 29,
//     addQuantity: 5,
//     productImage: "assets/motul_oil.png",
//     // You can replace with actual asset
//     productType: ProductType.oil,
//   ),
// ];
// List<BookingData> bookings = [
//   BookingData(
//     booking_date: DateTime.now(),
//     booking_time: '9:00 AM - 10:00 AM',
//     vehicle_name: 'Tata Harrier',
//     owner_name: 'Hemant sahu',
//     vehicle_number: 'MP05MV6802',
//     service_type: 'General Service',
//     service_status: 'Completed',
//   ),
//   BookingData(
//     booking_date: DateTime.now(),
//     booking_time: '10:00 AM - 11:00 AM',
//     vehicle_name: 'Tata Safari',
//     owner_name: 'Rajaram sahu',
//     vehicle_number: 'MP05MV6802',
//     service_type: 'Repairing',
//     service_status: 'Pending',
//   ),
//   BookingData(
//     booking_date: DateTime.now(),
//     booking_time: '9:00 AM - 10:00 AM',
//     vehicle_name: 'Tata Harrier',
//     owner_name: 'Hemant sahu',
//     vehicle_number: 'MP05MV6802',
//     service_type: 'General Service',
//     service_status: 'Completed',
//   ),
//   BookingData(
//     booking_date: DateTime.now(),
//     booking_time: '10:00 AM - 11:00 AM',
//     vehicle_name: 'Tata Safari',
//     owner_name: 'Rajaram sahu',
//     vehicle_number: 'MP05MV6802',
//     service_type: 'Repairing',
//     service_status: 'Pending',
//   ),
// ];
List<Map<String, String>> mechanics = [
  {
    "name": "Jane Cooper",
    "phone": "7854123698",
    "address": "Schema 103 kesar bag bridge",
    "joinedDate": "Mar 1, 2022",
    "daysJoined": "235",
  },
  {
    "name": "Arlene McCoy",
    "phone": "7854123698",
    "address": "Schema 103 kesar bag bridge",
    "joinedDate": "Mar 1, 2022",
    "daysJoined": "235",
  },
  {
    "name": "Deon Lie",
    "phone": "7854123698",
    "address": "Schema 103 kesar bag bridge",
    "joinedDate": "Mar 1, 2022",
    "daysJoined": "235",
  },
  {
    "name": "Jane Cooper",
    "phone": "7854123698",
    "address": "Schema 103 kesar bag bridge",
    "joinedDate": "Mar 1, 2022",
    "daysJoined": "235",
  },
  {
    "name": "Jane Cooper",
    "phone": "7854123698",
    "address": "Schema 103 kesar bag bridge",
    "joinedDate": "Mar 1, 2022",
    "daysJoined": "235",
  },
  {
    "name": "Jane Cooper",
    "phone": "7854123698",
    "address": "Schema 103 kesar bag bridge",
    "joinedDate": "Mar 1, 2022",
    "daysJoined": "235",
  },
];

final List<Map<String, dynamic>> service_vehicles = [
  {
    "name": "TATA Safari",
    "number": "MP05 MV 0312",
    "imageUrl": GenImages.safari,
    "status": "Working",
    "owner": {
      "name": "Hemant sahu",
      "contact": "909875219",
      "mail": "hemantsahu@gmail.com",
      "address": "Jummerati word 26 H.bad",
    },
    "car": {
      "model": "Safari stealth",
      "year": "2024",
      "fuel": "Diesel",
      "transmission": "Automatic",
    },
    "issues": [
      {
        "title": "Engine Overheating",
        "desc": "After 15m of running engine is overheating",
      },
      {
        "title": "Strange Engine Noises",
        "desc": "Tik tik tik sound coming from engine",
      },
      {"title": "Brake Failure", "desc": "Brake is not Working"},
    ],
    "resolved": [
      {
        "title": "Wheel Alignment",
        "desc": "Car turn left without rotate staring",
      },
    ],
  },
  {
    "name": "Fortunar",
    "number": "MP05 MV 6802",
    "imageUrl": GenImages.safari,
    "status": "Pending",
    "owner": {
      "name": "Rajaram sahu",
      "contact": "85487956312",
      "mail": "rajaramsahu@gmail.com",
      "address": "Jummerati word 26 H.bad",
    },
    "car": {
      "model": "Safari stealth",
      "year": "2024",
      "fuel": "Diesel",
      "transmission": "Manual",
    },
    "issues": [
      {
        "title": "Engine Overheating",
        "desc": "After 15m of running engine is overheating",
      },
      {
        "title": "Strange Engine Noises",
        "desc": "Tik tik tik sound coming from engine",
      },
      {"title": "Brake Failure", "desc": "Brake is not Working"},
    ],
    "resolved": [
      {
        "title": "Wheel Alignment",
        "desc": "Car turn left without rotate staring",
      },
    ],
  },
];
