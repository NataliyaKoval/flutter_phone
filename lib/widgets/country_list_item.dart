import 'package:flutter/material.dart';
import '../models/country.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryListItem extends StatelessWidget {
  final DisplayedCountry country;

  const CountryListItem({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          SvgPicture.network(
            country.flag,
            height: 20.0,
            placeholderBuilder: (BuildContext context) => const SizedBox(height: 20.0, width: 38.0,),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(country.callingCode),
          const SizedBox(
            width: 8,
          ),
          Flexible(child: Text(country.name),)
        ],
      ),
    );
  }
}
