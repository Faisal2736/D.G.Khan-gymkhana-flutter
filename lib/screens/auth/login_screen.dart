import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../extras/colors.dart';
import '../../extras/fucntions.dart';
import '../../providers/login_screen_provider.dart';
import '../../widgets/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var mId = TextEditingController();
  var num = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '##-######-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var maskFormatterNum = MaskTextInputFormatter(
      mask: '###-#######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => LoginScreenProvider(),
        child: Consumer<LoginScreenProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.getHeight(50.h),
                    Center(
                      child: Utils.getLogo(),
                    ),
                    Text(
                      "Welcome",
                      style: TextStyle(
                          color: CColors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    Utils.getHeight(8.h),
                    Text(
                      "Please enter your login details",
                      style: TextStyle(
                        color: CColors.lightylw,
                        fontSize: 16,
                      ),
                    ),
                    Utils.getHeight(15.h),
                    Text(
                      "Member id:",
                      style: TextStyle(
                        color: CColors.blue,
                        fontSize: 16,
                      ),
                    ),
                    Utils.getHeight(10.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      color: Colors.black12.withOpacity(.05),
                      child: TextField(
                        controller: mId,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatter],
                        decoration: InputDecoration(
                          icon: Image(
                            image: const AssetImage(
                                "assets/icons/person_icon.png"),
                            height: 40.h,
                            width: 30.w,
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 0,
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          hintText: '01-xxxxxx-xx',
                        ),
                      ),
                    ),
                    Utils.getHeight(10.h),
                    Text(
                      "Phone:",
                      style: TextStyle(
                        color: CColors.blue,
                        fontSize: 16,
                      ),
                    ),
                    Utils.getHeight(5.h),
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildCountryPickerDropdown(
                              hasSelectedItemBuilder: true, context: context),
                          //ListTile(title: _buildCountryPickerDropdown(longerText: true)),
                        ],
                      ),
                    ),
                    Utils.getHeight(50.h),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          if (mId.text.trim().length < 10) {
                            Functions.showSnackBar(
                                context, "Please enter a valid member id");
                            return;
                          }
                          if (mId.text.trim().length < 11) {
                            Functions.showSnackBar(
                                context, "Please enter a valid phone number");
                            return;
                          }
                          // Get.to(const OtpScreen());
                          provider.sendOtp(
                              memberId: maskFormatter.maskText(mId.text.trim()),
                              mblNumber: num.text.trim().replaceFirst("-", ""),
                              context: context);
                        },
                        child: Container(
                          height: 50.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            color: CColors.blue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  buildCountryPickerDropdown(
      {bool filtered = false,
      required BuildContext context,
      bool sortedByIsoCode = false,
      bool hasPriorityList = false,
      bool hasSelectedItemBuilder = false}) {
    double dropdownButtonWidth = MediaQuery.of(context).size.width * 0.4;
    double dropdownItemWidth = dropdownButtonWidth - 30;
    double dropdownSelectedItemWidth = dropdownButtonWidth - 30;
    return Container(
      color: Colors.black12.withOpacity(.05),
      child: Row(
        children: <Widget>[
          CountryPickerDropdown(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            itemHeight: null,
            isDense: false,
            selectedItemBuilder: hasSelectedItemBuilder == true
                ? (Country country) => _buildDropdownSelectedItemBuilder(
                    country, dropdownSelectedItemWidth)
                : null,
            itemBuilder: (Country country) => hasSelectedItemBuilder == true
                ? _buildDropdownItemWithLongText(country, dropdownItemWidth)
                : _buildDropdownItem(country, dropdownItemWidth),
            initialValue: 'PK',
            itemFilter: filtered
                ? (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode)
                : null,
            priorityList: hasPriorityList
                ? [
                    CountryPickerUtils.getCountryByIsoCode('GB'),
                    CountryPickerUtils.getCountryByIsoCode('CN'),
                  ]
                : null,
            sortComparator: sortedByIsoCode
                ? (Country a, Country b) => a.isoCode.compareTo(b.isoCode)
                : null,
            onValuePicked: (Country country) {
              print("${country.name}");
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Container(
              height: 40,
              color: Colors.black,
              width: 1,
            ),
          ),
          Expanded(
            child: TextField(
              inputFormatters: [maskFormatterNum],
              controller: num,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: " 3xx-xxxxxxx",
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              keyboardType: TextInputType.number,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDropdownSelectedItemBuilder(
          Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                  child: Text(
                '${country.isoCode} +${country.phoneCode}',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
      );

  Widget _buildDropdownItemWithLongText(
          Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(child: Text("${country.name}")),
            ],
          ),
        ),
      );

  Widget _buildDropdownItem(Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(child: Text("+${country.phoneCode}(${country.isoCode})")),
          ],
        ),
      );
}
