import 'package:flutter/material.dart';
import 'package:healthcareapp/ViewCart.dart';

class SearchMedicine extends StatefulWidget {
  const SearchMedicine({super.key, required this.title});
  final String title;

  @override
  State<SearchMedicine> createState() => SearchMedicineState();
}

class SearchMedicineState extends State<SearchMedicine>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
      slivers: [
      SliverAppBar(
      floating: true,
      pinned: true,
      snap: false,
      centerTitle: false,
      title: const Text('Search Medicine'),
      actions: [
      IconButton(
      icon: const Icon(Icons.shopping_cart),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const ViewCartWidget()),
        );
      },
      ),
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ],
      bottom: AppBar(
      title: Container(
      width: double.infinity,
      height: 40,
      color: Colors.white,
      child: const Center(
      child: TextField(
      decoration: InputDecoration(
      hintText: 'Search for medicine',
      prefixIcon: Icon(Icons.search),
     suffixIcon: Icon(Icons.cancel)),
      ),
      ),
      ),
      ),
      ),
      // Other Sliver Widgets
      ],
      ),
    );
  }
}