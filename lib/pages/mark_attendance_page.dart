import 'package:intl/intl.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';

import 'package:uni_mate/model/response_schedule.dart';
import 'package:uni_mate/services/api_services.dart';
import 'package:uni_mate/services/local_services.dart';
import 'package:uni_mate/services/my_location_service.dart';

class MarkAttendancePage extends StatefulWidget {
  final ResponseSchedule schedule;
  const MarkAttendancePage({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  @override
  _MarkAttendancePageState createState() => _MarkAttendancePageState();
}

class _MarkAttendancePageState extends State<MarkAttendancePage> {
  Future<bool> attendanceStatus() async {
    bool attendend =
        await LocalServices.attendanceStatus(scheduleId: widget.schedule.id);
    return attendend;
  }

  Future<void> markAttendance() async {
    try {
      bool isSuccess =
          await APIServices.markAttendance(scheduleId: widget.schedule.id);
      if (isSuccess) {
        LocalServices.markAttendance(scheduleId: widget.schedule.id);
        setState(() {});
        SnackBar snackBar =
            SnackBar(content: Text("your attendance marked succeefully!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        SnackBar snackBar =
            SnackBar(content: Text("failed to mark attendance!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      SnackBar snackBar = SnackBar(content: Text("$e"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("yyyy.MM.dd");
    String formattedDate = format.format(widget.schedule.date);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              color: Colors.grey.withOpacity(0.1),
              child: Column(
                children: [
                  Container(
                    height: (constraints.maxHeight * 40) / 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          5.w, 2.w, 2.w, 2.w),
                                      child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: 20.sp,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    "Mark attendance",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                                  widget.schedule.moduleName,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  widget.schedule.name,
                                  style: TextStyle(
                                      color: Colors.green.shade600,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  "$formattedDate • from ${widget.schedule.startTime.substring(0, 5)} to ${widget.schedule.endTime.substring(0, 5)}",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                FutureBuilder(
                                    future: attendanceStatus(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Center(
                                            child: Text("Error"),
                                          );
                                        } else if (snapshot.hasData) {
                                          bool attended = snapshot.data;
                                          if (attended) {
                                            return Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.green
                                                      .withOpacity(0.8),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.w),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.w,
                                                    vertical: 2.w),
                                                child: Text(
                                                  "Attendance Marked",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Align(
                                              alignment: Alignment.centerRight,
                                              child: GestureDetector(
                                                onTap: () => markAttendance(),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.w),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5.w,
                                                      vertical: 2.w),
                                                  child: Text(
                                                    "Attend Now",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      }
                                      return Align(
                                        alignment: Alignment.bottomRight,
                                        child: CircularProgressIndicator(
                                          color: Colors.orange,
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: (constraints.maxHeight * 60) / 100,
                    child: FutureBuilder(
                      future: MyLocationService.getCurrentLocation(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.error.toString()));
                          } else if (snapshot.hasData) {
                            LocationData locationData = snapshot.data;
                            double? lat = locationData.latitude;
                            double? long = locationData.longitude;
                            return Stack(
                              children: [
                                FlutterMap(
                                  options: MapOptions(
                                    center: latLng.LatLng(lat!, long!),
                                    zoom: 13.0,
                                  ),
                                  layers: [
                                    TileLayerOptions(
                                        urlTemplate:
                                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                        subdomains: ['a', 'b', 'c']),
                                    MarkerLayerOptions(
                                      markers: [
                                        Marker(
                                          width: 80.0,
                                          height: 80.0,
                                          point: latLng.LatLng(lat, long),
                                          builder: (ctx) => Container(
                                            child: Icon(
                                              Icons.place,
                                              size: 35.sp,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.w),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5.w),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.location_searching_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
