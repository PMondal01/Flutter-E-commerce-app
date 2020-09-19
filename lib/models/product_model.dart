final String TABLE_PRODUCT = 'tbl_product';
final String COL_PRODUCT_ID = 'pro_id';
final String COL_PRODUCT_NAME = 'pro_name';
final String COL_PRODUCT_PRICE = 'pro_price';
final String COL_PRODUCT_CATEGORY = 'pro_category';
final String COL_PRODUCT_DATE = 'pro_date';
final String COL_PRODUCT_IMAGE = 'pro_image';



class Product {
  int id;
  String name;
  double price;
  String category;
  String date;
  String imagePath;

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      COL_PRODUCT_NAME : name,
      COL_PRODUCT_PRICE : price,
      COL_PRODUCT_CATEGORY : category,
      COL_PRODUCT_DATE : date,
      COL_PRODUCT_IMAGE : imagePath
    };

    if ( id!=null){
      map[COL_PRODUCT_ID] = id;
    }
    return map;
  }

  Product.fromMap(Map<String,dynamic> map){

    id = map[COL_PRODUCT_ID];
    name = map[COL_PRODUCT_NAME];
    price = map[COL_PRODUCT_PRICE];
    category = map[COL_PRODUCT_CATEGORY];
    date = map[COL_PRODUCT_DATE];
    imagePath = map[COL_PRODUCT_IMAGE];
  }

  Product({this.id, this.name, this.price, this.category, this.date, this.imagePath});

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, category: $category, date: $date, imagePath: $imagePath}';
  }
}