import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

LottieBuilder CsutomLottieAnimation() {
  return Lottie.asset(
    'assets/animation/Order History.json',
    width: 200,
    height: 200,
    fit: BoxFit.fill,
    repeat: true,
    reverse: false,
  );
}
