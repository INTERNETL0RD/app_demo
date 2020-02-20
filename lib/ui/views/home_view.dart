import 'package:flutter/material.dart';
import 'package:prototipo_agifreu/ui/views/profile_view.dart';

import '../widgets/fluid_nav_bar.dart';
import '../shared/app_colors.dart';
import './posts_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget _child;

  @override
  void initState() {
    _child = PostsView();
    super.initState();
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = PostsView();
          break;
        case 1:
          _child = ProfileView();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: false,
        bottomNavigationBar: FluidNavBar(onChange: _handleNavigationChange),
        body: _child);
  }
}
