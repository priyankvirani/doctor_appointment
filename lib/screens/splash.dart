import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/helper/colors.dart';
import 'package:flutter_doctor_appointment/helper/dimens.dart';
import 'package:flutter_doctor_appointment/helper/navigation.dart';
import 'package:flutter_doctor_appointment/helper/routes.dart';
import 'package:flutter_doctor_appointment/helper/strings.dart';
import 'package:flutter_doctor_appointment/provider/doctor_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initPackageInfo();
      getDoctorStore(context).doctors();
      Future.delayed(const Duration(seconds: 3)).then((value) async {
        NavigationService.navigateToReplacement(Routes.main);
      });
    });
  }

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              Images.doctor,
              color: primaryColor,
              width: Dimens.width_100,
              height: Dimens.height_100,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Dimens.dimen_30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Constants.copyright,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: Dimens.fontSize_12,
                        color: black,
                        fontFamily: Fonts.medium),
                  ),
                  Text(
                    'Version ${packageInfo.version}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: Dimens.fontSize_12,
                        color: black,
                        fontFamily: Fonts.medium),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



}
