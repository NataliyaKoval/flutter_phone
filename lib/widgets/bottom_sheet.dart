import 'package:flutter/material.dart';
import 'package:phone/widgets/country_list_item.dart';

import '../consts/app_colors.dart';
import '../models/country.dart';
import '../services/country_service.dart';

class MyBottomSheet extends StatefulWidget {
  final Function changeCurrentCountry;

  const MyBottomSheet({
    Key? key,
    required this.changeCurrentCountry,
  }) : super(key: key);

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  late Future<List<Country>> futureCountries;
  List<DisplayedCountry> allCountries = [];
  List<DisplayedCountry> displayedCountries = [];

  Future mapCountriesToDisplayedCountries() async {
    var val = (await futureCountries).expand((country) {
      final suffixes = country.callingCodes.suffixes;
      List<DisplayedCountry> result = [];
      for (var suffix in suffixes) {
        result.add(DisplayedCountry(
            name: country.name,
            callingCode: country.callingCodes.root + suffix,
            flag: country.flag));
      }
      return result;
    }).toList();

    setState(() {
      allCountries = val;
    });
  }

  @override
  void initState() {
    super.initState();
    futureCountries = fetchCountries();
    mapCountriesToDisplayedCountries().whenComplete(() => filterCountries(''));
  }

  void filterCountries(value) {
    List<DisplayedCountry> result = [];
    if (value.isEmpty) {
      result = allCountries;
    } else {
      result = allCountries
          .where((country) =>
              country.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }

    setState(() {
      displayedCountries = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ),
          Text(
            'Country code',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            onChanged: filterCountries,
            style: Theme.of(context).textTheme.button,
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search, color: AppColors.buttonTextColor,),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedCountries.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.changeCurrentCountry(displayedCountries[index]);
                    Navigator.of(context).pop();
                  },
                  child: CountryListItem(country: displayedCountries[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
