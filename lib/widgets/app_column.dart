import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_test.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(children: [
          Wrap(
            children: List.generate(
                5,
                (index) => const Icon(
                      Icons.star,
                      color: AppColors.mainColor,
                    )),
          ),
          SizedBox(
            width: Dimensions.height10,
          ),
          SmallText(text: '4.5'),
          SizedBox(
            width: Dimensions.height10,
          ),
          SmallText(text: '1287 comm.'),
        ]),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                iconData: Icons.circle_sharp,
                text: 'Normal',
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(
                iconData: Icons.location_on,
                text: '1.7 km',
                iconColor: AppColors.mainColor),
            IconAndTextWidget(
                iconData: Icons.access_time_rounded,
                text: '32 min',
                iconColor: AppColors.iconColor2),
          ],
        ),
      ],
    );
  }
}
