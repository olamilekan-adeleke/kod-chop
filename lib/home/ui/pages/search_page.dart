import 'package:flutter/material.dart';
import 'package:kod_chop/home/ui/view/search_page_view.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: body(context),
      ),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        SearchPageSearchBar(size: size),
        SearchPageBody(size: size),
      ],
    );
  }
}
