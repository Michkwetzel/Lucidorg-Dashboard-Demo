import 'package:flutter/widgets.dart';
import 'package:platform_front/components/dashboard/new_Home/homeSideBarBody.dart';
import 'package:platform_front/components/dashboard/new_Home/home_MV_body_new.dart';
import 'package:platform_front/config/constants.dart';

class NewHomeBody extends StatelessWidget {
  const NewHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SizedBox(
                width: 1008,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Home",
                      style: kH1TextStyle,
                    ),
                    Text(
                      'Assessment: Q1 2025',
                      style: kH5PoppinsLight,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 32,
            children: [
              HomeSideBarBody(),
              HomeMvBodyNew(),
            ],
          ),
        ],
      ),
    );
  }
}
