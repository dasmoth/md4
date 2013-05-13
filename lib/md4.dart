library md4;

import 'dart:crypto';
import 'dart:math';

part 'src/hash-base.dart';

/**
 * MD4 hasher class, compatible with the hashers in dart:crypto.
 */

class MD4 extends _HashBase implements Hash {
  MD4() : super(16, 4, false)
  {
    _h[0] = 0x67452301;
    _h[1] = 0xefcdab89;
    _h[2] = 0x98badcfe;
    _h[3] = 0x10325476;
  }
  
  MD4 newInstance() {
    return new MD4();
  }
  
  // Compute one iteration of the MD4 algorithm with a chunk of
  // 16 32-bit pieces.
  _updateHash(List<int> m) {
    assert(m.length == 16);

    const int S11 = 3;
    const int S12 = 7;
    const int S13 = 11;
    const int S14 = 19;
    const int S21 = 3;
    const int S22 = 5;
    const int S23 = 9;
    const int S24 = 13;
    const int S31 = 3;
    const int S32 = 9;
    const int S33 = 11;
    const int S34 = 15;

    int F(int x, int y, int z) => (((x) & (y)) | ((~x) & (z)));
    int G(int x, int y, int z) => (((x) & (y)) | ((x) & (z)) | ((y) & (z)));
    int H(int x, int y, int z) => ((x) ^ (y) ^ (z));
    
    var a = _h[0];
    var b = _h[1];
    var c = _h[2];
    var d = _h[3];
    
    /*
     * We can get away with "normal" additions here, because
     * _rotl32 masks before shifting right
     */
    
    a = _rotl32(a + F(b, c, d) + m[0], S11);
    d = _rotl32(d + F(a, b, c) + m[1], S12);
    c = _rotl32(c + F(d, a, b) + m[2], S13);
    b = _rotl32(b + F(c, d, a) + m[3], S14);
    a = _rotl32(a + F(b, c, d) + m[4], S11);
    d = _rotl32(d + F(a, b, c) + m[5], S12);
    c = _rotl32(c + F(d, a, b) + m[6], S13);
    b = _rotl32(b + F(c, d, a) + m[7], S14);
    a = _rotl32(a + F(b, c, d) + m[8], S11);
    d = _rotl32(d + F(a, b, c) + m[9], S12);
    c = _rotl32(c + F(d, a, b) + m[10], S13);
    b = _rotl32(b + F(c, d, a) + m[11], S14);
    a = _rotl32(a + F(b, c, d) + m[12], S11);
    d = _rotl32(d + F(a, b, c) + m[13], S12);
    c = _rotl32(c + F(d, a, b) + m[14], S13);
    b = _rotl32(b + F(c, d, a) + m[15], S14);
  
    const int gc = 0x5a827999;
    a = _rotl32(a + G(b, c, d) + m[0] + gc, S21);
    d = _rotl32(d + G(a, b, c) + m[4] + gc, S22);
    c = _rotl32(c + G(d, a, b) + m[8] + gc, S23);
    b = _rotl32(b + G(c, d, a) + m[12] + gc, S24);
    a = _rotl32(a + G(b, c, d) + m[1] + gc, S21);
    d = _rotl32(d + G(a, b, c) + m[5] + gc, S22);
    c = _rotl32(c + G(d, a, b) + m[9] + gc, S23);
    b = _rotl32(b + G(c, d, a) + m[13] + gc, S24);
    a = _rotl32(a + G(b, c, d) + m[2] + gc, S21);
    d = _rotl32(d + G(a, b, c) + m[6] + gc, S22);
    c = _rotl32(c + G(d, a, b) + m[10] + gc, S23);
    b = _rotl32(b + G(c, d, a) + m[14] + gc, S24);
    a = _rotl32(a + G(b, c, d) + m[3] + gc, S21);
    d = _rotl32(d + G(a, b, c) + m[7] + gc, S22);
    c = _rotl32(c + G(d, a, b) + m[11] + gc, S23);
    b = _rotl32(b + G(c, d, a) + m[15] + gc, S24);
   
    const int hc = 0x6ed9eba1;
    a = _rotl32(a + H(b, c, d) + m[0] + hc, S31);
    d = _rotl32(d + H(a, b, c) + m[8] + hc, S32);
    c = _rotl32(c + H(d, a, b) + m[4] + hc, S33);
    b = _rotl32(b + H(c, d, a) + m[12] + hc, S34);
    a = _rotl32(a + H(b, c, d) + m[2] + hc, S31);
    d = _rotl32(d + H(a, b, c) + m[10] + hc, S32);
    c = _rotl32(c + H(d, a, b) + m[6] + hc, S33);
    b = _rotl32(b + H(c, d, a) + m[14] + hc, S34);
    a = _rotl32(a + H(b, c, d) + m[1] + hc, S31);
    d = _rotl32(d + H(a, b, c) + m[9] + hc, S32);
    c = _rotl32(c + H(d, a, b) + m[5] + hc, S33);
    b = _rotl32(b + H(c, d, a) + m[13] + hc, S34);
    a = _rotl32(a + H(b, c, d) + m[3] + hc, S31);
    d = _rotl32(d + H(a, b, c) + m[11] + hc, S32);
    c = _rotl32(c + H(d, a, b) + m[7] + hc, S33);
    b = _rotl32(b + H(c, d, a) + m[15] + hc, S34);

    _h[0] = _add32(a, _h[0]);
    _h[1] = _add32(b, _h[1]);
    _h[2] = _add32(c, _h[2]);
    _h[3] = _add32(d, _h[3]);
  }
}
