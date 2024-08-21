class PodcastModel {
  final int? podcastId;
  final String? podcastTitle;
  final String? podcastPath;
  final String? podcastDuration;
  final double? podcastSize;
  final int? channelId;
  final String? channelName;
  final String? channelImage;
  final String? channelOwnerName;
  final int? podcastFavourites;
  final int? podcastListenersNumber;
  final dynamic podcastRate;

  PodcastModel({
    this.podcastId,
    this.podcastTitle,
    this.podcastPath,
    this.podcastDuration,
    this.podcastSize,
    this.channelId,
    this.channelName,
    this.channelImage,
    this.channelOwnerName,
    this.podcastFavourites,
    this.podcastListenersNumber,
    this.podcastRate,
  });

  factory PodcastModel.fromJson(Map<String, dynamic> json) => PodcastModel(
        podcastId: json["podcast id"],
        podcastTitle: json["podcast title"],
        podcastPath: json["podcast path"],
        podcastDuration: json["podcast duration"],
        podcastSize: json["podcast size"]?.toDouble(),
        channelId: json["channel id"],
        channelName: json["channel name"],
        channelImage: json["channel image"],
        channelOwnerName: json["channel owner name"],
        podcastFavourites: json["podcast favourites"],
        podcastListenersNumber: json["podcast listeners number"],
        podcastRate: json["podcast rate"],
      );

  Map<String, dynamic> toJson() => {
        "podcast id": podcastId,
        "podcast title": podcastTitle,
        "podcast path": podcastPath,
        "podcast duration": podcastDuration,
        "podcast size": podcastSize,
        "channel id": channelId,
        "channel name": channelName,
        "channel image": channelImage,
        "channel owner name": channelOwnerName,
        "podcast favourites": podcastFavourites,
        "podcast listeners number": podcastListenersNumber,
        "podcast rate": podcastRate,
      };
}
