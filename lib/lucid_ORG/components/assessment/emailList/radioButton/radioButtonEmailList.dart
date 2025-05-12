import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class RadioButtonEmailList extends ConsumerWidget {
  final String text;
  final AssessmentDisplay display;
  final EmailListRadioButtonType buttonType;

  const RadioButtonEmailList({required this.buttonType, required this.text, required this.display, super.key});

  BorderRadiusGeometry buttonBorder() {
    if (buttonType == EmailListRadioButtonType.ceo) {
      return const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.zero, bottomRight: Radius.zero);
    } else if (buttonType == EmailListRadioButtonType.cSuite) {
      return const BorderRadius.only();
    } else {
      return const BorderRadius.only(topLeft: Radius.zero, bottomLeft: Radius.zero, topRight: Radius.circular(10), bottomRight: Radius.circular(10));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(emailListRadioButtonProvider) == buttonType;

    String listLength() {
      if (display == AssessmentDisplay.current) {
        if (buttonType == EmailListRadioButtonType.ceo) {
          return ref.watch(currentEmailListProvider).emailsCeo.length.toString();
        } else if (buttonType == EmailListRadioButtonType.cSuite) {
          return ref.watch(currentEmailListProvider).emailsCSuite.length.toString();
        } else {
          return ref.watch(currentEmailListProvider).emailsEmployee.length.toString();
        }
      } else {
        if (buttonType == EmailListRadioButtonType.ceo) {
          return ref.watch(emailListProvider).emailsCeo.length.toString();
        } else if (buttonType == EmailListRadioButtonType.cSuite) {
          return ref.watch(emailListProvider).emailsCSuite.length.toString();
        } else {
          return ref.watch(emailListProvider).emailsEmployee.length.toString();
        }
      }

    }

    return MaterialButton(
        minWidth: 118,
        height: 50,
        onPressed: () => ref.read(emailListRadioButtonProvider.notifier).onButtonSelect(buttonType),
        color: isSelected ? const Color(0xFF9B9898) : Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: buttonBorder(),
            side: isSelected
                ? BorderSide.none
                : const BorderSide(
                    color: Color(0xFFEBEBEB),
                    width: 1,
                  )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w400,
              ),
            ),
            if (!ref.watch(emailListProvider).addEmailDisplay)
              const SizedBox(
                width: 4,
              ),
            if (!ref.watch(emailListProvider).addEmailDisplay)
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.white : const Color(0xFF9B9898),
                ),
                child: Center(
                  child: Text(
                    listLength(),
                    style: TextStyle(
                      color: isSelected ? const Color(0xFF9B9898) : Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
          ],
        ));
  }
}
