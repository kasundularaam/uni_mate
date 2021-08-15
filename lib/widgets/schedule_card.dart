import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'package:uni_mate/model/response_schedule.dart';
import 'package:uni_mate/routes/app_router.dart';
import 'package:uni_mate/services/local_services.dart';

class ScheduleCard extends StatelessWidget {
  final ResponseSchedule schedule;
  const ScheduleCard({
    Key? key,
    required this.schedule,
  }) : super(key: key);
  Future<bool> attendanceStatus() async {
    bool attendend =
        await LocalServices.attendanceStatus(scheduleId: schedule.id);
    return attendend;
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy.MM.dd");
    String formattedDate = dateFormat.format(schedule.date);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(
              context, AppRouter.markAttendancePage,
              arguments: schedule),
          child: FutureBuilder<bool>(
              future: attendanceStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.hasData) {
                    bool attended = snapshot.data!;
                    return Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      padding: EdgeInsets.all(5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schedule.moduleName,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            schedule.name,
                            style: TextStyle(
                                color: Colors.green.shade600,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$formattedDate • from ${schedule.startTime.substring(0, 5)} to ${schedule.endTime.substring(0, 5)}",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              attended
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.deepOrange,
                                      size: 20.sp,
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                }
                return SizedBox();
              }),
        ),
        SizedBox(
          height: 3.h,
        ),
      ],
    );
  }
}
