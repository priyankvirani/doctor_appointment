import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/helper/colors.dart';
import 'package:flutter_doctor_appointment/helper/dimens.dart';
import 'package:flutter_doctor_appointment/helper/navigation.dart';
import 'package:flutter_doctor_appointment/helper/routes.dart';
import 'package:flutter_doctor_appointment/helper/strings.dart';
import 'package:flutter_doctor_appointment/provider/doctor_provider.dart';
import 'package:flutter_doctor_appointment/screens/main_screen.dart';
import 'package:flutter_doctor_appointment/widgets/app_bar.dart';
import 'package:flutter_doctor_appointment/widgets/app_button.dart';
import 'package:flutter_doctor_appointment/widgets/loading.dart';
import 'package:flutter_doctor_appointment/widgets/separator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingConfirmScreen extends StatefulWidget {
  @override
  State<BookingConfirmScreen> createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
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
                  label: Constants.confirmation,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimens.padding_10,
                          horizontal: Dimens.padding_20),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            Images.check,
                            width: Dimens.width_120,
                            height: Dimens.height_120,
                            color: primaryColor,
                          ),
                          SizedBox(
                            height: Dimens.height_10,
                          ),
                          Text(
                            Constants.appointmentConfirmed,
                            style: TextStyle(
                                color: black,
                                fontSize: Dimens.fontSize_20,
                                fontFamily: Fonts.bold),
                          ),
                          SizedBox(
                            height: Dimens.height_20,
                          ),
                          Text(
                            Constants.successWith,
                            style: TextStyle(
                                color: gray,
                                fontSize: Dimens.fontSize_12,
                                fontFamily: Fonts.medium),
                          ),
                          SizedBox(
                            height: Dimens.height_5,
                          ),
                          Text(
                            doctorStore.confirmation!.doctorName,
                            style: TextStyle(
                                color: black,
                                fontSize: Dimens.fontSize_16,
                                fontFamily: Fonts.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimens.padding_30),
                            child: const MySeparator(),
                          ),
                          imageTile(image: Images.user, title: "Esther Howard"),
                          SizedBox(
                            height: Dimens.height_20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: imageTile(
                                      image: Images.date,
                                      title: DateFormat('dd MMM, yyyy').format(
                                          doctorStore
                                              .confirmation!.appointmentDate))),
                              Expanded(
                                  child: imageTile(
                                      image: Images.clock,
                                      title: doctorStore
                                          .confirmation!.appointmentTime)),
                            ],
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
                  child: Column(
                    children: [
                      AppButton(
                        label: Constants.viewAppointment,
                        onPressed: () {
                          NavigationService.navigateTo(Routes.myBooking);
                        },
                      ),
                      SizedBox(height: Dimens.height_10,),
                      AppButton(
                        backgroundColor: Colors.transparent,
                        borderColor: Colors.transparent,
                        label: Constants.bookAnother,
                        textSize: Dimens.fontSize_14,
                        textColor: primaryColor,
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              MainScreen()), (Route<dynamic> route) => false);
                        },
                      ),
                    ],
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

  imageTile({required String image, required String title}) {
    return Row(
      children: [
        SvgPicture.asset(
          image,
          color: primaryColor,
        ),
        SizedBox(
          width: Dimens.width_10,
        ),
        Text(
          title,
          style: TextStyle(
              color: black,
              fontSize: Dimens.fontSize_14,
              fontFamily: Fonts.bold),
        ),
      ],
    );
  }
}
