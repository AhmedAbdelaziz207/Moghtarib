import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            children: [
              const Text(
                "Omar",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "سمسار",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.sp),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
           Expanded(
            child: ListView(
              children: const [
                BubbleSpecialThree(
                  text: 'اهلا',
                  color: Color(0xFFE8E8EE),
                  tail: true,
                  isSender: true,
                ),
                BubbleSpecialThree(
                  text: 'مرحب',
                  color: CupertinoColors.activeBlue,
                  textStyle: TextStyle(color: Colors.white),
                  tail: false,
                  isSender: false,
                ),
                BubbleSpecialThree(
                  text: 'اي الاخبار',
                  color: CupertinoColors.activeBlue,
                  textStyle: TextStyle(color: Colors.white),
                  tail: true,
                  isSender: false,
                ),
              ],
            ),
          ),
       MessageBar(
            onSend: (_) => print(_),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: InkWell(
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                    size: 24,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
