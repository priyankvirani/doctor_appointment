import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/helper/colors.dart';
import 'package:flutter_doctor_appointment/helper/dimens.dart';
import 'package:flutter_doctor_appointment/helper/navigation.dart';
import 'package:flutter_doctor_appointment/helper/routes.dart';
import 'package:flutter_doctor_appointment/helper/strings.dart';
import 'package:flutter_doctor_appointment/model/doctor.dart';
import 'package:flutter_doctor_appointment/model/package.dart';
import 'package:flutter_doctor_appointment/provider/doctor_provider.dart';
import 'package:flutter_doctor_appointment/widgets/app_bar.dart';
import 'package:flutter_doctor_appointment/widgets/app_button.dart';
import 'package:flutter_doctor_appointment/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'select_package.dart';

class ReviewSummaryArgs{
  SelectPackageArgs selectPackageArgs;
  String duration;
  Package package;

  ReviewSummaryArgs(this.selectPackageArgs, this.duration, this.package);
}

class ReviewSummaryScreen extends StatefulWidget {
  ReviewSummaryArgs args;

  ReviewSummaryScreen(this.args);

  @override
  State<ReviewSummaryScreen> createState() => _ReviewSummaryScreenState();
}

class _ReviewSummaryScreenState extends State<ReviewSummaryScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var doctorStore = getDoctorStore(context);


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
                  label: Constants.reviewSummary,
                ),
                Expanded(
                  child: doctorStore.appointmentOption == null &&
                          !doctorStore.isLoading
                      ? const Center(
                          child: Text(Constants.noPackage),
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimens.padding_10,
                                horizontal: Dimens.padding_20),
                            child: Column(
                              children: [
                                Row(
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
                                              imageUrl: widget.args.selectPackageArgs.doctor.image,
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
                                              widget.args.selectPackageArgs.doctor.doctorName,
                                              style: TextStyle(
                                                fontFamily: Fonts.bold,
                                                fontSize: Dimens.fontSize_16,
                                              ),
                                            ),
                                            SizedBox(
                                              height: Dimens.height_3,
                                            ),
                                            Text(
                                              widget.args.selectPackageArgs.doctor.speciality,
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
                                                  widget.args.selectPackageArgs.doctor.location,
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
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: Dimens.padding_20),
                                  child: const Divider(
                                    color: inactiveColor,
                                  ),
                                ),
                                textTile(
                                  title: Constants.dateTime,
                                  value: "${widget.args.selectPackageArgs.day} | ${widget.args.selectPackageArgs.time}"
                                ),
                                textTile(
                                    title: Constants.package,
                                    value: widget.args.package.title
                                ),
                                textTile(
                                    title: Constants.duration,
                                    value: widget.args.duration
                                ),
                                textTile(
                                    title: Constants.bookingFor,
                                    value: "Self"
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
                    label: Constants.confirm,
                    onPressed: () async {
                      await doctorStore.bookingConfirmation();
                      NavigationService.navigateTo(Routes.bookingConfirm,arguments: widget.args);
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

  textTile({required String title,required String value}){
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.padding_15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: gray,
                fontSize: Dimens.fontSize_13,
                fontFamily: Fonts.medium),
          ) ,
          Text(
            value,
            style: TextStyle(
                color: black,
                fontSize: Dimens.fontSize_14,
                fontFamily: Fonts.bold),
          )
        ],
      ),
    );
  }

}
