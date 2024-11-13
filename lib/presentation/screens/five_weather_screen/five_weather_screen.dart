import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:sky_cast/domain/entities/app_error.dart';
import 'package:sky_cast/presentation/screens/five_weather_screen/components/single_day_item.dart';
import 'package:sky_cast/presentation/theme/theme.dart';
import 'package:sky_cast/utils/extensions.dart';

import '../../theme/textStyle.dart';
import 'five_weather_screen_controller.dart';

class FiveWeatherScreen extends StatefulWidget {
  const FiveWeatherScreen({super.key, required this.latLng});

  final LatLng latLng;

  @override
  State<FiveWeatherScreen> createState() => _FiveWeatherScreenState();
}

class _FiveWeatherScreenState extends State<FiveWeatherScreen> {
  @override
  void initState() {
    Provider.of<FiveWeatherScreenController>(context, listen: false)
        .getDailyWeather(widget.latLng, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Five Days Weather",
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<FiveWeatherScreenController>(builder: (context, controller, _) {
        if (controller.pageLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            final forecast = controller.fiveDaysForecast[index];
            return SingleDayItem(forecast: forecast,index: index,);
          },
          separatorBuilder: (context, index) => 10.sBH,
          itemCount: controller.fiveDaysForecast.length>5?5:controller.fiveDaysForecast.length,
        );
      }),
    );
  }
}
