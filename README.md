# Polynomial

## Description
Polynomial is a library for dealing with polynomials.

## Getting Started
You can initialize polynomials with an array or hash. The polynomial <tt>3x^2 + 1</tt> could be initialized with `Polynomial.new([1,0,3])` or directly with `Polynomial.new({0 => 1, 2 => 3})`.

The coefficients are accessible through the `Polynomial#coefficients` method. It will return a hash of non zero coefficients. Single coefficients are accessible via `Polynomial#[]`.

    p = Polynomial.new({0 => 1, 2 => 3})
    
    p.coefficients # => {0 => 1, 2 => 3}
    
    p[0] # => 1
    p[36] # => 0

## License
Copyright (c) 2010 Tobias Bühlmann

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

