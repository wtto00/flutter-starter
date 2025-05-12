import 'package:flutter/material.dart';
import 'package:flutter_starter/routes/home.dart';
import 'package:flutter_starter/states/home.dart';
import 'package:flutter_starter/states/main_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      context.read<MainPageProvider>().changeIndex(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: ChangeNotifierProvider(
              create: (_) => HomeProvider(),
              child: const Home(),
            ),
          ),
          Center(
            child: Text(
              "发现",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Center(
            child: Text(
              "我的",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: Selector<MainPageProvider, int>(
          builder:
              (_, currentIndex, child) => BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: "发现",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "我的",
                  ),
                ],
                currentIndex: currentIndex,
                onTap: (index) {
                  _tabController.index = index;
                },
              ),
          selector: (context, provider) => provider.currentIndex,
        ),
      ),
    );
  }
}
