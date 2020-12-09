import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cart.dart';
import 'item.dart';
import 'items.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int total =  0;
  double amount = 0;

  final amt = TextEditingController();

  @override
void dispose() {
// Clean up the controller when the Widget is disposed
amt.dispose();
super.dispose();
}
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "SAHAYAK",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),

      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("SAHAYAK",
          style: GoogleFonts.roboto( 
                  textStyle: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    
                  ),),),
        ),

        body: Padding(
        padding: EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.90,
          ),
          
          itemCount: items.length,
          itemBuilder: (context,index) => Container(
            width: 300,
            height: 500,
            child: GestureDetector(
                child: Card(
                elevation: 2,
          color: Colors.white,
                shape: RoundedRectangleBorder(
                  
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Colors.amber,
                    width: 2,
                   )
                ),
                margin: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Spacer(),

                    Text(items[index].name, 
                    style: GoogleFonts.roboto( 
                    textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      
                    ),),
                   ),

                    Image(image: items[index].image,
                      fit: BoxFit.contain,
                      height: 100,
                      width: 100,),

                      Spacer(),
                    
                    Text("Price : ",
                    style: GoogleFonts.roboto( 
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      
                    ),),),
                    
                    Text("${items[index].price} Rs. per ${items[index].unit}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto( 
                  
                    textStyle: TextStyle(
            
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      
                    ),),),

                    Spacer(),
                  ],
                ),
              ),

              onTap: (){

                showDialog(
                  context: context,
                builder: (context) => AlertDialog(
                  title: Text("Enter Quantity"),

                  content: TextFormField(
                    cursorHeight: 30,
                    keyboardType: TextInputType.numberWithOptions(signed: false),
                    controller: amt,
                   
                    decoration: InputDecoration(
                        icon: Icon(Icons.shopping_bag_outlined),
                        labelText: 'Quantity',
                        suffix: Text("in ${items[index].unit}"),
                  ),
                ),

                actions: [
                  TextButton(
                    child: Text("Add to Cart"),
                    
                    onPressed: (){
                      Cart.cartAdd(items[index], double.parse(amt.text));
                   
                      setState(() {
                    Cart.data += "${amt.text} ${items[index].unit} ${items[index].name}\n";
                     amt.clear();
                }); 

                Navigator.of(context).pop();
                    },
                  )
                ]

                )
                );
              },
            ),
          ),
        ),
      ),

    floatingActionButton: Builder(builder: (context) => FloatingActionButton(
          onPressed:  () {
            Navigator.push(context, MaterialPageRoute( builder: (context) => Cart(),));
          },
          child: Icon(Icons.shopping_cart_outlined),
        ),),
      ),
    );
  }
}
