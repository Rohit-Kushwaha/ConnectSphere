import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  void initState() {
    deleteData();
    super.initState();
  }

  deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('hasSeenBottomSheet');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
