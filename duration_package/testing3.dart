class Item implements Comparable<Item> {
  int id;
  String name;
  int price;

  Item({this.id = 0, this.name = "", this.price = 0});

  String toString() {
    return "$name-$price";
  }

  int compareTo(Item other) {
    return this.price - other.price;
  }
}

void main() {
  Item item1 = new Item(id: 1, name: "Item one", price: 1000);
  Item item2 = new Item(id: 2, name: "Item two", price: 2000);
  Item item3 = new Item(id: 3, name: "Item three", price: 500);
  Item item4 = new Item(id: 4, name: "Item four", price: 1000);

  List<Item> ls = [item1, item2, item3, item4];
  // Comparator<Item> priceCompare = (a, b) => a.price.compareTo(b.price);
  ls.sort();
  print(ls);
}
