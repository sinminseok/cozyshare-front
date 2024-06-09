import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_and_job/model/home/enums/HomeOption.dart';
import 'package:home_and_job/model/home/response/HomeInformationResponse.dart';

import '../../../constants/Colors.dart';
import '../../../constants/Fonts.dart';

class HomeOptionsWidget extends StatelessWidget {
  final HomeInformationResponse homeInformationResponse;

  HomeOptionsWidget(this.homeInformationResponse);

  @override
  Widget build(BuildContext context) {
    List<HomeOptionType> options = parseHomeOptionTypes(homeInformationResponse.options!);

    return Container(
      margin: EdgeInsets.only(bottom: 240.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.h, left: 20.w),
            child: Title2Text("Options", kTextBlackColor),
          ),
          options.length == 0?_buildEmpty():Container(
            width: 360.w,
            height: 200.h,
            margin: EdgeInsets.only(left: 10.w, top: 20.h),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 4.h),
              ),
              itemCount: options.length, // 아이템 수
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // 스크롤 비활성화
              itemBuilder: (context, index) {
                // 아이템 빌드
                return _buildOptionItem(options[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(){
    return Container(
      width: 340.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: kGrey200Color)
      ),
      margin: EdgeInsets.only(top: 10.h, left: 20.w
      ),
      child: Center(child: FRegularText("Not Options", kGrey400Color, 14)),
    );
  }

  Widget _buildOptionItem(HomeOptionType option) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 100.w,
      height: 50.h, // 높이 조정
      decoration: BoxDecoration(
        border: Border.all(color: kGrey300Color),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Icon(
              option.icon,
              color: kGrey700Color,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.h),
            child: FRegularText(option.text, kGrey700Color, 13),
          ),
        ],
      ),
    );
  }
}