import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/helper/colors.dart';
import 'package:flutter_doctor_appointment/helper/dimens.dart';
import 'package:flutter_doctor_appointment/helper/navigation.dart';
import 'package:flutter_doctor_appointment/helper/routes.dart';
import 'package:flutter_doctor_appointment/helper/strings.dart';
import 'package:flutter_doctor_appointment/model/doctor.dart';
import 'package:flutter_doctor_appointment/provider/doctor_provider.dart';
import 'package:flutter_doctor_appointment/widgets/app_bar.dart';
import 'package:flutter_doctor_appointment/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      body: Consumer<DoctorProvider>(builder: (context, doctorStore, snapshot) {
        return Stack(
          children: [
            Column(
              children: [
                BackAppBar(
                  label: Constants.home,
                  icon: Icons.menu,
                  onPressed: () {},
                ),
                Expanded(
                    child: doctorStore.doctorList.isEmpty
                        ? const Center(
                            child: Text(Constants.noDataFound),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimens.padding_20),
                            itemBuilder: (context, index) {
                              Doctor doctor = doctorStore.doctorList[index];
                              return InkWell(
                                onTap: () {
                                  NavigationService.navigateTo(
                                      Routes.bookAppointment,
                                      arguments: doctor);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(Dimens.padding_15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: inactiveColor),
                                      borderRadius: BorderRadius.circular(
                                          Dimens.radius_10)),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            Dimens.radius_10),
                                        child: CachedNetworkImage(
                                          imageUrl: doctor.image,
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
                                                doctor.doctorName,
                                                style: TextStyle(
                                                  fontFamily: Fonts.bold,
                                                  fontSize: Dimens.fontSize_16,
                                                ),
                                              ),
                                              SizedBox(
                                                height: Dimens.height_3,
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
                                                    doctor.location,
                                                    style: TextStyle(
                                                      fontFamily: Fonts.medium,
                                                      color: gray,
                                                      fontSize:
                                                          Dimens.fontSize_12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                  child: SizedBox(
                                                height: Dimens.height_10,
                                              )),
                                              Text(
                                                doctor.speciality,
                                                style: TextStyle(
                                                  fontFamily: Fonts.semiBold,
                                                  fontSize: Dimens.fontSize_14,
                                                ),
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
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: Dimens.height_20,
                              );
                            },
                            itemCount: doctorStore.doctorList.length))
              ],
            ),
            LoadingWithBackground(doctorStore.isLoading)
          ],
        );
      }),
    );
  }
}
