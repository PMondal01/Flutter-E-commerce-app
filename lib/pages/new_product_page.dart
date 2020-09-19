import 'dart:io';
import 'dart:math';

import 'package:class_five/db/db_sqlite.dart';
import 'package:class_five/models/product_model.dart';
import 'package:class_five/utils/product_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewProductPage extends StatefulWidget {
  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final _formKey=GlobalKey<FormState>();
  Product product=Product();
  String category='Electronics';
  String date= null;
  String imagePath=null;

  void pickDate() {
         showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
    ).then((dateTime) {
      setState(() {
        date= DateFormat('dd/MM/yyyy').format(dateTime);
      });
      product.date=date;
         });
  }

  void takePicture() async{

    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      imagePath=pickedFile.path;
    });
    product.imagePath=imagePath;

/*    ImagePicker().getImage(source: ImageSource.camera).then((file){
      print(file.path);
      setState(() {
        imagePath=file.path;
      });
      product.imagePath=imagePath;
    });*/
  }

  void _saveProduct(){
     if(_formKey.currentState.validate()){
       _formKey.currentState.save();
       if(date==null){
         return;
       }
       print(product);
      // DBSqlite.productList.add(product);
       //Navigator.pop(context);
       DBSqlite.insertProduct(product).then((id) {
         if(id > 0) {
           Navigator.pop(context);
         }else{
           print('failed to save');
         }
       });
     }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Product Name'
                ),
                validator: (value){
                  if(value.isEmpty && value.length<0){
                    return 'This field is required';
                  }
                  return null;
                },
                onSaved: (value){
                  product.name=value;
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Product Price'
                ),
                validator: (value){
                  if(value.isEmpty && value.length<0){
                    return 'This field is required';
                  }
                  if(double.parse(value)<0.0){
                    return 'Insert correct amount';
                  }
                  return null;
                },
                onSaved: (value){
                  product.price=double.parse(value);
                },
              ),
              SizedBox(height: 30,),
              Text('Select Category'),
              DropdownButton(
                value: category,
                onChanged: (value){
                  setState(() {
                    category=value;
                  });
                  product.category = category;
                },
                items: categoryList.map((c) => DropdownMenuItem(
                  value: c,
                  child: Text(c),
                )).toList(),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>  [
                  FlatButton(
                    child: Text('Select Date'),
                    onPressed: pickDate ,
                  ),
                  Text( date == null ? 'No Date Selected': date, style: TextStyle(fontSize: 16),)
                ],
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border:Border.all(width: 2,color: Colors.grey)
                    ) ,
                    child:imagePath== null ? Text('') : Image.file(File(imagePath)),
                  ),
                  FlatButton.icon(onPressed: takePicture, icon: Icon(Icons.camera), label: Text('select image'))
                ],
              ),
              SizedBox(height: 50,),
              RaisedButton(
                shape: StadiumBorder(side: BorderSide()),
                color: Colors.blue,
                child: Text('Save',style: TextStyle(color: Colors.white),),
                onPressed: _saveProduct,
              )
            ],
          ),
        ),
      )
    );
  }
}
