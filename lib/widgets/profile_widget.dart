import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymkhana_club/extras/constants.dart';
import 'package:gymkhana_club/widgets/utils.dart';
import 'package:provider/provider.dart';

import '../extras/colors.dart';
import '../shared/providers/data_provider.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        return Container(
          color: CColors.blue,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image(
                      image: provider.userModel.imagePath == null
                          ? const AssetImage("assets/images/logo.png")
                          : NetworkImage(
                          "${"http://182.180.172.240"}${provider.userModel.imagePath}")
                      as ImageProvider,
                      errorBuilder: (ctx, obj, stk) {
                        return Image.asset("assets/icons/person_icon.png");
                      },
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                    Utils.getWidth(10.w),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              // "${provider.userModel.name??"name"}\n03226006273\n02-34567564-09",
                              "${provider.userModel.name}",
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: CColors.lightylw,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  // "${provider.userModel.name??"name"}\n03226006273\n02-34567564-09",
                                  "${provider.userModel.phoneNumber ?? ""}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.6,
                                    color: CColors.lightylw,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Status",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Utils.getWidth(10.w),
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        color: getColor(provider),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            // Text(
                            //   "${provider.userModel.cnic ?? ""}",
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     height: 1.6,
                            //     color: CColors.lightylw,
                            //   ),
                            // ),
                            Text(
                              "${provider.memberId ?? ""}",
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: CColors.lightylw,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color getColor(DataProvider provider) {
    if (provider.userModel.status == true) {
      return Colors.lightGreenAccent;
    }
    return Colors.red;
  }
}
