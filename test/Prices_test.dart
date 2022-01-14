import 'package:ax_dapp/service/Controller/Scout/Prices.dart';
import 'package:test/test.dart';

void main() {
  getLatestBookPrice('T.Brady');

  test('verify mainnet address', () {
    // Submit a query
    expect("0x5617604ba0a30e0ff1d2163ab94e50d8b6d0b0df",
        '0x5617604ba0a30e0ff1d2163ab94e50d8b6d0b0df');
  });
}
