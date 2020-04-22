import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/delivery_food.dart';
import 'model/ingredient.dart';
import 'model/nutrition.dart';

class FoodDetailScreen extends StatelessWidget {
  DeliveryFood _deliveryFood;
  List<Nutrition> nutritions = [];
  List<Ingredient> ingrediens = [];

  FoodDetailScreen(this._deliveryFood) {
    nutritions.add(Nutrition("Colories", "266", "kcal"));
    nutritions.add(Nutrition("Protein", "12", "g"));
    nutritions.add(Nutrition("Sodium", "564", "mg"));
    nutritions.add(Nutrition("Cholesterol", "17", "mg"));
    nutritions.add(Nutrition("Iron", "34", "mg"));

    ingrediens.add(Ingredient("Cheese", "0.5"));
    ingrediens.add(Ingredient("Sauce", "2"));
    ingrediens.add(Ingredient("Daugh", "2"));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
              color: Color(0xFFF1EFEF),
              textTheme: TextTheme(
                  title: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18)))),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Food App Showcase"),
        ),
        body: SingleChildScrollView(
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              Size size = MediaQuery.of(context).size;
              return Container(
                height: size.height * 1.2,
                child: Stack(
                  children: <Widget>[
                    Image.asset("img/burger_big.png"),
                    Positioned(
                      height: size.height,
                      width: size.width,
                      child: Container(
                        padding: EdgeInsets.only(left: 30, top: 60),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45)),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Icon(Icons.star, color: Colors.orange),
                                  margin: EdgeInsets.only(right: 10),
                                ),
                                Text("Hello World"),
                              ],
                            ),
                            Container(
                              child: Text(
                                "Beef Burger",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 23),
                              ),
                              margin: EdgeInsets.only(top: 16),
                            ),
                            Container(
                              child: Text(
                                  "Donec laoreet varius ipsum a fermentum. Duis maximus vulputate tellus non vestibulum. Aenean volutpat "),
                              margin: EdgeInsets.only(top: 23, right: 30),
                            ),
                            getNutritionQuantityListWidget(nutritions),
                            getMainIngredientsListWidget(ingrediens)
                          ],
                        ),
                      ),
                      top: 300,
                    ),
                    Positioned(
                      height: 46,
                      width: 200,
                      top: 280,
                      left: (size.width / 2) - 100,
                      child: Container(
                        padding: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 6),
                                  blurRadius: 16)
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(23)),
                            color: Colors.white),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 46,
                              height: 46,
                              margin: EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.orange),
                              child: Center(child: Text("\$12", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
                            ),
                            Expanded(
                                child: Text(
                              "Add to Cart",
                              style: TextStyle(color: Colors.black),
                            )),
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.orange,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getNutritionQuantityListWidget(List<Nutrition> nutritions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 21, bottom: 12),
          child: Text(
            "Nutrition Quantity",
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: nutritions.length,
              itemBuilder: (BuildContext context, int index) {
                return getNutritionQuantityItemWidget(nutritions[index]);
              }),
        )
      ],
    );
  }

  Widget getNutritionQuantityItemWidget(Nutrition nutrition) {
    return Container(
      width: 80,
      height: 160,
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 18),
            height: 60,
            width: 60,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
            child: Center(
              child: Text(
                nutrition.volume,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          Container(
            child: Text(
              nutrition.name,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(bottom: 8),
          ),
          Text(
            nutrition.unit,
            style: TextStyle(color: Color(0xff999999)),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Color(0xFFFFF0E7)),
    );
  }

  Widget getMainIngredientsListWidget(List<Ingredient> ingredients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 21, bottom: 12),
          child: Text(
            "Main Ingrediants",
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                return getMainIngredientsItemWidget(ingredients[index]);
              }),
        )
      ],
    );
  }

  Widget getMainIngredientsItemWidget(Ingredient ingredient) {
    return Container(
      margin: EdgeInsets.only(right: 16, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            ingredient.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            ingredient.volume + " Cup",
            style: TextStyle(color: Color(0xff999999)),
          )
        ],
      ),
    );
  }
}
