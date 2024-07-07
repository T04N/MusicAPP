import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';

import '../../data/model/Song.dart';
import '../discovery/discovery.dart';
import '../setting/Setting.dart';
import '../user/User.dart';
import 'ViewModel.dart';

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MusicApp',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true),
      home: MusicHomepage(),
    );
  }
}

class MusicHomepage extends StatefulWidget {
  const MusicHomepage({super.key});

  @override
  State<MusicHomepage> createState() => _MusicHomepageState();
}

class _MusicHomepageState extends State<MusicHomepage> {
  final List<Widget> _tabs = [
    const HomeTab(),
    const DiscoveryTab(),
    const Usertab(),
    const SettingTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Tev app"),
        backgroundColor: Colors.deepPurple,
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.album), label: 'Discovery'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ], backgroundColor: Colors.red),
        tabBuilder: (BuildContext context, int index) {
          return _tabs[index];
        },
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeTabPage();
  }
}

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<Song> songs = [];
  final MusicAppView _viewModel = new MusicAppView();

  @override
  void initState() {
    super.initState();
    _viewModel.loadData();
    observeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  void observeData() {
    _viewModel.songStream.stream.listen((songList) {
      setState(() {
        songs.addAll(songList);
      });
    });
  }

  Widget getBody() {
    bool ShowLoading = songs.isEmpty;
    if (ShowLoading) {
      return getProcessBar();
    } else {
      return getListView();
    }
  }

  Widget getProcessBar() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  ListView getListView() {
    return ListView.separated(
      itemBuilder: (context, postion) {
        return getRow(postion);
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.black,
          thickness: 1,
          indent: 24,
          endIndent: 24,
        );
      },
      shrinkWrap: true,
      itemCount: songs.length,
    );
  }

  Widget getRow(int postion) {
    return Center(
      child: Text(songs[postion].title),

    );
  }
}
