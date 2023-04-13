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
          title: const Text(
            'Watch Now',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            indicatorColor: Colors.red,
            tabs: [
              Tab(text: CategoryType.Now_Playing.name),
              Tab(text: CategoryType.Popular.name),
              Tab(text: CategoryType.Top_Rated.name),
              Tab(text: CategoryType.Upcoming.name),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: _isSimpleModeEnabled
              ? SimpleView()
              : TabBarView(
                  children: [
                    TabBarWidget(
                      categoryType: CategoryType.Now_Playing,
                      pageKey: 'NowPlaying',
                    ),
                    TabBarWidget(
                      categoryType: CategoryType.Popular,
                      pageKey: 'Popular',
                    ),
                    TabBarWidget(
                      categoryType: CategoryType.Top_Rated,
                      pageKey: 'TopRated',
                    ),
                    TabBarWidget(
                      categoryType: CategoryType.Upcoming,
                      pageKey: 'Upcoming',
                    )
                  ],
                ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[_singOutButton()],
                  )),
              SwitchListTile(
                title: Text('Simple Mode'),
                subtitle: Text('Enable this to use a simplified view'),
                value: _isSimpleModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _isSimpleModeEnabled = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  singOut() async {
    await Auth().singOut();
  }

  _singOutButton() {
    return ElevatedButton(onPressed: singOut, child: const Text('Sing out'));
  }
}

class SimpleView extends StatelessWidget {
  const SimpleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: TabBarView(
          children: [
            TabBarWidget(
              categoryType: CategoryType.Now_Playing,
              pageKey: 'NowPlaying',
            ),
            TabBarWidget(
              categoryType: CategoryType.Popular,
              pageKey: 'Popular',
            ),
            TabBarWidget(
              categoryType: CategoryType.Top_Rated,
              pageKey: 'TopRated',
            ),
            TabBarWidget(
              categoryType: CategoryType.Upcoming,
              pageKey: 'Upcoming',
            )
          ],
        ),
      ),
    ));
  }
}
