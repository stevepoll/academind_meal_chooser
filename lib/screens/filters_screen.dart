import 'package:flutter/material.dart';
import 'package:meal_chooser/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Map<String, bool> filters;
  final Function saveFilters;

  FiltersScreen(this.filters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget _buildSwitchListTile(String title) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text('Only include ${title.toLowerCase()} meals'),
      value: widget.filters[title],
      onChanged: (newValue) {
        setState(() {
          widget.filters[title] = newValue;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => widget.saveFilters(context),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile('Gluten-free'),
                _buildSwitchListTile('Lactose-free'),
                _buildSwitchListTile('Vegetarian'),
                _buildSwitchListTile('Vegan'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
