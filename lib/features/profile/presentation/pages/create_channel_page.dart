import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/generated/l10n.dart';
import 'package:mahatacast/services/service_fun.dart';
import 'package:mahatacast/core/widgets/main_text_field.dart';
import 'package:mahatacast/core/widgets/back_button.dart';
import 'package:mahatacast/features/profile/blocs/channel-bloc/channel_bloc.dart';
import 'package:mahatacast/features/profile/presentation/pages/user_channel_page.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateChannelPage extends StatefulWidget {
  const CreateChannelPage({super.key});

  @override
  State<CreateChannelPage> createState() => _CreateChannelPageState();
}

TextEditingController nameController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
File? imageFile;

class _CreateChannelPageState extends State<CreateChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"))),
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackButton(),
                20.verticalSpace,
                Text(
                  S.of(context).startMakingChannel,
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
                ),
                40.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if ((await Permission.storage.status) !=
                                    PermissionStatus.granted ||
                                (await Permission
                                        .manageExternalStorage.status) !=
                                    PermissionStatus.granted ||
                                (await Permission.accessMediaLocation.status) !=
                                    PermissionStatus.granted) {
                              await Permission.storage.request();
                              await Permission.manageExternalStorage.request();
                            }
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result == null) {
                              return;
                            }
                            // open single file
                            imageFile = File(result.files.first.path!);
                            setState(() {});
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: greenColor, shape: BoxShape.circle),
                            child: imageFile != null
                                ? Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.mic_rounded,
                                    size: 50,
                                    color: backgoundColor,
                                  ),
                          ),
                        ),
                        imageFile == null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: SvgPicture.asset(
                                  "assets/icons/profile/add-photo.svg",
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
                40.verticalSpace,
                MainTextField(
                    height: 100,
                    borderRadius: BorderRadius.circular(15),
                    prefixIcon: null,
                    hint: "",
                    hintColor: beigeColor,
                    label: S.of(context).ChannelName,
                    borderColor: beigeColor,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset("assets/icons/home/edit.svg"),
                    ),
                    controller: nameController),
                MainTextField(
                    maxLines: 100,
                    borderRadius: BorderRadius.circular(15),
                    prefixIcon: null,
                    hint: "",
                    hintColor: beigeColor,
                    borderColor: beigeColor,
                    label: S.of(context).Description,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset("assets/icons/home/edit.svg"),
                    ),
                    controller: descriptionController),
                150.verticalSpace,
                BlocListener<ChannelBloc, ChannelState>(
                  listener: (context, state) {
                    if (state.createChannelStatus == ChannelStatus.loading) {
                      BotToast.showLoading();
                    } else if (state.createChannelStatus ==
                        ChannelStatus.created) {
                      BotToast.closeAllLoading();
                      ServiceFunctions.setChannelId(state.channelModel!.id!);
                      BotToast.showText(
                          text: S.of(context).channelCreatedSuccessfully);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserChannelPage(
                                channelId: state.channelModel!.id!),
                          ));
                    } else if (state.createChannelStatus ==
                        ChannelStatus.failed) {
                      BotToast.closeAllLoading();
                      BotToast.showText(text: S.of(context).processFailed);
                    }
                  },
                  listenWhen: (previous, current) {
                    return previous.createChannelStatus !=
                        current.createChannelStatus;
                  },
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          fixedSize: Size(1.sw, .09.sh),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17))),
                      onPressed: () {
                        if (imageFile == null) {
                          BotToast.showText(text: S.of(context).chooseimage);
                        } else if (nameController.text.isEmpty) {
                          BotToast.showText(
                              text: S.of(context).writechannelName);
                        } else if (descriptionController.text.isEmpty) {
                          BotToast.showText(
                              text: S.of(context).writedescription);
                        } else {
                          context.read<ChannelBloc>().add(CreateChannelEvent(
                              name: nameController.text,
                              image: imageFile!,
                              description: descriptionController.text));
                        }
                      },
                      child: Text(
                        S.of(context).CreateChannel,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
