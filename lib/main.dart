import 'package:flutter/material.dart';
import 'package:food_app/detail_screen.dart';

import 'model/delivery_food.dart';
import 'model/food.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
              color: Color(0xFFF1EFEF),
              textTheme: TextTheme(
                  title: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18)))),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Food App Showcase"),
          ),
          body: SingleChildScrollView(
            child: OrientationBuilder(
              builder: (orientationContext, orientation) {
                return Column(
                  children: <Widget>[
                    getHeader(orientationContext),
                    getSearchWidget(orientationContext),
                    getFoodItemCount(orientationContext, this.foods),
                    SizedBox(
                      height:
                          MediaQuery.of(orientationContext).size.height * 0.45,
                      child: getDeliveryPendingFoodListWidget(
                          orientationContext, this.deliveryFoods),
                    ),
                  ],
                );
              },
            ),
          ),
          backgroundColor: Color(0xFFF1EFEF)),
    );
  }

  Widget getHeader(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 25.0),
            child: Text(
              "FIND YOUR",
              style: TextStyle(fontSize: 15.0),
            )),
        Container(
          margin: EdgeInsets.only(top: 12, bottom: 20),
          child: Text(
            "Favourite Food",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
        )
      ],
    );
  }

  Widget getSearchWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.only(left: 18, right: 18),
      height: 35,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Color(0xffC9C9C9),
            ),
          ),
          Expanded(
              child: TextFormField(
            style: TextStyle(color: Color(0xff333333)),
            decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Color(0xFF333333))),
          )),
          IconButton(
            icon:
                Icon(Icons.settings_input_component, color: Color(0xffFF711B)),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 16, color: Colors.white, offset: Offset(0, 8.0))
          ]),
    );
  }

  Widget getFoodItemCount(final BuildContext context, final List<Food> foods) {
    List<Widget> foodWidgets = [];
    for (Food food in foods) {
      foodWidgets.add(getFoodItem(
          context, Food(food.foodName, food.foodImg, food.foodCount)));
    }

    return Container(
      margin: EdgeInsets.only(top: 30.0, bottom: 15.0),
      padding: EdgeInsets.only(top: 18, bottom: 18),
      child: Row(
          children: foodWidgets,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.white),
    );
  }

  Widget getFoodItem(final BuildContext context, final Food food) {
    double itemMargin = 8;
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: itemMargin),
        child: Image.asset(
          food.foodImg,
          width: 25,
          height: 25,
        ),
      ),
      Container(
        child: Text(food.foodName),
        margin: EdgeInsets.only(bottom: itemMargin),
      ),
      Container(
        color: Colors.orange,
        width: 2,
        height: 15,
        margin: EdgeInsets.only(bottom: itemMargin),
      ),
      Text(food.foodCount)
    ]);
  }

  List<Food> foods = [];
  List<DeliveryFood> deliveryFoods = [];

  App() {
    foods.add(Food("Burger", "img/burger.png", "15"));
    foods.add(Food("Pizza", "img/cheese.png", "18"));
    foods.add(Food("Rolls", "img/plate.png", "12"));
    foods.add(Food("Soup", "img/rotti.png", "20"));

    deliveryFoods.add(DeliveryFood(
        "img/burger1.png", "\$20", "Burger", "4.5", "20", Colors.yellow.value));
    deliveryFoods.add(DeliveryFood(
        "img/burger1.png", "\$20", "Burger", "4.5", "20", Colors.cyan.value));
    deliveryFoods.add(DeliveryFood(
        "img/burger1.png", "\$20", "Burger", "4.5", "20", Colors.green.value));
    deliveryFoods.add(DeliveryFood(
        "img/burger1.png", "\$20", "Burger", "4.5", "20", Colors.purple.value));
  }
}

Widget getDeliveryPendingFoodItemWidget(
    BuildContext context, DeliveryFood food) {
  Size size = MediaQuery.of(context).size;
  double height = size.height * 0.40;
  double width = size.height * 0.25;
  return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => FoodDetailScreen(food)));
    },
    child: Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: 25, top: 25, bottom: 25),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  child: Container(
                    padding: EdgeInsets.all(18.0),
                    child: Image.asset(
                      food.foodImg,
                      width: width * .60,
                      height: width * .60,
                      fit: BoxFit.fill,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                  margin: EdgeInsets.only(top: width * 0.10),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  width: width * .75,
                  height: width * .75),
              Positioned(
                child: Container(
                    child: Center(
                      child: Text(food.price),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.orange)),
                width: 50,
                height: 50,
                right: 1,
                bottom: 1,
              )
            ],
          ),
          Text(
            food.foodName,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Text(" " + food.rating + " " + " - " + food.time + " mins"),
                ],
              ))
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.6), color: Color(food.color)),
    ),
  );
}

Widget getDeliveryPendingFoodListWidget(
    BuildContext orientationContext, List<DeliveryFood> foods) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: foods.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return getDeliveryPendingFoodItemWidget(
            orientationContext, foods[index]);
      });
}
