Dart MD4 implementation
=======================

This is a simple implementation of the MD4 has function, following
closely from RFC1320.

Installation
------------

Add this to your `pubspec.yaml` (or create it):
```yaml
dependencies:
  md4: any
```
Then run the Pub Package Manager (comes with the Dart SDK):

    pub install

Usage
-----
 
The MD4 class should behave just like the existing hash functions in
`dart:crypto`.
 
 ```dart
import 'package:md4/md4.dart';

main() {
  MD4 md4 = new MD4();
  md4.add('Hello'.codeUnits);
  print md4.close();
}
```
