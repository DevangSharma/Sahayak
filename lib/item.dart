import 'package:flutter/material.dart';

class item 
{
  String name;
  int price;
  String unit;
  AssetImage image;
  

  item(String name, int price , String unit , String img)
  {
    this.name = name;
    this.price = price;
    this.unit = unit;
    this.image = AssetImage("images/${img}.jpg");
  }
}


TableRow tableR(item itm , double qty)
{
  return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: itm.image,
            height: 45,
            width: 45,
          )
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${itm.name}",
          textAlign: TextAlign.center,
           style: TextStyle(
 
          ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("$qty ${itm.unit}",
          textAlign: TextAlign.center,
           style: TextStyle(
        
          ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Rs. ${qty*itm.price}",
          textAlign: TextAlign.center,
           style: TextStyle(
            
          ),
          ),
        ),
      ] 
    );
}