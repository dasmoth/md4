library test_md4;

import 'package:unittest/unittest.dart';
import 'package:md4/md4.dart';

/**
 * Turn an array of bytes into a printable hex string
 */

String octetsToHexString(List<int> octets) {
  StringBuffer sb = new StringBuffer();
  sb.writeAll(octets.map((int o) {
    String s = o.toRadixString(16);
    while (s.length < 2) {
      s = '0' + s;
    }
    return s;
  }));
  return sb.toString();
}

/**
 * Calculate the MD4 of a string, and convert to a hex string for easy checking.
 */

String md4(String input) {
  List<int> l = input.codeUnits;
  MD4 md4 = new MD4();
  md4.add(l);
  return octetsToHexString(md4.close());
}

void main() {
  test('md4', () {
    // Standard MD4 test vectors taken from RFC1320.         
    
    expect(md4(''), 
        equals('31d6cfe0d16ae931b73c59d7e0c089c0'));
    expect(md4('a'),
        equals('bde52cb31de33e46245e05fbdbd6fb24'));
    expect(md4('abc'),
        equals('a448017aaf21d8525fc10ae87aa6729d'));
    expect(md4('message digest'),
        equals('d9130a8164549fe818874806e1c7014b'));
    expect(md4('abcdefghijklmnopqrstuvwxyz'),
        equals('d79e1c308aa5bbcdeea8ed63df412da9'));
    expect(md4('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),
        equals('043f8582f241db351ce627e153e7f0e4'));
    expect(md4('12345678901234567890123456789012345678901234567890123456789012345678901234567890'),
        equals('e33b4ddc9c38f2199c3e7b164fcc0536'));
  });
}