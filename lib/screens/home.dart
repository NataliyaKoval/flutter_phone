import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phone/widgets/bottom_sheet.dart';

import '../consts/app_colors.dart';
import '../models/country.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String inputMask = '(###) ###-####';

  final int requiredPhoneLength = inputMask.length;
  final maskFormatter = MaskTextInputFormatter(
      mask: inputMask,
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  bool isNextButtonActive = false;

  DisplayedCountry currentCountry = DisplayedCountry(
      name: 'Ukraine', callingCode: '+38', flag: 'https://flagcdn.com/ua.svg');

  void changeCurrentCountry(country) {
    setState(() {
      currentCountry = country;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get Started',
                style: Theme.of(context).textTheme.headline1,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => MyBottomSheet(
                          changeCurrentCountry: changeCurrentCountry,
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.network(
                          currentCountry.flag,
                          height: 20.0,
                          placeholderBuilder: (BuildContext context) =>
                              const SizedBox(
                            height: 20.0,
                            width: 38.0,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(currentCountry.callingCode),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: checkPhoneLength,
                      decoration: const InputDecoration(
                        hintText: 'Your phone number',
                      ),
                      inputFormatters: [maskFormatter],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      isNextButtonActive
                          ? AppColors.white
                          : AppColors.lightBlue,
                    ),
                  ),
                  onPressed: isNextButtonActive ? () {} : null,
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 20.0,
                    color: Color(0xff7886B8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkPhoneLength(val) {
    if (val.length == requiredPhoneLength) {
      setState(() {
        isNextButtonActive = true;
      });
    } else {
      setState(() {
        isNextButtonActive = false;
      });
    }
  }
}
