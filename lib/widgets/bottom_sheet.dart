import 'package:flutter/material.dart';
import 'package:phone/widgets/country_list_item.dart';

import '../models/country.dart';

class MyBottomSheet extends StatefulWidget {
  final futureCountries;

  const MyBottomSheet({Key? key, required this.futureCountries})
      : super(key: key);

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  late List<DisplayedCountry> countries;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: EdgeInsets.all(20.0),
      color: Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close),
            ),
          ),
          Text(
            'Country code',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 20.0,
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: FutureBuilder(
                future: widget.futureCountries,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Country> rawCountries =
                        snapshot.data as List<Country>;
                    countries = rawCountries.expand((country) {
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

                    return ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        return CountryListItem(country: countries[index]);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          )
        ],
      ),
    );
  }
}
