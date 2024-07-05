import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rent_hub/core/constants/ads/user_profile_settings.dart';
import 'package:rent_hub/core/theme/app_theme.dart';
import 'package:rent_hub/core/widgets/textfeild_widget.dart';
import 'package:rent_hub/features/authentication/controller/account_details_provider/account_details_provider.dart';
import 'package:rent_hub/features/authentication/controller/authenticcation_provider/authentication_provider.dart';
import 'package:rent_hub/features/authentication/controller/image_picker_provider.dart';
import 'package:rent_hub/features/authentication/view/widgets/profile_image_widget.dart';
import 'package:rent_hub/features/authentication/view/widgets/profile_settings_field_widget.dart';
import 'package:rent_hub/features/payment/pages/add_bank_ac_details_page.dart';

class ProfileSettingsPage extends HookConsumerWidget {
  static const routePath = '/profileSettings';
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authenticationProvider).phoneNumber ?? "";
    final user = ref.watch(GetAccountDetailsProvider(userId: userId)).value;

    // name editing controller
    final nameEditingController = useTextEditingController(
      text: user == null ? "" : user.data()?.userName ?? "",
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // TODO: CHECK IT
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          ref.watch(userProfileSettingsConstantsProvider).appTitle,
        ),
        titleTextStyle: context.typography.h1SemiBold,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.spaces.space_200,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // profile picture
              ProfileImgeWidget(
                onEdit: () {
               
                  // TODO : AMAL
                },
              ),
              // height spacing
              SizedBox(height: context.spaces.space_600),
              // user name
              Text(
                ref.watch(userProfileSettingsConstantsProvider).txtName,
                style: context.typography.bodyLarge,
              ),
              TextFeildWidget(
                suffix: IconButton(
                    onPressed: () {
                      ref.invalidate(accountDetailsProvider);
                    },
                    icon: Icon(Icons.edit)),
                onFieldSubmitted: (value) {
                  ref.watch(accountDetailsProvider.notifier).addData(
                        image: ref.read(imagePickerProvider),
                        userId: userId,
                        userName: value,
                      );
                },
                textController: nameEditingController,
                validator: (value) {
                  // TODO

                  return;
                },
              ),
              // bank account
              ProfileSettingsFieldWidget(
                title: ref
                    .watch(userProfileSettingsConstantsProvider)
                    .txtBankAccount,
                onPressed: () {
                  context.push(AddBankAcDetailsPage.routePath);
                },
              ),

              // log out
              ProfileSettingsFieldWidget(
                title:
                    ref.watch(userProfileSettingsConstantsProvider).txtLOgOut,
                onPressed: () {
                  // logout btn tap
                  ref.watch(authenticationProvider.notifier).logout();
                },
              ),
              ProfileSettingsFieldWidget(
                title: ref
                    .watch(userProfileSettingsConstantsProvider)
                    .txtDeleteAccount,
                onPressed: () {
                  ref
                      .watch(accountDetailsProvider.notifier)
                      .deleteAccount(userId: userId);
                },
              ),
              // version
            ],
          ),
        ),
      ),
    );
  }
}
