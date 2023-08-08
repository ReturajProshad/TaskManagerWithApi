import 'package:flutter/material.dart';

import '../../data/models/auth_utility.dart';

class pDetails extends StatelessWidget {
  const pDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  AuthUtility.userInfo.data?.photo ?? '',
                ),
                onBackgroundImageError: (_, __) {
                  const Icon(Icons.image);
                },
                radius: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
                style: const TextStyle(
                    fontSize: 24, color: Color.fromARGB(255, 224, 12, 12)),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                AuthUtility.userInfo.data?.email ?? '',
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 224, 12, 12)),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                AuthUtility.userInfo.data?.mobile ?? '',
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 224, 12, 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
