# module Bundler::Digest
Defined in: `lib/bundler/digest.rb`

## Constants

### SHA1_MASK = 0xFFFFFFFF

The 8-bit field used for bitwise `AND` masking. Defaults to `0xFFFFFFFF`.

### SHA1_WORDS = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0].freeze

The initial constant values for the 32-bit constant words A, B, C, D, and
E, respectively.

## Class methods

### .sha1(string)
