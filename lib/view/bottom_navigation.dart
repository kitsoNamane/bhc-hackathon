
import 'dart:developer';

import 'package:bhc_hackathon/view/navigation_helpers.dart';
import 'package:bhc_hackathon/view_model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
    required this.child,
  });

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: Consumer<ApplicationState>(
        builder: (context, state, child) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.child.currentIndex,
          onTap: (index) {
            widget.child.goBranch(
              index,
              initialLocation: index == widget.child.currentIndex,
            );
            setState(() {});
          },
          items: BottomNavigationHelpers.bottomNavigationItems(
            state.loggedIn
          )
        ),
      ),
    );
  }
}
