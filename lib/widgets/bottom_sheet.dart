import 'package:flutter/material.dart';

import '../models/country.dart';

class MyBottomSheet extends StatefulWidget {
  final futureCountries;
  const MyBottomSheet({Key? key, required this.futureCountries}) : super(key: key);

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  late List<DisplayedCountry> countries;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close),
          ),
          TextField(),
          Expanded(
            child: FutureBuilder(
                future: widget.futureCountries,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Country> rawCountries =
                    snapshot.data as List<Country>;
                    countries =
                        rawCountries.expand((country) {
                          final suffixes =
                              country.callingCodes.suffixes;
                          List<DisplayedCountry> result = [];
                          for (var suffix in suffixes) {
                            result.add(DisplayedCountry(
                                name: country.name,
                                callingCode:
                                country.callingCodes.root +
                                    suffix,
                                flag: country.flag));
                          }
                          return result;
                        }).toList();

                    return ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        return Text(
                            countries[index].name);
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
