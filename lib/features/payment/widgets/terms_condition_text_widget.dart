import 'package:flutter/material.dart';
import 'package:rent_hub/core/constants/payment_constants/add_account_constants.dart';
import 'package:rent_hub/core/theme/app_theme.dart';

class TermsAndConditionText extends StatelessWidget {
  const TermsAndConditionText({
    super.key,
    required this.addBankConsts,
  });

  final AddBankAccountConstants addBankConsts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: context.spaces.space_50),
      child: RichText(
        text: TextSpan(
          text: addBankConsts.termsAndConditionsct1,
          style: context.typography.body,
          children: <TextSpan>[
            TextSpan(
              text: addBankConsts.txtTermAndConditionSctn2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(
                text: addBankConsts.txtTermAndConditionSctn3,
                style: context.typography.body),
          ],
        ),
      ),
    );
  }
}
