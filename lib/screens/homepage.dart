import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import '../auth.dart';
import '../common_widgets/tab_bar_widget.dart';
import '../constants/enum.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final User? user = Auth().currentUser;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSimpleModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: Color(0xfff354249),
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.transparent,
            toolbarHeight: 70,
            elevation: 0,
            title: _isSimpleModeEnabled
                ? Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Oglądaj',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Oglądaj',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              indicatorColor: Colors.red,
              tabs: _isSimpleModeEnabled
                  ? [
                      Tab(
                        icon: Column(
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              size: 30,
                            ),
                            Text(
                              'Odtwarzaj',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        icon: Column(
                          children: [
                            Icon(
                              Icons.star_border_outlined,
                              size: 30,
                            ),
                            Text(
                              'Popularne',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        icon: Column(
                          children: [
                            Icon(
                              Icons.trending_up_outlined,
                              size: 30,
                            ),
                            Text(
                              'Najlepsze',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        icon: Column(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 30,
                            ),
                            Text(
                              'Nadchodzące',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ]
                  : [
                      Tab(
                        icon: Column(
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              size: 45,
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        icon: Column(
                          children: [
                            Icon(
                              Icons.star_border_outlined,
                              size: 45,
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        icon: Column(
                          children: [
                            Icon(
                              Icons.trending_up_outlined,
                              size: 45,
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        icon: Column(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 45,
                            ),
                          ],
                        ),
                      ),
                    ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TabBarView(
              children: [
                TabBarWidget(
                  categoryType: CategoryType.Now_Playing,
                  pageKey: 'NowPlaying',
                  isSimpleModeEnabled: _isSimpleModeEnabled,
                ),
                TabBarWidget(
                  categoryType: CategoryType.Popular,
                  pageKey: 'Popular',
                  isSimpleModeEnabled: _isSimpleModeEnabled,
                ),
                TabBarWidget(
                  categoryType: CategoryType.Top_Rated,
                  pageKey: 'TopRated',
                  isSimpleModeEnabled: _isSimpleModeEnabled,
                ),
                TabBarWidget(
                  categoryType: CategoryType.Upcoming,
                  pageKey: 'Upcoming',
                  isSimpleModeEnabled: _isSimpleModeEnabled,
                )
              ],
            ),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(
                    'Boomer Mode',
                    style: TextStyle(
                      fontSize: _isSimpleModeEnabled ? 50 : 20,
                    ),
                  ),
                  subtitle: _isSimpleModeEnabled
                      ? Text(
                          'Wyłącz boomerski tryb',
                          style: TextStyle(
                              fontSize: _isSimpleModeEnabled ? 30 : 20),
                        )
                      : Text(''),
                  value: _isSimpleModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isSimpleModeEnabled = value;
                    });
                  },
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 24), // zwiększenie marginesów
                ),
                Expanded(
                  child: Container(),
                ),
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _singOutButton(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  singOut() async {
    await Auth().singOut();
  }

  _singOutButton() {
    return ElevatedButton(
        onPressed: singOut,
        child: Text('Wyloguj',
            style: TextStyle(fontSize: _isSimpleModeEnabled ? 50 : 20)));
  }
}

class SimpleView extends StatelessWidget {
  const SimpleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      body: Text(
        'Simple view is enabled',
        style: TextStyle(fontSize: 24),
      ),
    ));
  }
}
