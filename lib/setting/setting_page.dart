import 'package:flutter/material.dart';
import 'package:mb_fe/authentication/auth_page.dart';
import 'package:mb_fe/setting/provider.dart';
import 'package:mb_fe/changepass/change_password.dart';
import 'package:mb_fe/appbar/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:mb_fe/profile/profile.dart';
import 'package:mb_fe/profile/provider.dart';

class settingPage extends StatefulWidget {
  const settingPage({super.key});

  @override
  State<settingPage> createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  @override
  Widget build(BuildContext context) {
    final prov_setting = Provider.of<providerSetting>(context);
    final profile = Provider.of<ProfileProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final messenger = ScaffoldMessenger.of(context);
      if (prov_setting.showBanner) {
        messenger.showMaterialBanner(
          MaterialBanner(
            content: Text(
              prov_setting.message,
              style: TextStyle(fontFamily: 'OpenSans', fontSize: 18),
            ),
            backgroundColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[200],
            actions: [
              TextButton(
                onPressed: () {
                  prov_setting.hidingBanner();
                  messenger.hideCurrentMaterialBanner();
                },
                child: Text('DISMISS'),
              ),
            ],
          ),
        );

        Future.delayed(Duration(seconds: 3), () {
          prov_setting.hidingBanner();
          messenger.hideCurrentMaterialBanner();
        });
      } else {
        messenger.hideCurrentMaterialBanner();
      }
    });

    return Scaffold(
      appBar: CustomAppBar(title: 'Setting', showMenu: false),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.green,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage:
                                  profile.profileImage != null
                                      ? FileImage(profile.profileImage!)
                                      : const AssetImage(
                                            'lib/assets/images/user.png',
                                          )
                                          as ImageProvider,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            profile.name.isNotEmpty
                                ? profile.name
                                : 'Nama belum diatur',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          Text(
                            "Member since 2020",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.grey[800]
                                      : Colors.green,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white54
                            : Colors.grey,
                    thickness: 1,
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.notifications),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Notifications",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                    Text(
                                      "Enable notifications",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Switch(
                              value: prov_setting.notificationEnabled,
                              onChanged: (val) {
                                prov_setting.toggleNotification(val);
                              },
                              activeColor:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.green,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.white12,
                            ),
                          ],
                        ),

                        // Show volume slider only if enabled
                        if (prov_setting.notificationEnabled)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 40.0,
                              top: 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Notification Volume",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'OpenSans',
                                    color:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white70
                                            : Colors.grey[700],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      _getVolumeIcon(
                                        prov_setting.notificationVolume,
                                      ),
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Slider(
                                        value: prov_setting.notificationVolume,
                                        min: 0,
                                        max: 100,
                                        divisions: 10,
                                        label:
                                            '${prov_setting.notificationVolume.round()}%',
                                        onChanged:
                                            prov_setting.setNotificationVolume,
                                        activeColor:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        '${prov_setting.notificationVolume.round()}%',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  Divider(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white54
                            : Colors.grey,
                    thickness: 1,
                    height: 10,
                  ),

                  // Dark Mode
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.nightlight_round),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dark Mode",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                Text(
                                  "Enable Dark Mode",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Switch(
                          value: prov_setting.enableDarkMode,
                          onChanged: (val) {
                            prov_setting.setBrightness(val);
                          },
                          activeColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.green,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.white12,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white54
                            : Colors.grey,
                    thickness: 1,
                    height: 10,
                  ),

                  // Location
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_city),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Location",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                Text(
                                  "Enable Location",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Switch(
                          value: prov_setting.enableLocation,
                          onChanged: (value) {
                            prov_setting.setLocation(value);
                          },
                          activeColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.green,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.white12,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white54
                            : Colors.grey,
                    thickness: 1,
                    height: 5,
                  ),

                  // Check for Updates
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.update),
                      title: Text(
                        "Check for Updates",
                        style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                      ),
                      subtitle: Text(
                        "Check if the app is up-to-date or not",
                        style: TextStyle(fontSize: 14, fontFamily: 'OpenSans'),
                      ),
                      trailing: Icon(
                        Icons.update,
                        size: 40,
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white60
                                : Colors.green,
                      ),
                      onTap: () {
                        prov_setting.showingBanner();
                      },
                    ),
                  ),
                  Divider(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white60
                            : Colors.grey,
                    thickness: 1,
                    height: 5,
                  ),

                  // Change Password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ListTile(
                      leading: Icon(Icons.lock_reset),
                      title: Text(
                        "Change Password",
                        style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        size: 40,
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white54
                                : Colors.green,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePassword(),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white54
                            : Colors.grey,
                    thickness: 1,
                    height: 8,
                  ),
                ],
              ),

              // Logout Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => loginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Log out',
                  style: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to get volume icon based on volume level
  IconData _getVolumeIcon(double volume) {
    if (volume == 0) return Icons.volume_off;
    return volume < 50 ? Icons.volume_down : Icons.volume_up;
  }
}
