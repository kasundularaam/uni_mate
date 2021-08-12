import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'package:uni_mate/model/lecture_model.dart';
import 'package:uni_mate/routes/app_router.dart';

class LectureCard extends StatelessWidget {
  final Lecture lecture;
  const LectureCard({
    Key? key,
    required this.lecture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("HH:mm");
    String formattedTime =
        format.format(DateTime.fromMillisecondsSinceEpoch(lecture.lectureTime));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(
              context, AppRouter.markAttendancePage,
              arguments: lecture),
          child: Container(
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
                  lecture.lectureName,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  lecture.lecturerName,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Start at: $formattedTime",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
      ],
    );
  }
}
