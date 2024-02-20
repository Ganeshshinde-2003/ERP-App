import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectWidget extends StatelessWidget {
  final double deviceWidth;
  final double deviceHeight;
  final bool isLoading;

  const ShimmerEffectWidget({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: deviceWidth,
        height: deviceHeight * 0.18,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/dashboard-abstract1.png'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Loading',
                            style: AppTextStyles.buttonText,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Data Loading....',
                              style: AppTextStyles.buttonText.copyWith(
                                color: Colors.black,
                                fontSize: 21,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Actual Data',
                          style: AppTextStyles.buttonText,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            'Actual Data',
                            style: AppTextStyles.buttonText.copyWith(
                              color: Colors.black,
                              fontSize: 21,
                            ),
                          ),
                        )
                      ],
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  isLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Updated on ',
                                    style: AppTextStyles.buttonText.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Loading..',
                                    style: AppTextStyles.buttonText.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Loading..',
                                style: AppTextStyles.buttonText.copyWith(
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Updated on ',
                                  style: AppTextStyles.buttonText.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Actual Data',
                                  style: AppTextStyles.buttonText.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Actual Data',
                              style: AppTextStyles.buttonText.copyWith(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
