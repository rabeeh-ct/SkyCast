import 'package:sky_cast/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../theme/colors.dart';
import '../../theme/textStyle.dart';
import '../../widgets/WeatherInfoHeader.dart';
import '../../widgets/mainWeatherDetail.dart';
import '../../widgets/mainWeatherInfo.dart';
import 'components/custom_search_bar.dart';
import 'components/locationError.dart';
import 'components/requestError.dart';
import 'home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FloatingSearchBarController fsc = FloatingSearchBarController();

  @override
  void initState() {
    super.initState();
    // request for data, it is the initial function
    requestWeather();
  }

  Future<void> requestWeather() async {
    await Provider.of<HomeScreenController>(context, listen: false).getData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "SkyCast",
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Consumer<HomeScreenController>(
        builder: (context, weatherProv, _) {
          if (!weatherProv.isLoading && !weatherProv.isLocationserviceEnabled) {
            return const LocationServiceErrorDisplay();
          } else if (!weatherProv.isLoading &&
              weatherProv.locationPermission != LocationPermission.always &&
              weatherProv.locationPermission != LocationPermission.whileInUse) {
            return const LocationPermissionErrorDisplay();
          } else if (weatherProv.isRequestError) {
            return const RequestErrorDisplay();
          } else if (weatherProv.isSearchError) {
            return SearchErrorDisplay(fsc: fsc);
          } else {
            return Stack(
              children: [
                // background image
                Positioned.fill(
                    child: Image.asset(
                  "assets/images/mountain.jpg",
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                )),
                ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16.0).copyWith(
                    top: kToolbarHeight + MediaQuery.viewPaddingOf(context).top + 24.0,
                  ),
                  children: [
                    const WeatherInfoHeader(),
                    16.sBH,
                    const MainWeatherInfo(),
                    16.sBH,
                    const MainWeatherDetail(),
                    24.sBH,
                  ],
                ),
                CustomSearchBar(fsc: fsc),
              ],
            );
          }
        },
      ),
    );
  }
}
