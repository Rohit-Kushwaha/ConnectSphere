import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.flutter_dash,
              size: 100,
            ),
          ),
          DrawerListTile(
            title: "Places",
            icon: Icons.travel_explore_outlined,
            press: () {
              context.go('/place');
            },
          ),
          DrawerListTile(
            title: "Messaging",
            icon: Icons.message,
            press: () {
              context.go('/message');
            },
          ),
          DrawerListTile(
            title: "Blog",
            icon: Icons.message,
            press: () {
              context.go('/blog');
            },
          ),
          DrawerListTile(
            title: "Items",
            icon: Icons.ice_skating,
            press: () {
              context.go('/items');
            },
          ),
          DrawerListTile(
            title: "Profile",
            icon: Icons.face,
            press: () {
              context.go('/profile');
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  });

  final String title;
  final VoidCallback press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.red, fontSize: 16),
      ),
    );
  }
}
