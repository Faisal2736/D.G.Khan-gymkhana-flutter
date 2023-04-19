import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_club/extras/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/providers/data_provider.dart';
import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      checkStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Timer? timer;

  checkStatus() async {
    try {
      await setUpRemoteConfig();
      await getData().timeout(Duration(seconds: 20));
    } catch (e) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false);
      return;
    }

    // timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
    //   if (provider.dataFetched) {
    //     timer.cancel();
    //     if (provider.model == null) {
    //       Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => const LoginScreen(),
    //           ),
    //           (route) => false);
    //     } else {
    //       Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => const Homepage(),
    //           ),
    //           (route) => false);
    //     }
    //   }
    // });
  }

  Future<void> setUpRemoteConfig() async {
    debugPrint("the url before is ${Constants.baseUrl} a");
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 60),
        minimumFetchInterval: Duration(seconds: 5),
      ),
    );
    await remoteConfig.fetchAndActivate();
    var url = remoteConfig.getString("dg");
    Constants.baseUrl = url;
    debugPrint("the url after is ${Constants.baseUrl} a");
  }

  Future<void> getData() async {
    final provider = context.read<DataProvider>();
    final prefs = await SharedPreferences.getInstance();
    var memberId = prefs.getString("memberId") ?? "";
    // if (kDebugMode) {
    //   memberId = "01-090020-00";
    //   await prefs.setString("memberId", memberId);
    // }
    if (memberId.isEmpty) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false);
      return;
    }
    await provider.getUserModel(context, memberId,
        showLoading: false, isLogin: false);
    if (provider.model == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }
}
