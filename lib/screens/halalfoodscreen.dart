import 'package:flutter/material.dart';
import 'package:praytime/halalfoodlist.dart';

HalalFoodList halalFoodList = HalalFoodList();

class HalalFoodScreen extends StatefulWidget {
  const HalalFoodScreen({super.key});

  @override
  State<HalalFoodScreen> createState() => _HalalFoodScreenState();
}

class _HalalFoodScreenState extends State<HalalFoodScreen> {
  final TextEditingController _countryNameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String country = '';
  String countryName = '';


  List<dynamic> _filteredItems = [];

  void _filterItems(String query) {
    setState(() {
      _filteredItems = halalFoodList.listOfFoods
          .where(
              (item) => item.region.toLowerCase().contains(query.toLowerCase()))
          .toList();
      country = query;
    });
  }

  @override
  void initState() {
    _filterItems('pakistan');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halal Food'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _countryNameController,
              focusNode: _focusNode,
              onChanged: (query) {
                countryName = query;
              },
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Enter Country Name',
                filled: true,
                fillColor: Colors.white,
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  onPressed: () {
                    _filterItems(countryName.trim());
                    _countryNameController.clear();
                    _focusNode.unfocus();
                  },
                  icon: const Icon(Icons.search),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Expanded(
              child: Text(
                'Halal Food in $country',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 4,
                          child: Column(
                            children: [
                              Text(
                                _filteredItems[index].title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(
                                height: 14.0,
                              ),
                              Image.asset(
                                _filteredItems[index].image,
                                fit: BoxFit.cover,
                                height: 350,
                                width: double.infinity,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ); // Display image from URL
              },
            ),
          ),
        ],
      ),
    );
  }
}
