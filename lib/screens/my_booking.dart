import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/helper/colors.dart';
import 'package:flutter_doctor_appointment/helper/dimens.dart';
import 'package:flutter_doctor_appointment/helper/strings.dart';
import 'package:flutter_doctor_appointment/model/my_booking.dart';
import 'package:flutter_doctor_appointment/provider/doctor_provider.dart';
import 'package:flutter_doctor_appointment/widgets/app_bar.dart';
import 'package:flutter_doctor_appointment/widgets/app_button.dart';
import 'package:flutter_doctor_appointment/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyBookingScreen extends StatefulWidget {
  @override
  State<MyBookingScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MyBookingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getDoctorStore(context).myBooking();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DoctorProvider>(builder: (context, doctorStore, snapshot) {
        return Stack(
          children: [
            Column(
              children: [
                const BackAppBar(
                  label: Constants.myBooking,
                ),
                const Divider(
                  color: inactiveColor,
                ),

                Expanded(
                    child: doctorStore.myBookingList.isEmpty
                        ? const Center(
                            child: Text(Constants.noDataFound),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.all(
                               Dimens.padding_20),
                            itemBuilder: (context, index) {
                              MyBooking myBooking =
                                  doctorStore.myBookingList[index];
                              return Container(
                                padding: EdgeInsets.all(Dimens.padding_15),
                                decoration: BoxDecoration(
                                    border: Border.all(color: inactiveColor),
                                    borderRadius: BorderRadius.circular(
                                        Dimens.radius_10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${DateFormat("MMM dd, yyyy").format(myBooking.appointmentDate)} - ${myBooking.appointmentTime}",
                                      style: const TextStyle(
                                        color: black,
                                        fontFamily: Fonts.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimens.padding_7),
                                      child: const Divider(
                                        color: inactiveColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              Dimens.radius_10),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://hireforekam.s3.ap-south-1.amazonaws.com/doctors/4-Doctor.png",
                                            height: Dimens.height_100,
                                            width: Dimens.width_90,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimens.width_15,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: Dimens.height_100,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: Dimens.height_10,
                                                ),
                                                Text(
                                                  myBooking.doctorName,
                                                  style: TextStyle(
                                                    fontFamily: Fonts.bold,
                                                    fontSize:
                                                        Dimens.fontSize_16,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Dimens.height_3,
                                                ),
                                                SizedBox(
                                                  height: Dimens.height_10,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      Images.location,
                                                      color: primaryColor,
                                                      width: Dimens.width_15,
                                                      height: Dimens.height_15,
                                                    ),
                                                    SizedBox(
                                                      width: Dimens.width_5,
                                                    ),
                                                    Text(
                                                      myBooking.location,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            Fonts.medium,
                                                        color: gray,
                                                        fontSize:
                                                            Dimens.fontSize_12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Dimens.height_10,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      Images.id,
                                                      color: primaryColor,
                                                      width: Dimens.width_15,
                                                      height: Dimens.height_15,
                                                    ),
                                                    SizedBox(
                                                      width: Dimens.width_5,
                                                    ),
                                                    Text(
                                                      Constants.bookingId,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            Fonts.medium,
                                                        color: gray,
                                                        fontSize:
                                                            Dimens.fontSize_12,
                                                      ),
                                                    ),
                                                    Text(
                                                      myBooking.bookingId,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            Fonts.semiBold,
                                                        color: primaryColor,
                                                        fontSize:
                                                            Dimens.fontSize_13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Dimens.height_10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimens.padding_7),
                                      child: const Divider(
                                        color: inactiveColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: AppButton(
                                            label: Constants.cancel,
                                            height: Dimens.height_40,
                                            backgroundColor: primaryColor.withOpacity(0.3),
                                            borderColor: primaryColor.withOpacity(0.3),
                                            textColor: primaryColor,
                                            onPressed: () {},
                                          ),
                                        ),
                                        SizedBox(width: Dimens.width_10,),
                                        Expanded(
                                          child: AppButton(
                                            label: Constants.reschedule,
                                            height: Dimens.height_40,
                                            onPressed: () {},
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: Dimens.height_20,
                              );
                            },
                            itemCount: doctorStore.doctorList.length)),

              ],
            ),
            LoadingWithBackground(doctorStore.isLoading)
          ],
        );
      }),
    );
  }
}
