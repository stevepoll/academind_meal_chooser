import 'package:flutter/material.dart';
import 'package:meal_chooser/dummy_data.dart';
// import 'package:meal_chooser/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal_detail';

  final Function toggleFave;
  final Function isFavorite;

  MealDetailScreen(this.isFavorite, this.toggleFave);

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildListContainer({@required child}) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    final ingredients = selectedMeal.ingredients;
    final steps = selectedMeal.steps;

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(context, 'Ingredients'),
            _buildListContainer(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        ingredients[index],
                      ),
                    ),
                  );
                },
                itemCount: ingredients.length,
              ),
            ),
            _buildSectionTitle(context, 'Steps'),
            _buildListContainer(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  height: 5,
                  color: Theme.of(context).accentColor,
                  thickness: 2,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(steps[index]),
                    ),
                  );
                },
                itemCount: steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isFavorite(mealId) ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
        onPressed: () => toggleFave(mealId),
      ),
    );
  }
}
