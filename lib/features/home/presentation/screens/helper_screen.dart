import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class HelperScreen extends StatefulWidget {
  const HelperScreen({super.key});

  @override
  State<HelperScreen> createState() => _HelperScreenState();
}

class _HelperScreenState extends State<HelperScreen> {
  final TextEditingController controller = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {
      "from": "bot",
      "text":
          "Hello! I'm your Travel Assistant. How can I help you today? You can ask about any tourist place in Egypt or our services!",
      "time": "12:34 PM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF9EE),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: EdgeInsets.all(15.w),
                    margin: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4.r,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        AppAsset(
                          assetName: Assets.chatbot,
                          width: 32.w,
                          height: 32.h,
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText("Tourist Assistant", style: font18w700),
                            SizedBox(height: 3.h),
                            AppText(
                              "Ask me anything ✈️",
                              style: font12w400.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: AppText(
                            "Online",
                            style: font12w500.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    padding: EdgeInsets.all(12.w),
                    width: double.infinity,
                    constraints: BoxConstraints(minHeight: 0.65.sh),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Column(
                      children: messages.map((msg) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 6.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppAsset(
                                assetName: Assets.chatbot,
                                width: 32.w,
                                height: 32.h,
                              ),
                              SizedBox(width: 6.w),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.all(12.w),
                                  constraints: BoxConstraints(maxWidth: 260.w),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        msg["text"],
                                        overflow: TextOverflow.visible,
                                        style: font14w400.copyWith(
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      AppText(
                                        msg["time"],
                                        style: font10w400.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 14.h,
                          horizontal: 16.w,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Icon(Icons.send, color: Colors.white, size: 22.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
