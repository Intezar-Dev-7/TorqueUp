import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_elevated_button.dart';
import 'package:frontend/features/receptionist/Bookings/widgets/compact_calendar.dart';
import 'package:frontend/features/receptionist/data/dummy_data.dart';
import 'package:frontend/utils/colors.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 800; // Phone
    double titleFontSize = isMobile ? 16 : 22;
    double subtitleFontSize = isMobile ? 10 : 16;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: AppColors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("this is date"),
            CustomElevatedButton(text: 'New Booking', onPressed: () {}),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: isMobile ? Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: CompactCalendarWidget()

                      ),
                    ),

                    bookingList(titleFontSize, subtitleFontSize, isMobile),
                  ],
                ) :
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child:CompactCalendarWidget()

                  ),
                ),
                SizedBox(width: 10),
                bookingList(titleFontSize, subtitleFontSize, isMobile),
              ],
            )

      ),
    );
  }

  Expanded bookingList(double titleFontSize, double subtitleFontSize, bool isMobile) {
    return Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bookings',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: bookings.length,
                            itemBuilder: (context, index) {
                              final booking = bookings[index];
                              return Container(
                                padding: EdgeInsets.all(10),
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          cum_column_widget(
                                            booking.booking_time
                                                .split('-')
                                                .first,
                                            booking.booking_time
                                                .split('-')
                                                .last,
                                            titleFontSize,
                                            subtitleFontSize,
                                          ),
                                          VerticalDivider(
                                            thickness: isMobile? 4 : 6,
                                            endIndent: 4,
                                            indent: 4,
                                            color: AppColors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          cum_column_widget(
                                            booking.owner_name,
                                            booking.vehicle_name,
                                            titleFontSize,
                                            subtitleFontSize,
                                          ),
                                          cum_column_widget(
                                            'Type',
                                            booking.service_type,
                                            titleFontSize,
                                            subtitleFontSize,
                                          ),
                                          cum_column_widget(
                                            'Status',
                                            booking.service_status,
                                            titleFontSize,
                                            subtitleFontSize,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
  }

  Widget cum_column_widget(
    String title,
    String sub_title,
    double title_font_size,
    double subtitle_font_size,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: title_font_size,
              overflow: TextOverflow.ellipsis
            ),
          ),
          SizedBox(height: 6),
          Text(sub_title, style: TextStyle(fontSize: subtitle_font_size,overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
