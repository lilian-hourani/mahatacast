import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/error_message.dart';
import 'package:mahatacast/core/widgets/back_button.dart';
import 'package:mahatacast/features/home/presentation/widgets/loading_recently_played.dart';
import 'package:mahatacast/features/library/bloc/library_bloc.dart';
import 'package:mahatacast/features/library/presentation/widgets/notification_box.dart';
import 'package:mahatacast/generated/l10n.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void didChangeDependencies() {
    context.read<LibraryBloc>().add(GetUnreadNotificationEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 40, right: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomBackButton(),
                60.horizontalSpace,
                Text(
                  S.of(context).Notifications,
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Divider(
            color: lightGreyColor,
            thickness: 0.5,
          ),
          Expanded(child:
              BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
            if (state.unreadNotificationListStatus == LibraryStatus.loading) {
              return ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: LoadindRecntlyPlaying(),
                ),
              );
            } else if (state.unreadNotificationListStatus ==
                LibraryStatus.success) {
              return ListView.builder(
                itemCount: state.unreadNotificationList.length,
                itemBuilder: (context, index) => NotificationBox(
                  notificationModel: state.unreadNotificationList[index],
                ),
              );
            } else {
              return ErrorMessage(
                onPressed: () {
                  context.read<LibraryBloc>().add(GetUnreadNotificationEvent());
                },
              );
            }
          }))
        ],
      ),
    );
  }
}
