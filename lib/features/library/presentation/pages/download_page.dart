import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/error_message.dart';
import 'package:mahatacast/core/widgets/back_button.dart';
import 'package:mahatacast/features/library/bloc/library_bloc.dart';
import 'package:mahatacast/features/library/presentation/widgets/download_list.dart';
import 'package:mahatacast/generated/l10n.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  @override
  void didChangeDependencies() {
    context.read<LibraryBloc>().add(GetDownloadListEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 40, right: 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomBackButton(),
              70.horizontalSpace,
              Text(
                S.of(context).Downloads,
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
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
        Expanded(
          child: BlocBuilder<LibraryBloc, LibraryState>(
            buildWhen: (previous, current) =>
                previous.downloadListStatus != current.downloadListStatus,
            builder: (context, state) {
              if (state.downloadListStatus == LibraryStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              } else if (state.downloadListStatus == LibraryStatus.success) {
                if (state.downloadList.isEmpty) {
                  return Column(
                    children: [
                      100.verticalSpace,
                      SvgPicture.asset(
                        "assets/icons/library/emptydownload.svg",
                        width: .6.sw,
                      ),
                      10.verticalSpace,
                      Text(
                        S.of(context).YouHaveNotDownload,
                        style: TextStyle(
                            color: lightGreyColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: state.downloadList.length,
                      itemBuilder: (context, index) =>
                          DownloadList(podcast: state.downloadList[index]));
                }
              } else {
                return ErrorMessage(
                  onPressed: () {
                    context.read<LibraryBloc>().add(GetDownloadListEvent());
                  },
                );
              }
            },
          ),
        )
      ]),
    );
  }
}
