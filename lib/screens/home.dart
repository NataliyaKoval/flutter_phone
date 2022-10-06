import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phone/widgets/bottom_sheet.dart';

import '../consts/app_colors.dart';
import '../models/country.dart';
import '../services/country_service.dart';

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

  late Future<List<Country>> futureCountries;

  @override
  void initState() {
    super.initState();
    futureCountries = fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Get Started',
                style: Theme.of(context).textTheme.headline1,),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.0),
                            ),
                          ),
                          isScrollControlled: true,
                          builder: (context) => MyBottomSheet(futureCountries: futureCountries,)
                      );
                    },
                    child: Text('fgfd'),
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
