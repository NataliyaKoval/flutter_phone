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
          padding: const EdgeInsets.only(top: 40.0, bottom: 20.0, left: 20.0, right: 20.0),
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
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.lightBlue),
                    ),
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
                        Text(currentCountry.callingCode, style: Theme.of(context).textTheme.button),
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
                      style: Theme.of(context).textTheme.button,
                      decoration: const InputDecoration(
                        hintText: '(123)123-1234',
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
                  onPressed: isNextButtonActive ? saySomething : null,
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

  void saySomething() {
    print('I was pressed!');
  }
}
