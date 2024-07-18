// import 'package:flutter/material.dart';
// void main(){
//   runApp(MaterialApp(
//     title: "Stateful app",
//     home: FavoriteCity(),
//
//   )
//   );
// }
// //stateful widjet returning State from createState() method
// class FavoriteCity extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _FavoriteCity();
//   }
//
// }
// //state class containing properties that may change
// class _FavoriteCity extends State<FavoriteCity>{
//   String nameCity='';
//   var _currencies=["ETB","DOLLARS","POUNDS","OTHERS"];
//   var _curentselection="ETB";
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(" my interest calculator"),
//
//
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: "enter city name",
//               ),
//               onChanged: (String userInput){
//                 //tell the framework to redraw the stateful widjet
//                 setState(() {
//                   nameCity=userInput;
//                 });
//               },
//             ),
//             DropdownButton<String>(
//               items: _currencies.map((String dropdoenitems){
//                 return DropdownMenuItem<String>(
//                   value: dropdoenitems,
//                   child: Text(dropdoenitems),
//                 );
//               }).toList(),
//               onChanged: (String ? currentvalue) {
//                 setState(() {
//                   this._curentselection=currentvalue!;
//                 });
//               },
//               value: _curentselection,
//
//             ),
//             Padding(
//               child:Text("your best city is $nameCity",
//               style: TextStyle(
//                 fontSize: 20.0,
//               ),
//               ),
//               padding: EdgeInsets.all(20.0),
//
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Interest Calculator",
    home: SIForm(),
    theme: ThemeData(primaryColor: Colors.indigo, brightness: Brightness.dark),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<SIForm> createState() {
    return _SIFormState();
  }
}
class _SIFormState extends State<SIForm> {
  var _formKey=GlobalKey<FormState>();
  final _currencies = ['ETB', 'Dollars', 'Pounds', 'Yuan'];
  final _minimalMargin = 0.5;
  String _selectedValue = '';
  TextEditingController principalcontroller = TextEditingController();
  TextEditingController IRcontroller = TextEditingController();
  TextEditingController Termlcontroller = TextEditingController();
  var displayResult = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedValue=_currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(

        key:_formKey,
      child: Padding(

        padding: EdgeInsets.all(14.0),
        child: ListView(
          children: [
            getImage(),
            Padding(

              padding: EdgeInsets.only(top: _minimalMargin),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    color:Colors.yellowAccent,
                    fontSize: 15.6
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  labelText: "Principal",
                  hintText: "Enter a number, e.g., 231 or 3432.8",
                  hintStyle: TextStyle(color: Colors.lime, fontSize: 20.0),
                ),
                controller: principalcontroller,
                  validator: (String? value) {
                  if (value=="") {
                    return "please enter principal";
                  }
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minimalMargin * 10),
              child: TextFormField(
                controller: IRcontroller,
                validator: (String? value) {
                  if (value=="") {
                    return "please enter Interst Rate";
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly,
                ],

                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 15.6
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Interest Rate",
                  hintText: "Enter a number",
                  hintStyle: TextStyle(color: Colors.lime, fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minimalMargin * 20),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                    controller: Termlcontroller,
                    validator: (String ?value){
                          if(value==""){
                            return "please enter term ";
                          }
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.6
                      ),
                        labelText: "Term",
                        hintText: "enter year length",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),

                        )),
                  )),
                  Container(width: _minimalMargin * 10),
                  DropdownButton<String>(
                    items: _currencies.map(
                      (String dropDownItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownItem,
                          child: Text(dropDownItem,
                          style: TextStyle(
                              fontSize: 20.0
                          ),
                          ),
                        );
                      },
                    ).toList(),
                    value: _selectedValue,
                    onChanged: (String? newValueSelected) {
                      _onDropDownSelected(newValueSelected);
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                bottom: _minimalMargin *3,
                top: _minimalMargin * 10,
                right: _minimalMargin * 2,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.greenAccent,
                      ),
                      child: Text("Calculate",
                        style: TextStyle(
                          fontSize: 23.0
                        ),
                      )
                      ,
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState!.validate()) {
                            this.displayResult = _calculateTotalInterest();
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                      width: 12.0
                  ), // Add horizontal space between the buttons
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      child: Text("Reset",
                          style: TextStyle(
                              fontSize: 23.0
                          ),
                      ),
                      onPressed: () {
                        _resetInput();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                 this.displayResult,
                style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 20.0),

              ),
            )
          ],
        ),
      ),
      ),
    );
  }

  void _onDropDownSelected(String? newValueSelected) {
    if (newValueSelected != null) {
      setState(() {
        _selectedValue = newValueSelected;
      });
    }
  }
  Widget getImage() {

    AssetImage assetImage = AssetImage("images/money.png");
    Image image = Image(
      image: assetImage,
      // width: 30.0,
      height: 200.0,
    );
    Widget myContainer=Container(

      margin: EdgeInsets.all(_minimalMargin * 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: image,
       //you can return
        // Container(
        //   child: image,
        //   margin: EdgeInsets.all(_minimalMargin * 10),
        // );
      ),
    );
    return myContainer;

  }
  String _calculateTotalInterest() {
    double principal = double.parse(principalcontroller.text);
    double ir = double.parse(IRcontroller.text);
    double term = double.parse(Termlcontroller.text);

    double totalPayable = principal + (principal * ir * term) / 100;

    String result =
        "After $term year,ur investment will be worth $totalPayable $_selectedValue";
    return result;
  }

  void _resetInput(){
    principalcontroller.text='';
    IRcontroller.text='';
    Termlcontroller.text='';
    _selectedValue=_currencies[0];
    displayResult='';
    // Do something
  }

}
