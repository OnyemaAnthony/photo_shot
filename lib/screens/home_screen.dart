import 'package:flutter/material.dart';
import 'package:photo_shot/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ApBar(),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0XFFF5F8FD),
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                    ),
                  ),
                  Icon(Icons.search),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
