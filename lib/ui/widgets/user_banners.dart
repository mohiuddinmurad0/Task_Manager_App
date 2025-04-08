import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager_flutter/data/models/auth_utility.dart';
import 'package:task_manager_flutter/ui/screens/auth_screens/login_screen.dart';

AppBar userBanner(context, {VoidCallback? onTapped}) {
  return AppBar(
    // centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(FontAwesomeIcons.powerOff),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No")),
                    TextButton(
                        onPressed: () {
                          AuthUtility.clearUserInfo();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (route) => false);
                        },
                        child: const Text("Yes")),
                  ],
                );
              });
        },
      ),
    ],
    title: Center(
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: GestureDetector(
            onTap: onTapped,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Image.memory(
                    showBase64Image(AuthUtility.userInfo.data?.photo),
                    errorBuilder: (_, __, ___) {
                      return const Icon(Icons.person);
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AuthUtility.userInfo.data?.firstName ?? " "} ${AuthUtility.userInfo.data?.lastName}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 2),
                    Text(AuthUtility.userInfo.data?.email ?? "",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

showBase64Image(base64String) {
  UriData? data = Uri.parse(base64String).data;
  Uint8List myImage = data!.contentAsBytes();
  return myImage;
}
