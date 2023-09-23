import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/helper/dimens.dart';
import 'package:flutter_doctor_appointment/helper/strings.dart';

import '../helper/colors.dart';

class BackAppBar extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final Widget? trailing;
  final bool? isBack;
  final IconData icon;

  const BackAppBar(
      {Key? key,
      required this.label,
      this.onPressed,
      this.trailing,
      this.icon = Icons.keyboard_backspace_rounded,
      this.isBack = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      top: true,
      right: false,
      bottom: false,
      child: Padding(
        padding: EdgeInsets.all(Dimens.padding_20),
        child: SizedBox(
          height: Dimens.height_40,
          child: Stack(
            children: [
              if (isBack!)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: onPressed ??
                        () {
                          Navigator.pop(context);
                        },
                    child: Container(
                      height: Dimens.height_40,
                      width: Dimens.height_40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: inactiveColor)),
                      child: Icon(icon),
                    ),
                  ),
                ),
              Center(
                child: Text(
                  label,
                  style: TextStyle(
                      color: black,
                      fontFamily: Fonts.bold,
                      fontSize: Dimens.fontSize_16),
                ),
              ),
              trailing == null
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: trailing!,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
