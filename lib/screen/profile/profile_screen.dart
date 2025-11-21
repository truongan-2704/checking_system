import 'package:checking_system/screen/profile/widget/card_item.dart';
import 'package:checking_system/screen/profile/widget/text_design.dart';
import 'package:checking_system/screen/profile/widget/widget_dialog_logout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../themes/app_colors.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';
import 'widget/avater_circle.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ValueNotifier<bool> buttonClicked = ValueNotifier(false);


  @override
  void initState(){
    super.initState();
    addDemo();
  }

  @override
  void dispose() {
    super.dispose();
    removeDemo();
    buttonClicked.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: AvatarCircle(
                  withImage: 104,
                  heightImage: 104,
                  image: "assets/images/hinh1.jfif",
                ),
              ),
              const Text(
                "Nguyễn Văn An",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: _widgetListMenuItem(),
              ),
            ],
          ),
        ),
      );

  }

  //
  Widget _widgetListMenuItem() {
    return Column(
      children: [
        _widgetCardItem(
          press: onPressNavigateUpdateIntomation,
          widget: _widgetIntoCard(
            text: "Chỉnh sửa thông tin",
            icon: "assets/icons/change_info.svg",
          ),
        ),
        _widgetCardItem(
          press: (){},
          widget: _widgetIntoCardNotify(
            text: "Thông báo",
            icon: "assets/icons/notify.svg",
          ),
        ),
        _widgetCardItem(
          press: onPressNavigatePassword,
          widget: _widgetIntoCard(
            text: "Mật khẩu",
            icon: "assets/icons/lock.svg",
          ),
        ),
        _widgetCardItem(
          press: showLogoutDialog,
          widget: _widgetIntoCard(
            text: "Đăng xuất",
            icon: "assets/icons/logout.svg",
          ),
        ),
      ],
    );
  }

  Widget _widgetCardItem({
    required Function press,
    required Widget widget,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: CardItem(
        onPressed: () {
          press();
        },
        height: 54,
        widgetInCard: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 0, 16.0, 0),
          child: widget,
        ),
      ),
    );
  }

  Widget _widgetIntoCard({
    required String text,
    required String icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 40,
          child: SvgPicture.asset(icon, colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),),
        ),
        const SizedBox(width: 15),
        TextDesign(
          text: text,
          fontWeight: FontWeight.w400,
          size: 20.0,
          color: AppColors.black,
        ),
      ],
    );
  }

  Widget _widgetIntoCardNotify({
    required String text,
    required String icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _widgetIntoCard(text: text, icon: icon,),
        _widgetSwitchButton(),
      ],
    );
  }

  Widget _widgetSwitchButton(){
    return ValueListenableBuilder(
      valueListenable: buttonClicked,
      builder: (context, bool value, _) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SizedBox(
            width: 40,
            height: 25,
            child: CupertinoSwitch(
                value: value,
                activeColor:  Colors.blue,
                onChanged: (bool val) {
                  buttonClicked.value = !value;
                }),
          ),
        );
      },
    );
  }

  //
  Future<void> showLogoutDialog() async {
    return showDialog(
      barrierColor: const Color(0xffD9D9D9).withOpacity(0.6),
      context: context,
      builder: (BuildContext context) {
        return const WidgetDialogLogout();
      },
    );
  }

  void onPressNavigateUpdateIntomation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      ),
    );
  }

  void onPressNavigatePassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangePassScreen(),
      ),
    );
  }


  void fcDemo(){
    print(buttonClicked.value);
  }

  void addDemo(){
    buttonClicked.addListener(fcDemo);
  }

  void removeDemo(){
    buttonClicked.removeListener(fcDemo);
  }
}
