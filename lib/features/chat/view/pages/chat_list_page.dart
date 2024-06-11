import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rent_hub/core/constants/chat_box_constants/chat_box.dart';
import 'package:rent_hub/core/theme/app_theme.dart';
import 'package:rent_hub/features/authentication/controller/authenticcation_provider/authentication_provider.dart';
import 'package:rent_hub/features/chat/controller/chat_controller.dart';
import 'package:rent_hub/features/chat/view/pages/chat_details_page.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(messageSentBymeProvider).value;
    final currentUserId = ref.watch(authenticationProvider).phoneNumber;
    return Scaffold(
      backgroundColor: context.colors.primary,
      appBar: AppBar(
        backgroundColor: context.colors.primary,
        title: Consumer(
          builder: (context, ref, child) {
            return Text(
              ref.watch(chatBoxConstantsProvider).txtHeading,
              style: context.typography.h1Bold,
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: context.colors.cardBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(context.spaces.space_600),
            topRight: Radius.circular(context.spaces.space_600),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(context.spaces.space_100),
          child: Column(
            children: [
              SizedBox(
                height: context.spaces.space_200,
              ),
              ref.watch(getUserProvider).when(
                    data: (data) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.docs.length,
                        itemBuilder: (context, index) {
                          var doc = data.docs[index];
                          log("message");
                          log(data.docs[index].id);

                          return currentUserId != doc.id
                              ? Stack(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            context.spaces.space_300),
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatDetailsPage(
                                                receiverId: doc.id,
                                                userId: currentUserId!,
                                              ),
                                            ),
                                          );
                                        },
                                        leading: CircleAvatar(
                                          child: Icon(Icons.person),
                                        ),
                                        title: Text(
                                          doc.data().userName,
                                          style: context
                                              .typography.bodyLargeSemiBold,
                                        ),
                                        subtitle: Text(
                                          'last msg',
                                          style: context.typography.body,
                                        ),
                                      ),
                                      color: context.colors.messageBackground,
                                    ),
                                    Positioned(
                                      right: context.spaces.space_50,
                                      top: context.spaces.space_50,
                                      child: Container(
                                        width: context.spaces.space_300 * 4,
                                        height: context.spaces.space_300,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                context.spaces.space_600),
                                            bottomLeft: Radius.circular(
                                                context.spaces.space_600),
                                          ),
                                          color: context.colors.primary,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '11:33 Am',
                                            style: context.typography.body,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox.shrink();
                        },
                      );
                    },
                    error: (error, stackTrace) => Center(
                      child: Text(error.toString()),
                    ),
                    loading: () => CircularProgressIndicator(),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
