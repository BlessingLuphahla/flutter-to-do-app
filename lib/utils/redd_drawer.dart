import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReddDrawer extends StatelessWidget {
  ButtonStyle buttonStyle() {
    return ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
        foregroundColor: WidgetStateColor.resolveWith((_) {
          return Color.fromARGB(255, 255, 255, 255);
        }),
        backgroundColor: WidgetStateColor.resolveWith((_) {
          return Colors.purple;
        }));
  }

  static const sizedBoxHeight = SizedBox(
    height: 30,
  );

  const ReddDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              style: buttonStyle(),
              child: const Text('Call Me'),
              onPressed: () {
                launchUrl(Uri.parse('tel:+263788793302'),
                    mode: LaunchMode.externalApplication);
              }),
          sizedBoxHeight,
          ElevatedButton(
              style: buttonStyle(),
              child: const Text('Contact Me On Email'),
              onPressed: () {
                launchUrl(
                    Uri.parse(
                        'mailto: luphahlablessingthamsanqa@gmail.com?subject=Business&body=Hey Dynamic Digital Design can you'),
                    mode: LaunchMode.externalApplication);
              }),
          sizedBoxHeight,
          ElevatedButton(
              style: buttonStyle(),
              child: const Text('Connect With Me On Whatsapp'),
              onPressed: () {
                launchUrl(
                    Uri.parse('https://wa.me/263788793302?text=Hey REDD AXE'),
                    mode: LaunchMode.externalApplication);
              }),
          sizedBoxHeight,
          const Text(
            'contact the developer',
            style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          )
        ],
      ),
    );
  }
}
