import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/helper/colors.dart';
import 'package:flutter_doctor_appointment/helper/dimens.dart';
import 'package:flutter_doctor_appointment/helper/navigation.dart';
import 'package:flutter_doctor_appointment/helper/routes.dart';
import 'package:flutter_doctor_appointment/helper/strings.dart';
import 'package:flutter_doctor_appointment/model/doctor.dart';
import 'package:flutter_doctor_appointment/provider/doctor_provider.dart';
import 'package:flutter_doctor_appointment/widgets/app_bar.dart';
import 'package:flutter_doctor_appointment/widgets/app_button.dart';
import 'package:flutter_doctor_appointment/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'review_summary.dart';

class SelectPackageArgs {
  String day;
  String time;
  Doctor doctor;

  SelectPackageArgs(this.day, this.time, this.doctor);
}

class SelectPackageScreen extends StatefulWidget {
  SelectPackageArgs args;

  SelectPackageScreen(this.args);

  @override
  State<SelectPackageScreen> createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var doctorStore = getDoctorStore(context);
      await doctorStore.appointmentOptions();
      setState(() {
        selectedType = doctorStore.appointmentOption!.duration.first;
      });
    });
  }

  String? selectedType;

  int selectedPackageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DoctorProvider>(builder: (context, doctorStore, snapshot) {
        return Stack(
          children: [
            Column(
              children: [
                const BackAppBar(
                  label: Constants.selectPackage,
                ),
                Expanded(
                  child: doctorStore.appointmentOption == null &&
                          !doctorStore.isLoading
                      ? const Center(
                          child: Text(Constants.noPackage),
                        )
                      : doctorStore.appointmentOption == null
                          ? const SizedBox()
                          : SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimens.padding_10,
                                    horizontal: Dimens.padding_20),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        Constants.selectDuration,
                                        style: TextStyle(
                                            color: black,
                                            fontFamily: Fonts.bold,
                                            fontSize: Dimens.fontSize_16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimens.height_10,
                                    ),
                                    Container(
                                      height: Dimens.height_50,
                                      padding: EdgeInsets.only(
                                          left: Dimens.padding_10,
                                          right: Dimens.padding_5),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimens.radius_10),
                                          border:
                                              Border.all(color: inactiveColor)),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            Images.clock,
                                            color: primaryColor,
                                          ),
                                          SizedBox(
                                            width: Dimens.width_10,
                                          ),
                                          Expanded(
                                            child: DropdownButton(
                                              underline: const SizedBox(),
                                              isExpanded: true,
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: Dimens.height_30,
                                                color: primaryColor,
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedType =
                                                      value as String;
                                                });
                                              },
                                              items: doctorStore
                                                  .appointmentOption!.duration
                                                  .map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value.toString(),
                                                    style: TextStyle(
                                                        color: black,
                                                        fontSize:
                                                            Dimens.fontSize_16,
                                                        fontFamily: Fonts.bold),
                                                  ),
                                                );
                                              }).toList(),
                                              value: selectedType,
                                              style: TextStyle(
                                                  fontSize: Dimens.fontSize_16,
                                                  fontFamily: Fonts.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimens.height_30,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        Constants.selectPackage,
                                        style: TextStyle(
                                            color: black,
                                            fontFamily: Fonts.bold,
                                            fontSize: Dimens.fontSize_16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimens.height_10,
                                    ),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedPackageIndex = index;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                Dimens.padding_10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: inactiveColor),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimens.radius_10),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: Dimens.height_50,
                                                  width: Dimens.width_50,
                                                  padding: EdgeInsets.all(
                                                      Dimens.padding_12),
                                                  decoration: BoxDecoration(
                                                      color: primaryColor
                                                          .withOpacity(0.1),
                                                      shape: BoxShape.circle),
                                                  child: SvgPicture.asset(
                                                    doctorStore
                                                        .packageList[index]
                                                        .icon,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimens.width_5,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      doctorStore
                                                          .packageList[index]
                                                          .title,
                                                      style: TextStyle(
                                                          color: black,
                                                          fontSize: Dimens
                                                              .fontSize_15,
                                                          fontFamily:
                                                              Fonts.bold),
                                                    ),
                                                    SizedBox(
                                                      height: Dimens.height_5,
                                                    ),
                                                    Text(
                                                      doctorStore
                                                          .packageList[index]
                                                          .content,
                                                      style: TextStyle(
                                                          color: gray,
                                                          fontSize: Dimens
                                                              .fontSize_11,
                                                          fontFamily:
                                                              Fonts.medium),
                                                    ),
                                                  ],
                                                ),
                                                const Expanded(
                                                    child: SizedBox()),
                                                Container(
                                                  width: Dimens.width_25,
                                                  height: Dimens.height_25,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: selectedPackageIndex ==
                                                                  index
                                                              ? primaryColor
                                                              : inactiveColor)),
                                                  child: Container(
                                                    margin: EdgeInsets.all(
                                                        Dimens.padding_5),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            selectedPackageIndex ==
                                                                    index
                                                                ? primaryColor
                                                                : Colors
                                                                    .transparent,
                                                        shape: BoxShape.circle),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: Dimens.height_20,
                                        );
                                      },
                                      itemCount: doctorStore.packageList.length,
                                    )
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
                    label: Constants.next,
                    onPressed: () {
                      NavigationService.navigateTo(Routes.reviewSummary,
                          arguments: ReviewSummaryArgs(
                              widget.args,
                              selectedType!,
                              doctorStore.packageList[selectedPackageIndex]));
                    },
                  ),
                )
              ],
            ),
            LoadingWithBackground(doctorStore.isLoading)
          ],
        );
      }),
    );
  }
}
