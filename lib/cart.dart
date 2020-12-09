import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'item.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:toast/toast.dart';

class Cart extends StatefulWidget {

  static double total = 0;
  static List<TableRow> cartItems = [];

  static String data = "";

  Cart({Key key}) : super(key: key);

  static cartAdd(item itm, double qty)
  {
    Cart.cartItems.add(tableR(itm,qty));

  Cart.total = Cart.total + qty*(itm.price);
  }

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  final number = TextEditingController();
  final name = TextEditingController();


TwilioFlutter twilioFlutter;

  @override
  void initState()
  {
    twilioFlutter = TwilioFlutter(

      accountSid: '--------------------------------',
      authToken: '-----------------------------------',
      twilioNumber: '---------------------',
    );

    super.initState();

  }

  void sendSms(String number, String name, String data) async{
    String sd = await twilioFlutter.sendSMS(toNumber: '+91$number', messageBody: "\nHello $name,\nDue to my poor health condition I can't go out for my daily needs,\nHence it would be a great help if you could deliver the following items to my home : \n$data\nMy details : \nName - Devang Sharma\nNumber - 7877857818\nAddress - Bada Bazar,Bikaner\nThankyou");
   
    Toast.show("Message Sent", context,duration: Toast.LENGTH_LONG);
  }
  
  height(context) => (MediaQuery.of(context).size.height - (kToolbarHeight ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
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

          padding: const EdgeInsets.all(0.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: Container(
                    height: height(context)*0.05,
                    child: ListTile(
                      title: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Listed Items",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      ),
                      
                      FlatButton(
                        child: Text("Clear Cart"),
                        color: Colors.amber[500],
                        onPressed: (){
                          setState(() {
                            Cart.data = "";
                            Cart.cartItems.clear();
                            Cart.total = 0;
                          });
                        },
                      )],)
                    
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, height(context)*0.01),
                  child:Container(
                    height: height(context)*0.01,
                    child: Table(

                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
      children: [
        Padding(
          padding:  EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text("Image",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          ),
        ),

        Padding(
          padding:  EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text("Item",
          textAlign: TextAlign.center,
           style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          ),
        ),

        Padding(
          padding:  EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text("Qty.",
          textAlign: TextAlign.center,
           style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          ),
        ),

        Padding(
          padding:  EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text("Price",
          textAlign: TextAlign.center,
           style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          ),
        ),

      ] 
    ),
                          ],
                        ),
                  ),
            
                ),

                Container(
                  height: height(context)*0.65,
                  child: SingleChildScrollView(
                          
                        child: Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: Cart.cartItems,
                          ),
                        ),
                ),
       
              ],
            ),
          ),
        ),

        bottomNavigationBar: BottomAppBar(
          
          child:  Container(
            height: height(context)*0.1,
            child: ListTile(
                      title: Text("Total Price : ${Cart.total}"),
                      tileColor: Colors.amber[100],
                      trailing: RaisedButton(
                        color: Colors.amber,
                        child: Text("Request Items"),
                        onPressed: ()
                        {
                          showDialog(
                  context: context,
                builder: (context) => AlertDialog(
                  title: Text("Enter Shopkeeper Details"),

                  content: SingleChildScrollView(
                                      child: Column(
                     
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                      cursorHeight: 30,
                      keyboardType: TextInputType.name,
                      controller: name,
                     
                      decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Name',
                    ),),

                    TextFormField(
                      cursorHeight: 30,
                      keyboardType: TextInputType.phone,
                      controller: number,
                     
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone_android),
                          labelText: 'Number',
                          prefix: Text('+91'),
                    ),),
                      ],
                    ),
                  ),
                   actions: [
                  TextButton(
                    child: Text("Request Items"),
                    
                    onPressed: (){

                     sendSms('${number.text}', '${name.text}', '${Cart.data}');
                      
                      setState(() {
                    //  data += "${amt.text} ${items[index].unit} ${items[index].name}\n";
                     number.clear();
                     name.clear();
                }); 

                Navigator.of(context).pop();
                    },
                  )
                ]
                ));
                
                        },
                      ),
                    ),
          ),
        ),

      );
  }
}