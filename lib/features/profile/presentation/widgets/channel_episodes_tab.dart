import 'package:flutter/material.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/features/profile/presentation/widgets/episode_box.dart';

class ChannelEpisodesTab extends StatelessWidget {
  const ChannelEpisodesTab({super.key, required this.episoes});
  final List<PodcastModel> episoes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: episoes.length,
              itemBuilder: (context, index) => EpisodeBox(
                    episo: episoes[index],
                    index: index,
                  )),
        ),
      ],
    ));
  }
}
