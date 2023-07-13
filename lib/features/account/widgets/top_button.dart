import 'package:amazon_app/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class topbuttons extends StatefulWidget {
  const topbuttons({super.key});

  @override
  State<topbuttons> createState() => _topbuttonsState();
}

class _topbuttonsState extends State<topbuttons> {
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
              ontap: () {},
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
