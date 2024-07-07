import 'dart:async';

import '../../data/model/Song.dart';
import '../../data/responsitory/responsitory.dart';

class MusicAppView {
StreamController<List<Song>> songStream = new StreamController();

void loadData(){
  final  respository = new DefaultResponsitory();
  respository.loadData().then((value)=>songStream.add(value!));
}
}