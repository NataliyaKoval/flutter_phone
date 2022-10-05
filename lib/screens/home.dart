import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phone/consts/app_colors.dart';

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
              const Text('Get Started',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  )),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('fgfd'),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: checkPhoneLength,
                      decoration: InputDecoration(
                        fillColor: const Color.fromRGBO(244, 245, 255, 0.4),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        hintText: 'Your phone number',
                        hintStyle: const TextStyle(
                          color: Color(0xff7886B8),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
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
                      isNextButtonActive ? AppColors.white : AppColors.lightBlue,
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
