$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'core_ext/math'

class Polynomial
  attr_reader :coefficients

  def initialize(coefficients = {})
    @coefficients = Hash.new(0)

    case coefficients
    when Array
      coefficients.each_with_index do |value, index|
        self[index] = value
      end
    when Hash
      @coefficients.merge!(coefficients)
    when String
      raise NotImplementedError
    else
      raise TypeError, "Unsupported type: #{coefficients.class}"
    end
  end

  def [](coefficient)
    @coefficients[coefficient]
  end

  def []=(index, value)
    unless value.is_a?(Numeric)
      raise TypeError, "Unsupported type: #{value.class}"
    else
      @coefficients[index] = value if value != 0
    end
  end

  def +(polynomial)
    if zero_polynomial?
      self.class.new(polynomial.coefficients)
    elsif polynomial.zero_polynomial?
      self.class.new(@coefficients)
    else
      p = self.class.new(polynomial.coefficients)
      @coefficients.each do |k,v|
        p[k] += v
      end
      p
    end
  end

  def -(polynomial)
    p = self.class.new(polynomial.coefficients).negate!
    p + self
  end

  def *(polynomial)
    if zero_polynomial? || polynomial.zero_polynomial?
      self.class.new
    elsif @coefficients == {0 => 1}
      self.class.new(polynomial.coefficients)
    elsif polynomial.coefficients == {0 => 1}
      self.class.new(@coefficients)
    else
      p = self.class.new
      @coefficients.each do |k,v|
        polynomial.coefficients.each do |_k, _v|
          p[k+_k] += v*_v
        end
      end
      p
    end
  end

  def negate!
    @coefficients.each_key { |k| @coefficients[k] *= -1 }
    self
  end

  alias -@ negate!

  def degree
    if @coefficients.empty?
      # the degree of the zero polynomial is defined as -infinity
      -Math::INFINITY
    else
      @coefficients.keys.max
    end
  end

  def leading_coefficient
    if zero_polynomial?
      0
    else
      @coefficients[@coefficients.keys.max]
    end
  end

  def monic?
    leading_coefficient == 1
  end

  def zero_polynomial?
    degree == -Math::INFINITY
  end

  def constant?
    degree == 0
  end

  def linear?
    degree == 1
  end

  def quadratic?
    degree == 2
  end

  def cubic?
    degree == 3
  end

  def quartic?
    degree == 4
  end

  def quintic?
    degree == 5
  end

  def sextic?
    degree == 6
  end

  def septic?
    degree == 7
  end

  def octic?
    degree == 8
  end

  def nonic?
    degree == 9
  end

  def decic?
    degree == 10
  end

  alias :biquadratic? :quartic?
  alias :hexic? :sextic?
  alias :heptic? :septic?
end

