import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahatacast/core/message_boxs/error_message.dart';
import 'package:mahatacast/features/profile/blocs/channel-bloc/channel_bloc.dart';
import 'package:mahatacast/features/profile/presentation/widgets/have_channel.dart';
import 'package:mahatacast/features/profile/presentation/widgets/have_no_channel.dart';
import 'package:mahatacast/generated/l10n.dart';

class CheckUserChannel extends StatefulWidget {
  const CheckUserChannel({super.key});

  @override
  State<CheckUserChannel> createState() => _CheckUserChannelState();
}

class _CheckUserChannelState extends State<CheckUserChannel> {
  @override
  void didChangeDependencies() {
    context.read<ChannelBloc>().add(GetUserChannelEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"))),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  S.of(context).checkifyouhave,
                  style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            40.verticalSpace,
            BlocBuilder<ChannelBloc, ChannelState>(
              builder: (context, state) {
                if (state.userChannelStatus == ChannelStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                } else if (state.userChannelStatus == ChannelStatus.success) {
                  if (state.userChannel == null) {
                    return const HaveNoChannel();
                  } else {
                    return HaveChannel(channel: state.userChannel);
                  }
                } else {
                  return Center(
                    child: ErrorMessage(
                      onPressed: () => context
                          .read<ChannelBloc>()
                          .add(GetUserChannelEvent()),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
