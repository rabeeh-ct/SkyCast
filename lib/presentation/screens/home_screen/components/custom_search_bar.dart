import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../theme/colors.dart';
import '../../../theme/textStyle.dart';
import '../home_screen_controller.dart';

class CustomSearchBar extends StatefulWidget {
  final FloatingSearchBarController fsc;

  const CustomSearchBar({
    super.key,
    required this.fsc,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final List<String> _citiesSuggestion = [
    'Kochi',
    'Thiruvananthapuram',
    'Kozhikode',
    'Dubai',
    'London',
  ];

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      margins: const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: Colors.white,
      controller: widget.fsc,
      hint: 'Search...',
      clearQueryOnClose: false,
      scrollPadding: const EdgeInsets.only(top: 16.0, bottom: 56.0),
      transitionDuration: const Duration(milliseconds: 400),
      borderRadius: BorderRadius.circular(16.0),
      transitionCurve: Curves.easeInOut,
      accentColor: primaryBlue,
      hintStyle: regularText,
      queryStyle: regularText,
      physics: const BouncingScrollPhysics(),
      elevation: 2.0,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {},
      onSubmitted: (query) async {
        widget.fsc.close();
        await Provider.of<HomeScreenController>(context, listen: false)
            .searchWeather(query, context);
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        const FloatingSearchBarAction(
          showIfOpened: false,
          child: PhosphorIcon(
            PhosphorIconsBold.magnifyingGlass,
            color: primaryBlue,
          ),
        ),
        FloatingSearchBarAction.icon(
          showIfClosed: false,
          showIfOpened: true,
          icon: const PhosphorIcon(
            PhosphorIconsBold.x,
            color: primaryBlue,
          ),
          onTap: () {
            if (widget.fsc.query.isEmpty) {
              widget.fsc.close();
            } else {
              widget.fsc.clear();
            }
          },
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: _citiesSuggestion.length,
              itemBuilder: (context, index) {
                String data = _citiesSuggestion[index];
                return InkWell(
                  onTap: () async {
                    widget.fsc.query = data;
                    widget.fsc.close();
                    await Provider.of<HomeScreenController>(context, listen: false)
                        .searchWeather(data, context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(22.0),
                    child: Row(
                      children: [
                        const PhosphorIcon(PhosphorIconsFill.mapPin),
                        const SizedBox(width: 22.0),
                        Text(data, style: mediumText),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                thickness: 1.0,
                height: 0.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
