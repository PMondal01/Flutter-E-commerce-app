import 'dart:io';

import 'package:class_five/db/db_sqlite.dart';
import 'package:class_five/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {

  final Product product;
  final Function callback;
  ProductItem(this.product, this.callback);
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        child: Icon(Icons.delete, color: Colors.white, size: 60,),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
        builder: (context) => AlertDialog (
          title: Text('Delete ${widget.product.name}?'),
          content: Text('Are you sure to Delete?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            RaisedButton(
              child: Text('Delete'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ));
      },
      onDismissed: (directtion){
        DBSqlite.deleteProduct(widget.product.id).then((value) => widget.callback());
      },
      key: ValueKey(widget.product.id),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        elevation: 5,
        child: Column(
          children: <Widget>[
            Image.file(File(widget.product.imagePath),height: 200, width: double.infinity,fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.name,style: TextStyle(fontSize: 16),overflow: TextOverflow.ellipsis,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('TK.${widget.product.price}',style: TextStyle(fontSize: 14),),
            ),

          ]
        ),
      ),
    );
  }
}
