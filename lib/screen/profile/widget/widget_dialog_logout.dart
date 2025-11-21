import 'package:checking_system/screen/authentication/login_screen.dart';
import 'package:checking_system/screen/profile/widget/text_design.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';


class WidgetDialogLogout extends StatelessWidget {
  const WidgetDialogLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          width: MediaQuery.of(context).size.width - 10.0,
          bottom: 96,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 104.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffffffff)),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 51,
                    child:  Center(
                      child: DefaultTextStyle(
                        style: const TextStyle(),
                        child: TextDesign(
                          text: "Bạn có chắc chắn muốn đăng xuất không?",
                          size: 16.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                    width: MediaQuery.of(context).size.width,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xffE1E1E1)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Login_Screen(),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 51,
                      child: Center(
                        child: _wigetButonText(text: "Đăng xuất",color: AppColors.primary1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width - 10.0,
          bottom: 33,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 54.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffffffff)),
                child: Center(
                  child: _wigetButonText(
                      text: "Huỷ", color: AppColors.primary1),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _wigetButonText({required String text, Color? color}) {
    return DefaultTextStyle(
      style: const TextStyle(),
      child: TextDesign(
        size: 20.0,
        text: text,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.primary1,
      ),
    );
  }
}
