import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_and_job/constants/Colors.dart';
import 'package:home_and_job/constants/Fonts.dart';
import 'package:home_and_job/model/deal/enums/DealState.dart';
import '../../../model/chat/response/DirectMessageDto.dart';
import '../../chat-detail-provider/widgets/ProviderDealFinishWidget.dart';
import '../controller/ChatGetterDetailController.dart';
import 'GetterDealDuringMessageWidget.dart';
import '../../chat-common/widgets/DealFinishWidget.dart';
import 'GetterDealStartMessageWidget.dart';

/**
 * 채팅 내용 뿌려주는 위젯
 */
class GetterMessageWidget extends StatelessWidget {
  final DirectMessageResponse directMessageResponse;
  final ChatGetterDetailController controller;

  GetterMessageWidget(this.directMessageResponse, this.controller);

  @override
  Widget build(BuildContext context) {
    bool isMe = directMessageResponse.senderId == controller.currentUser.id;

    return InkWell(
      onTap: () {
        print("isMe = " + isMe.toString());
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (!isMe)
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage("assets/images/test/man.png"),
                  ),
                SizedBox(width: 10),
                MessageBubble(
                  isMe: isMe,
                  text: directMessageResponse.message,
                  controller: controller,
                  directMessageResponse: directMessageResponse,
                ),
              ],
            ),
            MessageTime(isMe: isMe, time: directMessageResponse.formatTime()),
          ],
        ),
      ),
    );
  }
}

/**
 * 메시지 위젯
 */
class MessageBubble extends StatelessWidget {
  final ChatGetterDetailController controller;
  final DirectMessageResponse directMessageResponse;
  final bool isMe;
  final String? text;

  MessageBubble({
    required this.controller,
    required this.directMessageResponse,
    required this.text,
    required this.isMe,
  });


  @override
  Widget build(BuildContext context) {
    return directMessageResponse.isDeal != 0
        ? _buildDealMessage(context)
        : _buildTextMessage(context);
  }

  Widget _buildDealMessage(BuildContext context) {
    switch (directMessageResponse.isDeal) {
      case 1:
        return GetterDealStartMessageWidget(
            context, directMessageResponse.dealId!, controller);
      case 2:
        return GetterDealDuringMessageWidget(
            directMessageResponse.dealId!, controller);
      case 3:
        return DealFinishWidget(controller.getDealById(directMessageResponse.dealId!)!);
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildTextMessage(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      decoration: BoxDecoration(
        color: isMe ? kPrimaryColor : kLightBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(isMe ? 12 : 0),
          bottomRight: Radius.circular(isMe ? 0 : 12),
        ),
      ),
      child: Text(
        text ?? "",
        style: TextStyle(
          fontSize: 13,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w600,
          color: isMe ? Colors.white : Colors.grey[800],
        ),
      ),
    );
  }
}

class MessageTime extends StatelessWidget {
  final bool isMe;
  final String time;

  MessageTime({
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) SizedBox(width: 40.w),
          HintText2("${time}", kGrey500Color),
        ],
      ),
    );
  }
}
