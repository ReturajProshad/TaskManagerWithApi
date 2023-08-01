import 'package:flutter/material.dart';
import 'package:todo/ui/screens/Profile_details_screen.dart';

import '../../data/models/auth_utility.dart';
import '../auth/login_screen.dart';

class UserProfileBanner extends StatefulWidget {
  final VoidCallback onRefresh;

  const UserProfileBanner({
    required this.onRefresh,
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      tileColor: Colors.green,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          AuthUtility.userInfo.data?.photo ?? '',
        ),
        onBackgroundImageError: (_, __) {
          const Icon(Icons.image);
        },
        radius: 15,
      ),
      title: Text(
        '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
      subtitle: Text(
        AuthUtility.userInfo.data?.email ?? 'Unknown',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // IconButton(
          //   onPressed: () {
          //     widget.onRefresh;
          //   },
          //   icon: Icon(Icons.refresh),
          // ),
          // SizedBox(width: 8),
          // Add the profile button here
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile_details',
                child: Text('Profile Details'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            onSelected: (value) async {
              if (value == 'profile_details') {
                if (mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const pDetails()),
                  );
                }
                // TODO: Implement showing profile details
              } else if (value == 'logout') {
                await AuthUtility.clearUserInfo();
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                }
              }
            },
            icon: const Icon(Icons.person_4_outlined),
          ),
        ],
      ),
    );
  }
}
