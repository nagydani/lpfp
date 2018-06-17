# Low-Precision Floating-Point Arithmetic Library for Z80

## Introduction
The purpose of this library is to provide fast floating-point operations for 
visualizations and simulations. In particular, 3D games and especially simulators 
can benefit from it. Extensive use of look-up tables and 8-bit arithmetics 
provide for adequate performance.

The library uses 9-bit mantissa in the \[1..2) range and 7 bit signed exponent.
It provides approx. 3 significant decimal digits of precision that allows it to 
accurately represent integers in the \[0..512\] range. This enables an angular 
resolution of almost 0.1 degree (for comparison, the Solar and Lunar discs are 
approx. 0.5 degrees in diameter) and sub-pixel resolution for the displays of 
typical 8-bit computers. The representable range is between (10⁻²⁰..10²⁰) giving 
the user more than 1000 light years or range if the unit is 1 meter or nanometer 
precision if the unit is 1 light second, in which case the entire observable 
universe fits into the range.

However, users must exercise extra caution with numerical stability when using 
low-precision floating-point arithmetics, as precision degrades very rapidly with 
accummulating errors. In particular, subtraction can be highly inaccurate and 
division by the result of a subtraction can arbitrarily magnify such errors.

The library also provides conversion into unsigned 64-bit integers (cannot 
overflow) as well as the means of calculating the remainder of a 64-bit integer 
after division by a floating-point number. This is useful for accurately 
representing time and cyclic events, such as the rotation and orbital movement 
of planets and other bodies.

## Specification

Floating-point numbers are represented as 16 bits, typically stored in Z80 register 
pairs. Bits are interpreted as follows:

bits| semantics
--- | ---
0-7 | Mantissa bits -8..-1. Mantissa bit 0 is always 1, not represented
8-14| Exponent bits 0..6. The actual exponent is this number minus 64. Thus, 64 corresponds to 0
15  | Sign. 0 for positive, 1 for negative

This representation provides for preserving lexicographic ordering for positive 
numbers.

No special values such as `0`, `Inf` or `NaN` are represented. Undeflows 
result in the smallest representable number, ε=2⁻⁶⁴. Please note that this number 
does not always behave as an algebraic zero. In particular, ε+ε≠ε even though 0+0=0. 
While it is generally advised to avoid checking for strict equality in most cases, 
strict equality with ε should never be used as a zero check. Overflows result in 
the largerst representable number, 2⁶⁴. This also does not behave as algebraic 
infinity in many cases. As there is no zero and no infinity, no operations can 
result in `NaN`. Every result is a number.
