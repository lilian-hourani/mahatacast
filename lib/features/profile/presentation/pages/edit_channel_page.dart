import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahatacast/core/constants/base_uri.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/widgets/back_button.dart';
import 'package:mahatacast/core/widgets/main_text_field.dart';
import 'package:permission_handler/permission_handler.dart';

class EditChannelPage extends StatefulWidget {
  const EditChannelPage(
      {super.key,
      required this.imagePath,
      required this.channelName,
      required this.description});
  final String imagePath;
  final String channelName;
  final String description;

  @override
  State<EditChannelPage> createState() => _EditChannelPageState();
}

class _EditChannelPageState extends State<EditChannelPage> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  File? imageFile;
  @override
  void initState() {
    nameController = TextEditingController(text: widget.channelName);
    descriptionController = TextEditingController(text: widget.description);
    super.initState();
  }

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
                  "Editing your channel\ninformation ",
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
                              width: 140,
                              height: 140,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  color: greenColor, shape: BoxShape.circle),
                              child: imageFile != null
                                  ? Image.file(
                                      imageFile!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      "$baseUri${widget.imagePath}",
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        imageFile == null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: SvgPicture.asset(
                                  "assets/icons/profile/edit-photo.svg",
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
                    label: "Channel Name",
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
                    label: "Description",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset("assets/icons/home/edit.svg"),
                    ),
                    controller: descriptionController),
                150.verticalSpace,
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        fixedSize: Size(1.sw, .09.sh),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17))),
                    onPressed: () {},
                    child: Text(
                      'Edit Channel',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
