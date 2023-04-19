import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymkhana_club/screens/profile/widgets/profile_widgets.dart';
import 'package:provider/provider.dart';

import '../../extras/colors.dart';
import '../../shared/providers/data_provider.dart';
import '../../widgets/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var fName = TextEditingController();
  var cnic = TextEditingController();
  var address = TextEditingController();
  var phone = TextEditingController();
  var name = TextEditingController();
  var dob = TextEditingController();
  var status = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        int length = 0;
        if( provider.userModel.suplimentary.isNotEmpty) {
          length = provider.userModel.suplimentary.length;
        }

        return Scaffold(
          //singleChildScrollView was used before list view
          body: ListView(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        //  Get.to(ProfilePage());
                      },
                      child: Utils.getProfileContainer(),
                    ),
                    Utils.getHeight(30.h),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      // padding: EdgeInsets.symmetric(horizontal: 17.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name",
                            style: TextStyle(
                              color: CColors.blue,
                              fontSize: 16,
                            ),
                          ),
                          Utils.getHeight(5.h),
                          getTextField(
                              provider.userModel.name ?? "Full Name", fName),
                          Utils.getHeight(30.h),
                          Text(
                            "CNIC",
                            style: TextStyle(
                              color: CColors.blue,
                              fontSize: 16,
                            ),
                          ),
                          Utils.getHeight(5.h),
                          getTextField(
                              provider.userModel.cnic ?? "9876-5456789-0",
                              fName),
                          Utils.getHeight(30.h),
                          Text(
                            "Address",
                            style: TextStyle(
                              color: CColors.blue,
                              fontSize: 16,
                            ),
                          ),
                          Utils.getHeight(5.h),
                          getTextField(
                              provider.userModel.address ??
                                  "Phase 1, DHA lahore",
                              fName),
                          Utils.getHeight(30.h),
                          Text(
                            "Phone",
                            style: TextStyle(
                              color: CColors.blue,
                              fontSize: 16,
                            ),
                          ),
                          Utils.getHeight(5.h),
                          getTextField(
                              provider.userModel.phoneNumber ?? "0987654312",
                              fName),
                          Utils.getHeight(15.h),
                          Text(
                            "Last Bill",
                            style: TextStyle(
                              color: CColors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Utils.getHeight(10.h),
                          ProfileWidgets.lastBill(),
                          Utils.getHeight(10.h),
                          Text(
                            "Food",
                            style: TextStyle(
                              color: CColors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          ProfileWidgets.foodBill(),
                          Utils.getHeight(15.h),

                        ],
                      ),
                    ),
                    if( length>0)

                      Text(
                        "Supplementary",
                        style: TextStyle(
                          color: CColors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),

                    if( length>0)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Utils.getHeight(15.h),
                              if(length >0)
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    color: CColors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                              Utils.getHeight(5.h),

                              getTextField(
                                  provider.userModel.suplimentary[0].sName, fName),
                              Utils.getHeight(15.h),
                              Text(
                                "DOB",
                                style: TextStyle(
                                  color: CColors.blue,
                                  fontSize: 16,
                                ),
                              ),
                              Utils.getHeight(5.h),
                              getTextField(
                                  provider.userModel.suplimentary[0].sdob, fName),
                              Utils.getHeight(15.h),
                              Text(
                                "Relationship Status",
                                style: TextStyle(
                                  color: CColors.blue,
                                  fontSize: 16,
                                ),
                              ),
                              Utils.getHeight(5.h),
                              getTextField(
                                  provider.userModel.suplimentary[0].sRelation,
                                  fName),
                              Utils.getHeight(10.h),
                            ],
                          ),
                        ),
                      ),
                    if( length>1)

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Utils.getHeight(15.h),
                              if(length >1)

                                Text(
                                  "Name",
                                  style: TextStyle(
                                    color: CColors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                              Utils.getHeight(5.h),
                              getTextField(
                                  provider.userModel.suplimentary[1].sName, fName),
                              Utils.getHeight(15.h),
                              Text(
                                "DOB",
                                style: TextStyle(
                                  color: CColors.blue,
                                  fontSize: 16,
                                ),
                              ),
                              Utils.getHeight(5.h),
                              getTextField(
                                  provider.userModel.suplimentary[1].sdob, fName),
                              Utils.getHeight(15.h),
                              Text(
                                "Relationship Status",
                                style: TextStyle(
                                  color: CColors.blue,
                                  fontSize: 16,
                                ),
                              ),
                              Utils.getHeight(5.h),
                              getTextField(
                                  provider.userModel.suplimentary[1].sRelation,
                                  fName),
                            ],
                          ),
                        ),
                      ),

                    if( length>2)

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Utils.getHeight(15.h),
                              if(length >2)

                                Text(
                                  "Name",
                                  style: TextStyle(
                                    color: CColors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                              Utils.getHeight(5.h),
                              getTextField(
                                  provider.userModel.suplimentary[2].sName, fName),
                              Utils.getHeight(15.h),
                              Text(
                                "DOB",
                                style: TextStyle(
                                  color: CColors.blue,
                                  fontSize: 16,
                                ),
                              ),
                              Utils.getHeight(5.h),
                              getTextField(
                                  provider.userModel.suplimentary[2].sdob, fName),
                              Utils.getHeight(15.h),
                              Text(
                                "Relationship Status",
                                style: TextStyle(
                                  color: CColors.blue,
                                  fontSize: 16,
                                ),
                              ),
                              Utils.getHeight(5.h),
                              getTextField(
                                  provider.userModel.suplimentary[2].sRelation,
                                  fName),
                            ],
                          ),
                        ),
                      ),
                    if( length>3)

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Utils.getHeight(15.h),
                              if(length >3)

                                Text(
                                  "Name",
                                  style: TextStyle(
                                    color: CColors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                              Utils.getHeight(5.h),
                              getTextField(
                                  provider.userModel.suplimentary[3].sName, fName),
                              Utils.getHeight(15.h),
                              Text(
                                "DOB",
                                style: TextStyle(
                                  color: CColors.blue,
                                  fontSize: 16,
                                ),
                              ),
                              Utils.getHeight(5.h),
                              getTextField(
                                  provider.userModel.suplimentary[3].sdob, fName),
                              Utils.getHeight(15.h),
                              Text(
                                "Relationship Status",
                                style: TextStyle(
                                  color: CColors.blue,
                                  fontSize: 16,
                                ),
                              ),
                              Utils.getHeight(5.h),
                              getTextField(
                                  provider.userModel.suplimentary[3].sRelation,
                                  fName),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          // appBar: Utils.appBarWidget(),
          // body: SingleChildScrollView(
          //   physics: const BouncingScrollPhysics(),
          //   child: SafeArea(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         InkWell(
          //           onTap: () {
          //             //  Get.to(ProfilePage());
          //           },
          //           child: Utils.getProfileContainer(),
          //         ),
          //         Utils.getHeight(30.h),
          //         Padding(
          //           padding: EdgeInsets.symmetric(horizontal: 17.h),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "Full Name",
          //                 style: TextStyle(
          //                   color: CColors.blue,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               Utils.getHeight(5.h),
          //               getTextField(
          //                   provider.userModel.name ?? "Full Name", fName),
          //               Utils.getHeight(30.h),
          //               Text(
          //                 "CNIC",
          //                 style: TextStyle(
          //                   color: CColors.blue,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               Utils.getHeight(5.h),
          //               getTextField(
          //                   provider.userModel.cnic ?? "9876-5456789-0", fName),
          //               Utils.getHeight(30.h),
          //               Text(
          //                 "Address",
          //                 style: TextStyle(
          //                   color: CColors.blue,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               Utils.getHeight(5.h),
          //               getTextField(
          //                   provider.userModel.address ?? "Phase 1, DHA lahore",
          //                   fName),
          //               Utils.getHeight(30.h),
          //               Text(
          //                 "Phone",
          //                 style: TextStyle(
          //                   color: CColors.blue,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               Utils.getHeight(5.h),
          //               getTextField(
          //                   provider.userModel.phoneNumber ?? "0987654312",
          //                   fName),
          //               Utils.getHeight(15.h),
          //               Text(
          //                 "Last Bill",
          //                 style: TextStyle(
          //                   color: CColors.blue,
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               Utils.getHeight(10.h),
          //               ProfileWidgets.lastBill(),
          //               Utils.getHeight(10.h),
          //               Text(
          //                 "Food",
          //                 style: TextStyle(
          //                   color: CColors.blue,
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               ProfileWidgets.foodBill(),
          //               Utils.getHeight(15.h),
          //               // if (provider.userModel.suplimentary[0].sName != null &&
          //               //     provider.userModel.suplimentary[0].sdob != null &&
          //               //     provider.userModel.suplimentary[0].sRelation !=
          //               //         null || (provider.userModel.suplimentary[1].sName != null &&
          //               //     provider.userModel.suplimentary[1].sdob != null &&
          //               //     provider.userModel.suplimentary[1].sRelation !=
          //               //         null ))
          //
          //                 Text(
          //                   "Supplementary",
          //                   style: TextStyle(
          //                     color: CColors.blue,
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 16,
          //                   ),
          //                 ),
          //                 Utils.getHeight(15.h),
          //                 Text(
          //                   "Name",
          //                   style: TextStyle(
          //                     color: CColors.blue,
          //                     fontSize: 16,
          //                   ),
          //                 ),
          //                 Utils.getHeight(5.h),
          //                 getTextField(
          //                     provider.userModel.suplimentary[0].sName, fName),
          //                 Utils.getHeight(15.h),
          //                 Text(
          //                   "DOB",
          //                   style: TextStyle(
          //                     color: CColors.blue,
          //                     fontSize: 16,
          //                   ),
          //                 ),
          //                 Utils.getHeight(5.h),
          //                 getTextField(
          //                     provider.userModel.suplimentary[0].sdob, fName),
          //                 Utils.getHeight(15.h),
          //                 Text(
          //                   "Relationship Status",
          //                   style: TextStyle(
          //                     color: CColors.blue,
          //                     fontSize: 16,
          //                   ),
          //                 ),
          //                 Utils.getHeight(5.h),
          //                 getTextField(
          //                     provider.userModel.suplimentary[0].sRelation,
          //                     fName),
          //               ],
          //
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),/////
        );
      },
    );
  }

  Container getTextField(String hint, TextEditingController con) {
    return Container(
      color: Colors.black12.withOpacity(.05),
      height: 50.h,
      child: TextField(
        controller: con,
        readOnly: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: hint,
        ),
      ),
    );
  }

  Expanded getIconBox(String img, String txt) {
    return Expanded(
      child: Container(
        height: 150.h,
        child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage(img),
                height: 30,
                color: CColors.blue,
                fit: BoxFit.fill,
              ),
              Text(
                txt,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: CColors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
