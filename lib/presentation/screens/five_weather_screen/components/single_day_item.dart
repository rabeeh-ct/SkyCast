import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sky_cast/domain/entities/app_error.dart';
import 'package:sky_cast/presentation/theme/theme.dart';
import 'package:sky_cast/utils/extensions.dart';

import '../../../../domain/entities/five_days_weather_response_entity.dart';
import '../../../theme/textStyle.dart';
import '../../../widgets/mainWeatherDetail.dart';

class SingleDayItem extends StatelessWidget {
  const SingleDayItem({super.key, required this.forecast, required this.index});

  final ListElement forecast;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset:  const Offset(-4.0, -4.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(4.0, 4.0),
            blurRadius: 16.0,
          ),]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

            Text(
              index == 0?"Today":index==1?"Tomorrow":DateFormat("dd MMM").format(DateTime.now().add(Duration(days: index),),),
              style: mediumText.copyWith(fontWeight: FontWeight.w600),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.sBW,
              Text(
                forecast.main.temp.toStringAsFixed(1),
                style: boldText.copyWith(fontSize: 40),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("°C", style: mediumText.copyWith(fontSize: 26)),
              ),
              20.sBW,
              Expanded(
                child: Center(
                  child: Text(
                    forecast.weather.first.description.toTitleCase(),
                    style: mediumText.copyWith(fontSize: 16),
                  ),
                ),
              ),
              30.sBW,
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              // color: backgroundWhite,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      DetailInfoTile(
                        icon: const PhosphorIcon(
                          PhosphorIconsRegular.thermometerSimple,
                          color: Colors.black,
                        ),
                        title: 'Feels Like',
                        data: '${forecast.main.feelsLike.toStringAsFixed(1)}°',
                      ),
                      VerticalDivider(
                        width: 8,
                        thickness: 1.0,
                        indent: 4.0,
                        endIndent: 4.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      DetailInfoTile(
                        icon: const PhosphorIcon(
                          PhosphorIconsRegular.dropHalfBottom,
                          color: Colors.black,
                        ),
                        title: 'Humidity',
                        data: '${forecast.main.humidity}%',
                      ),
                      VerticalDivider(
                        width: 8,
                        thickness: 1.0,
                        indent: 4.0,
                        endIndent: 4.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      DetailInfoTile(
                        icon: const PhosphorIcon(
                          PhosphorIconsRegular.wind,
                          color: Colors.black,
                        ),
                        title: 'Wind',
                        data: '${forecast.wind.speed} m/s',
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey.withOpacity(0.3),
                ),
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      DetailInfoTile(
                        icon: const PhosphorIcon(
                          PhosphorIconsRegular.thermometerSimple,
                          color: Colors.black,
                        ),
                        title: 'Temp Min',
                        data: "${forecast.main.tempMin.toStringAsFixed(1)}°",
                      ),
                      VerticalDivider(
                        width: 8,
                        thickness: 1.0,
                        indent: 4.0,
                        endIndent: 4.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      DetailInfoTile(
                        icon: const PhosphorIcon(
                          PhosphorIconsRegular.thermometerHot,
                          color: Colors.black,
                        ),
                        title: 'Temp Max',
                        // data: "no data"
                        data: "${forecast.main.tempMax.toStringAsFixed(1)}°",
                      ),
                      VerticalDivider(
                        width: 8,
                        thickness: 1.0,
                        indent: 4.0,
                        endIndent: 4.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      DetailInfoTile(
                        icon: const PhosphorIcon(
                          PhosphorIconsRegular.gauge,
                          color: Colors.black,
                        ),
                        title: 'Pressure',
                        // data: "no data"
                        data: '${forecast.main.pressure} mb',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
