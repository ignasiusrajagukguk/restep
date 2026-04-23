import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restep/common/constants/collors.dart';
import 'package:restep/common/data/local_storage.dart';
import 'package:restep/presentation/screens/login/index.dart';
import 'package:restep/presentation/screens/welcome_screen/index.dart';
import 'package:video_player/video_player.dart';

import '../../../config/app_asset.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.isLogout});

  final bool? isLogout;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late VideoPlayerController _controller;
  
  isRememberMe() async {
      Timer(
        const Duration(seconds: 8),
        () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => true,
        ),
      );
  }

  @override
  void initState() {
    isRememberMe();

    _controller = VideoPlayerController.asset(AnimationAsset.splash)
      ..initialize().then((_) {
        setState(() {});         
        _controller.play();
        _controller.setLooping(false);

        _controller.addListener(() {
          if (_controller.value.position >= _controller.value.duration) {
            isRememberMe();
          }
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.green,
        body: _controller.value.isInitialized
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
