import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/helper/colors.dart';
import 'package:flutter_doctor_appointment/helper/dimens.dart';
import 'package:flutter_doctor_appointment/helper/navigation.dart';
import 'package:flutter_doctor_appointment/helper/routes.dart';
import 'package:flutter_doctor_appointment/helper/snakbar.dart';
import 'package:flutter_doctor_appointment/helper/strings.dart';
import 'package:flutter_doctor_appointment/model/doctor.dart';
import 'package:flutter_doctor_appointment/provider/doctor_provider.dart';
import 'package:flutter_doctor_appointment/widgets/app_bar.dart';
import 'package:flutter_doctor_appointment/widgets/app_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'select_package.dart';

class BookAppointMentScreen extends StatefulWidget {
  Doctor doctor;

  BookAppointMentScreen(this.doctor);

  @override
  State<BookAppointMentScreen> createState() => _BookAppointMentScreenState();
}

class _BookAppointMentScreenState extends State<BookAppointMentScreen> {
  int selectedDayIndex = 0;
  int selectedTimeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DoctorProvider>(builder: (context, doctorStore, snapshot) {
        List<String> timeList = doctorStore.getTimeList(widget.doctor,
            doctorStore.getDateFromList(widget.doctor, selectedDayIndex));
        return Column(
          children: [
            const BackAppBar(
              label: Constants.bookAppointment,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimens.padding_10),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimens.padding_20),
                        child: Row(
                          children: [
                            SizedBox(
                              height: Dimens.height_100,
                              width: Dimens.height_100,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.radius_60),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.doctor.image,
                                      height: Dimens.height_100,
                                      width: Dimens.height_100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: Dimens.padding_3,
                                          bottom: Dimens.padding_3),
                                      child: Container(
                                        width: Dimens.width_25,
                                        height: Dimens.height_25,
                                        decoration: const BoxDecoration(
                                          color: white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.asset(
                                          Images.check,
                                          color: primaryColor,
                                          width: Dimens.width_25,
                                          height: Dimens.height_25,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Dimens.width_15,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: Dimens.height_100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: Dimens.height_10,
                                    ),
                                    Text(
                                      widget.doctor.doctorName,
                                      style: TextStyle(
                                        fontFamily: Fonts.bold,
                                        fontSize: Dimens.fontSize_16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimens.height_3,
                                    ),
                                    Text(
                                      widget.doctor.speciality,
                                      style: TextStyle(
                                          fontFamily: Fonts.semiBold,
                                          fontSize: Dimens.fontSize_12,
                                          color: gray),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      height: Dimens.height_10,
                                    )),
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
                                          widget.doctor.location,
                                          style: TextStyle(
                                            fontFamily: Fonts.medium,
                                            color: gray,
                                            fontSize: Dimens.fontSize_12,
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
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimens.padding_20),
                        child: const Divider(
                          color: inactiveColor,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimens.padding_20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            infoTile(
                                title: Constants.patients,
                                icon: Images.patients,
                                value: widget.doctor.patientsServed.toString()),
                            infoTile(
                                title: Constants.yearsExp,
                                icon: Images.doctor,
                                value:
                                    widget.doctor.yearsOfExperience.toString()),
                            infoTile(
                                title: Constants.rating,
                                icon: Images.star,
                                value: widget.doctor.rating.toString()),
                            infoTile(
                                title: Constants.review,
                                icon: Images.message,
                                value: widget.doctor.numberOfReviews.toString(),
                                isPlus: false),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimens.height_40,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.padding_20),
                          child: Text(
                            Constants.bookAppointment.toUpperCase(),
                            style: const TextStyle(
                              color: gray,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.height_20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.padding_20),
                          child: Text(
                            Constants.day,
                            style: TextStyle(
                                color: black,
                                fontFamily: Fonts.bold,
                                fontSize: Dimens.fontSize_16),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.height_10,
                      ),
                      SizedBox(
                        height: Dimens.height_50,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.padding_20),
                          itemBuilder: (context, index) {
                            return InkWell(
                              borderRadius:
                                  BorderRadius.circular(Dimens.radius_60),
                              onTap: () {
                                setState(() {
                                  selectedDayIndex = index;
                                  selectedTimeIndex = 0;
                                });
                              },
                              child: Container(
                                height: Dimens.height_50,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.padding_15),
                                decoration: BoxDecoration(
                                    color: selectedDayIndex == index
                                        ? primaryColor
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: selectedDayIndex == index
                                            ? primaryColor
                                            : inactiveColor),
                                    borderRadius: BorderRadius.circular(
                                        Dimens.radius_60)),
                                child: Row(
                                  children: [
                                    Text(
                                      doctorStore.getDateFromList(
                                          widget.doctor, index),
                                      style: TextStyle(
                                        fontFamily: Fonts.semiBold,
                                        color: selectedDayIndex == index
                                            ? white
                                            : black,
                                        fontSize: Dimens.fontSize_12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: Dimens.width_10,
                            );
                          },
                          itemCount: widget.doctor.availability.length,
                        ),
                      ),
                      SizedBox(
                        height: Dimens.height_20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.padding_20),
                          child: Text(
                            Constants.time,
                            style: TextStyle(
                                color: black,
                                fontFamily: Fonts.bold,
                                fontSize: Dimens.fontSize_16),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.height_10,
                      ),
                      SizedBox(
                        height: Dimens.height_50,
                        child: timeList.isEmpty
                            ? const Center(
                                child: Text(Constants.noSlots),
                              )
                            : ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.padding_20),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.radius_60),
                                    onTap: () {
                                      setState(() {
                                        selectedTimeIndex = index;
                                      });
                                    },
                                    child: Container(
                                      height: Dimens.height_50,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimens.padding_15),
                                      decoration: BoxDecoration(
                                          color: selectedTimeIndex == index
                                              ? primaryColor
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: selectedTimeIndex == index
                                                  ? primaryColor
                                                  : inactiveColor),
                                          borderRadius: BorderRadius.circular(
                                              Dimens.radius_60)),
                                      child: Row(
                                        children: [
                                          Text(
                                            timeList[index],
                                            style: TextStyle(
                                              fontFamily: Fonts.semiBold,
                                              color: selectedTimeIndex == index
                                                  ? white
                                                  : black,
                                              fontSize: Dimens.fontSize_12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: Dimens.width_10,
                                  );
                                },
                                itemCount: timeList.length,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimens.padding_20),
              decoration: BoxDecoration(
                border: Border.all(color: inactiveColor),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimens.radius_10),
                  topRight: Radius.circular(Dimens.radius_10),
                ),
              ),
              child: AppButton(
                label: Constants.makeAppointment,
                onPressed: () {
                  if(timeList.isEmpty){
                    AlertSnackBar.error(Constants.noSlotsAvailable);
                  }else{
                    NavigationService.navigateTo(Routes.selectPackage,
                        arguments: SelectPackageArgs(doctorStore.getDateFromList(
                            widget.doctor, selectedDayIndex),timeList[selectedTimeIndex],widget.doctor));
                  }
                },
              ),
            )
          ],
        );
      }),
    );
  }

  infoTile(
      {required String icon,
      required String title,
      required String value,
      bool isPlus = true}) {
    return Column(
      children: [
        Container(
          height: Dimens.height_50,
          width: Dimens.width_50,
          padding: EdgeInsets.all(Dimens.padding_14),
          decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1), shape: BoxShape.circle),
          child: SvgPicture.asset(
            icon,
            color: primaryColor,
          ),
        ),
        SizedBox(
          height: Dimens.height_10,
        ),
        Text(
          isPlus ? "$value+" : value,
          style: TextStyle(
              color: primaryColor,
              fontSize: Dimens.fontSize_18,
              fontFamily: Fonts.bold),
        ),
        Text(
          title,
          style: TextStyle(
              color: gray,
              fontSize: Dimens.fontSize_12,
              fontFamily: Fonts.medium),
        ),
      ],
    );
  }
}
