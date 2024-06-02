

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_and_job/account/sign-up/view/SignupView.dart';
import 'package:home_and_job/constants/Colors.dart';
import 'package:home_and_job/constants/Fonts.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOauthIcons(),
        _buildSignupText(),
      ],
    );
  }
  
  Widget _buildOauthIcons(){
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.w),
            width: 55.w,
            height: 55.h,
            decoration: BoxDecoration(
                color: kGrey100Color,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),

          Container(
            width: 55.w,
            height: 55.h,
            decoration: BoxDecoration(
                color: kGrey100Color,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupText(){
    return InkWell(
      onTap: (){
        Get.to(() => SignupView());
      },
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: FRegularText("Don't have an account?", kGrey600Color, 12),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.w, right: 20.w),
              child: FBoldText("Sign up", kDarkBlue, 12),
            )
          ],
        ),
      ),
    );
  }
}
