// File for getting the price of any APT  from the DEX using Postgres instead of http
import 'package:get_storage/get_storage.dart';
import 'package:postgres/postgres.dart';

// This has to be rewritten into functional paradigm, it's not meant to be an object, instead an instantiable process (querying and returning results)
late PostgreSQLConnection connection;

final athletePrice = (String name) async {
  print("QUERY: this came in: $name");

  List<List<dynamic>> results = await connection.query(
      "SELECT @name, first(price) as StartingPrice, last(price) as LatestPrice from nfl",
      substitutionValues: {"name": name});

  for (final row in results) {
    var a = row[0];
    var b = row[0];
    return "results: $a \n $b";
  }
};

// This opens up a stream that
void getMarketPrice(String $name) async {
  // This is a stream maybe that returns a consistent value ?
  // Stream per athlete page ?
  connection = PostgreSQLConnection("139.99.74.201", 8812, "qdb",
      username: "admin", password: "quest");
  await connection
      .open()
      .then((value) => {print('Connection confirmed /n $value')});
  print('[Postgres] Attempting Connection to Database');
}

void getLatestBookPrice(String name) async {
  connection = PostgreSQLConnection("139.99.74.201", 8812, "qdb",
      username: "admin", password: "quest");
  await connection.open();
  List<List<dynamic>> results = await connection.query(
      "SELECT @name, first(price) as StartingPrice, last(price) as LatestPrice from nfl",
      substitutionValues: {"name": name});
  for (final row in results) {
    var a = row[0];
    var b = row[1];
    print('Return Values $a, $b');
  }
}

void update() async {
    connection = PostgreSQLConnection("139.99.74.201", 8812, "qdb",
      username: "admin", password: "quest");
  await connection.open();
  List<List<dynamic>> results = await connection.query("SELECT name, last(price) from nfl");
  for (var aResult in results) {
    
  }

}

// // Hi Marcos
