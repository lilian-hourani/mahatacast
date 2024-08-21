import 'package:flutter/material.dart';
import 'package:mahatacast/features/home/data/models/podcast_model.dart';
import 'package:mahatacast/features/home/presentation/widgets/episode_tile.dart';

class EpisodesTab extends StatelessWidget {
  const EpisodesTab({super.key, required this.episoes});
  final List<PodcastModel> episoes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: episoes.length,
              itemBuilder: (context, index) => EpisodeListTile(
                    episo: episoes[index],
                    index: index,
                  )),
        ),
      ],
    ));
  }
}
