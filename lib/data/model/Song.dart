// {
// "id": "1074276774",
// "title": "Sầu Tím Thiệp Hồng",
// "album": "Chuyện Tình Không Dĩ Vãng",
// "artist": "Quang Lê ft Lệ Quyên",
// "image": "https://thantrieu.com/resources/arts/1074276774.webp",
// "source": "https://thantrieu.com/resources/music/1074276774.mp3",
// "duration": 287,
// "favorite": "false",
// "counter": 0,
// "replay": 0
// },

class Song {
  String id;
  String title;
  String album;
  String artist;
  String source;
  String image;
  int duration;

  factory Song.fromJson
  (
  Map<String ,dynamic> map) {
  return Song(
  id :map["id"],
  title :map["title"],
  album :map["album"],
  artist :map["artist"],
  source :map["source"],
  image :map["image"],
  duration :map["duration"],


  );
  }
  Song({
  required this.id,
  required this.title,
  required this.album,
  required this.artist,
  required this.source,
  required this.image,
  required this.duration
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Song && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Song{id: $id, title: $title, album: $album, artist: $artist, source: $source, image: $image, duration: $duration}';
  }
}