import 'package:amazon_app/features/account/services/accouunt_services.dart';
import 'package:amazon_app/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class topbuttons extends StatefulWidget {
  const topbuttons({super.key});

  @override
  State<topbuttons> createState() => _topbuttonsState();
}

class _topbuttonsState extends State<topbuttons> {
  accountservices account = accountservices();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            accountbutton(
              text: 'Your Orders',
              ontap: () {},
            ),
            accountbutton(
              text: 'Turn Seller',
              ontap: () {},
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            accountbutton(
              text: 'Log Out',
              ontap: () {
                account.logout(context);
                setState(() {});
              },
            ),
            accountbutton(
              text: 'Your Wish List',
              ontap: () {},
            )
          ],
        ),
      ],
    );
  }
}
