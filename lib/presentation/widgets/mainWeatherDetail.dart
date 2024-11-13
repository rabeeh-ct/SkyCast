import 'package:sky_cast/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen/home_screen_controller.dart';
import '../theme/colors.dart';
import '../theme/textStyle.dart';
import 'customShimmer.dart';

class MainWeatherDetail extends StatelessWidget {
  const MainWeatherDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(builder: (context, weatherProv, _) {
      if (weatherProv.isLoading) {
        return CustomShimmer(
          height: 132.0,
          borderRadius: BorderRadius.circular(16.0),
        );
      }
      return Container(
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
                      data: weatherProv.isCelsius
                          ? '${weatherProv.weather.feelsLike.toStringAsFixed(1)}°'
                          : '${weatherProv.weather.feelsLike.toFahrenheit().toStringAsFixed(1)}°'),
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
                    data: '${weatherProv.weather.humidity}%',
                  ),
                   VerticalDivider(
                    width: 8,
                    thickness: 1.0,
                    indent: 4.0,
                    endIndent: 4.0,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  DetailInfoTile(
                    icon:  const PhosphorIcon(
                      PhosphorIconsRegular.wind,
                      color: Colors.black,
                    ),
                    title: 'Wind',
                    data: '${weatherProv.weather.windSpeed} m/s',
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
                    icon:  const PhosphorIcon(
                      PhosphorIconsRegular.thermometerSimple,
                      color: Colors.black,
                    ),
                    title: 'Temp Min',
                    data:
                        "${weatherProv.isCelsius ? weatherProv.weather.tempMin.toStringAsFixed(1) : weatherProv.weather.tempMin.toFahrenheit().toStringAsFixed(1)}°",
                  ),
                   VerticalDivider(
                    width: 8,
                    thickness: 1.0,
                    indent: 4.0,
                    endIndent: 4.0,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  DetailInfoTile(
                    icon:  const PhosphorIcon(
                      PhosphorIconsRegular.thermometerHot,
                      color: Colors.black,
                    ),
                    title: 'Temp Max',
                    // data: "no data"
                    data:
                        "${weatherProv.isCelsius ? weatherProv.weather.tempMax.toStringAsFixed(1) : weatherProv.weather.tempMax.toFahrenheit().toStringAsFixed(1)}°",
                  ),
                   VerticalDivider(
                    width: 8,
                    thickness: 1.0,
                    indent: 4.0,
                    endIndent: 4.0,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  DetailInfoTile(
                    icon:  const PhosphorIcon(
                      PhosphorIconsRegular.gauge,
                      color: Colors.black,
                    ),
                    title: 'Pressure',
                    // data: "no data"
                    data: '${weatherProv.weather.pressure} mb',
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class DetailInfoTile extends StatelessWidget {
  final String title;
  final String data;
  final Widget icon;

   const DetailInfoTile({
    super.key,
    required this.title,
    required this.data,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding:  const EdgeInsets.all(8),
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
            ),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundColor: Colors.grey.withOpacity(0.2), child: icon),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(child: Text(title, style: lightText)),
                  FittedBox(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 1.0),
                      child: Text(
                        data,
                        style: mediumText,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
