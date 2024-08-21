import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahatacast/core/constants/colors.dart';
import 'package:mahatacast/core/message_boxs/error_message.dart';
import 'package:mahatacast/core/widgets/back_button.dart';
import 'package:mahatacast/features/library/bloc/library_bloc.dart';
import 'package:mahatacast/features/library/presentation/widgets/favorite_list.dart';
import 'package:mahatacast/generated/l10n.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void didChangeDependencies() {
    context.read<LibraryBloc>().add(GetFavoriteListEvent());
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
                S.of(context).Favorites,
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
                previous.favoriteListStatus != current.favoriteListStatus,
            builder: (context, state) {
              if (state.favoriteListStatus == LibraryStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              } else if (state.favoriteListStatus == LibraryStatus.success) {
                if (state.favoriteList.isEmpty) {
                  return Column(
                    children: [
                      100.verticalSpace,
                      SvgPicture.asset(
                        "assets/icons/library/favorite-empty.svg",
                        width: .6.sw,
                      ),
                      10.verticalSpace,
                      Text(
                        S.of(context).YourFavoriteIsEmpty,
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
                    itemCount: state.favoriteList.length,
                    itemBuilder: (context, index) => Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 20, end: 20),
                      child: FavoriteList(
                        podcast: state.favoriteList[index],
                      ),
                    ),
                  );
                }
              } else {
                return ErrorMessage(
                  onPressed: () {
                    context.read<LibraryBloc>().add(GetFavoriteListEvent());
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
