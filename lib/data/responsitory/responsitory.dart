import '../model/Song.dart';
import '../source/source.dart';

abstract interface class Responsitory {
  Future<List<Song>?> loadData();
}

class DefaultResponsitory implements Responsitory {
  final RemoteDataSource _remoteSource = RemoteDataSource();
  final LocalDataSource _localSource = LocalDataSource();

  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];
    // Tải dữ liệu từ remote
    List<Song>? remoteSongs = await _remoteSource.loadData();
    if (remoteSongs == null) {
      // Nếu remote thất bại, tải dữ liệu từ local
      List<Song>? localSongs = await _localSource.loadData();
      if (localSongs != null) {
        songs.addAll(localSongs);
      }
    } else {
      songs.addAll(remoteSongs);
    }
    return songs.isEmpty ? null : songs;
  }
}
