import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ReddDrawer extends StatefulWidget {
  final isDarkMode;

  const ReddDrawer({super.key, required this.isDarkMode});

  static const sizedBoxHeight = SizedBox(
    height: 25,
  );

  @override
  State<ReddDrawer> createState() => _ReddDrawerState();
}

class _ReddDrawerState extends State<ReddDrawer> {
  // Common button style for all buttons in the drawer
  ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      foregroundColor: widget.isDarkMode ? Colors.white : Colors.black,
      backgroundColor: const Color.fromARGB(255, 10, 6, 11),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      fixedSize: const Size(60, 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Contact Developer',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          ReddDrawer.sizedBoxHeight,
          ElevatedButton(
            style: buttonStyle(),
            child: const Icon(Icons.phone, size: 20),
            onPressed: () {
              launchUrl(Uri.parse('tel:+263788793302'),
                  mode: LaunchMode.externalApplication);
            },
          ),
          ReddDrawer.sizedBoxHeight,
          ElevatedButton(
            style: buttonStyle(),
            child: const Icon(Icons.email, size: 20),
            onPressed: () {
              launchUrl(
                  Uri.parse(
                      'mailto: luphahlablessingthamsanqa@gmail.com?subject=Business&body=Hey Redd Axe '),
                  mode: LaunchMode.externalApplication);
            },
          ),
          ReddDrawer.sizedBoxHeight,
          ElevatedButton(
            style: buttonStyle(),
            child: const FaIcon(FontAwesomeIcons.whatsapp,
                size: 20), // WhatsApp icon from FontAwesome
            onPressed: () {
              launchUrl(
                  Uri.parse('https://wa.me/263788793302?text=Hey REDD AXE'),
                  mode: LaunchMode.externalApplication);
            },
          ),
        ],
      ),
    );
  }
}
