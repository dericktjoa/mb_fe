import 'package:flutter/material.dart';
import 'package:mb_fe/setting/setting_page.dart';
import 'package:mb_fe/faq/faq_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenu;
  final Widget? action; // Tambahan

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showMenu = true,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF333739)
              : const Color(0xFF60B28C),
      title: Text(title),
      centerTitle: true,
      actions: [
        if (action != null) action!, // Tambahkan jika disediakan

        if (showMenu)
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'setting':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const settingPage()),
                  );
                  break;
                case 'faq':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FaqPage()),
                  );
                  break;
              }
            },
            itemBuilder:
                (BuildContext context) => const [
                  PopupMenuItem(value: 'setting', child: Text('Settings')),
                  PopupMenuItem(value: 'faq', child: Text('FAQ')),
                ],
            icon: const Icon(Icons.more_vert),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
