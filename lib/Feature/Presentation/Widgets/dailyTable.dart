import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/Core/Network/apiConstance.dart';
import 'package:weather_application/Core/Utils/colors.dart';
import 'package:weather_application/Core/Utils/enums.dart';
import 'package:weather_application/Core/Utils/mediaQuery.dart';
import 'package:weather_application/Core/Utils/strings.dart';
import 'package:weather_application/Feature/Presentation/Management/weatherBloc.dart';
import 'package:weather_application/Feature/Presentation/Management/weatherState.dart';

class DailyTable extends StatelessWidget {
  const DailyTable({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (
        context,
        state,
      ) {
        switch (state.dailyRequestState) {
          case RequestState.loading:
            return const Center();
          case RequestState.loaded:
            return Padding(
              padding: const EdgeInsets.all(
                15.00,
              ),
              child: Container(
                margin: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.2,
                    color: AppColors.blueColor,
                  ),
                  borderRadius: BorderRadius.circular(
                    35,
                  ),
                ),
                child: Column(
                  children: [
                    for (final weather in state.dailyWeather)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.height20,
                          vertical: context.height10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    DateFormat(
                                              'MMMM d,EEEE',
                                            ).format(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                weather.date.toInt() * 1000,
                                                isUtc: false,
                                              ),
                                            ) ==
                                            DateFormat(
                                              'MMMM d,EEEE',
                                            ).format(
                                              DateTime.now(),
                                            )
                                        ? AppStrings.today
                                        : DateFormat.EEEE().format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              weather.date.toInt() * 1000,
                                              isUtc: false,
                                            ),
                                          ),
                                    style: TextStyle(
                                      fontSize: context.height20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.droplet,
                                        color: Colors.white70,
                                        size: context.height10,
                                      ),
                                      Text(
                                        '${(weather.humidity).round()}%',
                                        style: TextStyle(
                                          fontSize: context.height15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      SizedBox(
                                        width: context.height30,
                                      ),
                                      Image.network(
                                        ApiConstance.weatherIcon(
                                          weather.icon,
                                        ),
                                        height: context.height20,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        '${weather.tempMax.round()}°',
                                        style: TextStyle(
                                          fontSize: context.height15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        width: context.width10,
                                      ),
                                      Text(
                                        '${weather.tempMin.round()}°',
                                        style: TextStyle(
                                          fontSize: context.height15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          case RequestState.error:
            return Center(
              child: Text(
                state.dailyMessage,
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
