import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/small_test.dart';

class ExpandebleTextWidget extends StatefulWidget {
  final String text;

  const ExpandebleTextWidget({super.key, required this.text});

  @override
  State<ExpandebleTextWidget> createState() => _ExpandebleTextWidgetState();
}

class _ExpandebleTextWidgetState extends State<ExpandebleTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              height: 1.5,
              color: AppColors.paraColor,
              text: firstHalf,
              size: Dimensions.font16)
          : Column(
              children: [
                SmallText(
                  height: 1.5,
                  color: AppColors.paraColor,
                  size: Dimensions.font16,
                  text: hiddenText ? ('$firstHalf...') : firstHalf + secondHalf,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(children: [
                    SmallText(
                      text: 'Show more',
                      color: AppColors.mainColor,
                    ),
                    Icon(
                      hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      color: AppColors.mainColor,
                    )
                  ]),
                )
              ],
            ),
    );
  }
}