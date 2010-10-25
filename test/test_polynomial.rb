$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'test_helper'
require 'polynomial'
require 'rational' if RUBY_VERSION < '1.9'

class TestPolynomial < Test::Unit::TestCase
  def setup
    @p = Polynomial.new([1,2,3])
    @h = Polynomial.new({0 => 1, 1 => 2, 2 => 3})
  end

  def test_initialization
    assert_equal(@p.coefficients, @h.coefficients)
    assert_equal({}, Polynomial.new.coefficients)
    assert_equal(0, @p.coefficients[42])
    assert_equal(0, @h.coefficients[42])

    assert_raise TypeError do
      Polynomial.new(:foo)
    end

    assert_raise TypeError do
      Polynomial.new([1,2, :foo])
    end
  end

  def test_assign_value
    p = Polynomial.new
    p[1] = 1
    assert_equal({1 => 1}, p.coefficients)
  end

  def test_assign_with_zero
    p = Polynomial.new
    p[1] = 0
    assert_equal({}, p.coefficients)
  end

  def test_equality_of_different_types
    assert_equal({0 => 1, 1 => 2, 2 => 3}, @p.coefficients)
    assert_equal({0 => 1.0, 1 => 2.0, 2 => 3.0}, @p.coefficients)
    assert_equal({0 => Rational(1, 1), 1 => Rational(2, 1), 2 => Rational(3, 1)}, @p.coefficients)
  end

  def test_remove_zeros
    assert_equal({}, Polynomial.new.coefficients)
    assert_equal({}, Polynomial.new([0]).coefficients)
    assert_equal({}, Polynomial.new([0,0,0]).coefficients)
    assert_equal({1 => 2}, Polynomial.new([0, 2, 0]).coefficients)
  end

  def test_degree
    assert_equal(2, @p.degree)
    assert_equal(4, Polynomial.new([1,0,0,0,1]).degree)
    assert_equal(-Math::INFINITY, Polynomial.new([0]).degree)
    assert_equal(-Math::INFINITY, Polynomial.new([0,0,0,0,0]).degree)
    assert_equal(0, Polynomial.new([2]).degree)
  end

  def test_negate
    assert_equal({}, Polynomial.new.negate!.coefficients)
    assert_equal({0 => -1, 1 => -2, 2 => -3}, @p.negate!.coefficients)
    assert_equal({0 => -2}, Polynomial.new([4.0/2.0]).negate!.coefficients)

    assert_equal({0 => -1, 1 => -2}, (-Polynomial.new([1,2])).coefficients)
  end

  def test_get_coefficient
    assert_equal(2, @p[1])
  end

  def test_addition
    p1 = Polynomial.new([1,3])
    p2 = Polynomial.new([2,4])

    assert_equal({0 => 3, 1 => 7}, (p1 + p2).coefficients)
    assert_equal({0 => 1, 1 => 3}, p1.coefficients)
    assert_equal({0 => 2, 1 => 4}, p2.coefficients)

    assert_not_equal(p1, p1 + Polynomial.new)
    assert_not_equal(p1, Polynomial.new + p1)
  end

  def test_subtraction
    p1 = Polynomial.new([1,3])
    p2 = Polynomial.new([2,4])

    assert_equal({0 => -1, 1 => -1}, (p1 - p2).coefficients)
    assert_equal({0 => 1, 1 => 3}, p1.coefficients)
    assert_equal({0 => 2, 1 => 4}, p2.coefficients)

    assert_not_equal(p1, p1 - Polynomial.new)
  end

  def test_multiplication
    # (3x + 1)*(4x - 2) = 12x^2 - 2x - 2
    p1 = Polynomial.new([1,3])
    p2 = Polynomial.new([-2,4])

    assert_equal({0 => -2, 1 => -2, 2 => 12}, (p1 * p2).coefficients)
    assert_equal({0 => 1, 1 => 3}, p1.coefficients)
    assert_equal({0 => -2, 1 => 4}, p2.coefficients)

    assert_equal({}, (p1*Polynomial.new).coefficients)
    assert_equal({}, (Polynomial.new*p2).coefficients)

    assert_not_equal(p1, (p1*Polynomial.new([1])))
    assert_not_equal(p1, (Polynomial.new([1])*p1))
  end

  def test_polynomial_classes_by_degree
    assert(Polynomial.new.zero_polynomial?)
    assert(Polynomial.new([1]).constant?)
    assert(Polynomial.new([1,2]).linear?)
    assert(Polynomial.new([1,2,3]).quadratic?)
    assert(Polynomial.new([1,2,3,4]).cubic?)
    assert(Polynomial.new([1,2,3,4,5]).quartic?)
    assert(Polynomial.new([1,2,3,4,5]).biquadratic?)
    assert(Polynomial.new([1,2,3,4,5,6]).quintic?)
    assert(Polynomial.new([1,2,3,4,5,6,7]).sextic?)
    assert(Polynomial.new([1,2,3,4,5,6,7]).hexic?)
    assert(Polynomial.new([1,2,3,4,5,6,7,8]).septic?)
    assert(Polynomial.new([1,2,3,4,5,6,7,8]).heptic?)
    assert(Polynomial.new([1,2,3,4,5,6,7,8,9]).octic?)
    assert(Polynomial.new([1,2,3,4,5,6,7,8,9,10]).nonic?)
    assert(Polynomial.new([1,2,3,4,5,6,7,8,9,10,11]).decic?)
  end

  def test_leading_coefficient
    assert_equal(0, Polynomial.new.leading_coefficient)
    assert_equal(2, Polynomial.new([1,2,3,4,5,2]).leading_coefficient)

    assert(Polynomial.new([1,2,3,1]).monic?)
  end
end

