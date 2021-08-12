import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:location/location.dart';

import 'package:uni_mate/model/lecture_model.dart';
import 'package:sizer/sizer.dart';
import 'package:uni_mate/services/my_location_service.dart';

class MarkAttendancePage extends StatefulWidget {
  final Lecture lecture;
  const MarkAttendancePage({
    Key? key,
    required this.lecture,
  }) : super(key: key);

  @override
  _MarkAttendancePageState createState() => _MarkAttendancePageState();
}

class _MarkAttendancePageState extends State<MarkAttendancePage> {
  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("HH:mm");
    String formattedTime = format.format(
        DateTime.fromMillisecondsSinceEpoch(widget.lecture.lectureTime));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              color: Colors.grey.withOpacity(0.1),
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  Container(
                    height: (constraints.maxHeight * 40) / 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Padding(
                                padding: EdgeInsets.all(2.w),
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 24.sp,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "Mark attendance",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
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
                                widget.lecture.lectureName,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                widget.lecture.lecturerName,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "Start at: $formattedTime",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(2.w),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 2.w),
                                  child: Text(
                                    "Attend Now",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
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
                      future: MyLocationService.getLoc(),
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
