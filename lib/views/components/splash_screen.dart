import 'dart:async';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
          () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      },
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [black1, black2],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fillustrations%2Fmusic-app-icon-music-app-7477530%2F&psig=AOvVaw0vH1JA99t7hzrkb5CGyh4-&ust=1743150514732000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIjJkN_rqYwDFQAAAAAdAAAAABAK'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
