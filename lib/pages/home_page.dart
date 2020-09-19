import 'package:class_five/db/db_sqlite.dart';
import 'package:class_five/models/product_model.dart';
import 'package:class_five/pages/new_product_page.dart';
import 'package:class_five/utils/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void refresh() {
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title:Text('Product List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context)=> NewProductPage()
            )).then((_) {
              setState(() {
              });
            }),
          )
        ],
      ),
      body:
      FutureBuilder(
            future: DBSqlite.getAllProducts(),
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              if(snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: snapshot.data.map((product) => ProductItem(product, refresh)).toList(),

                );
              }
              if(snapshot.hasError) {
                return Center(child: Text('Failed to fetch data'),);
              }
              return Center(child: CircularProgressIndicator(),);
            }

        ),



      /* GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: DBSqlite.productList.map((product) => ProductItem(product)).toList(),),*/
    );
  }
}
