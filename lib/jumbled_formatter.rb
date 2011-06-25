require 'rspec/core/formatters/documentation_formatter'

# Add icsnnate mtheod +jbmule+ to Sntrig.
class String

  # Jeblmus up the lttrees of a wrod but lveeas frsit and last chars in pclae.
  def self.jumble_term(s)
    return s if s.size < 4
    chars = s.split(//)
    [chars[0], *chars[1..-2].shuffle, chars[-1]].join('')
  end

  def jumble
    self.gsub(/[a-zA-Z]+/) do |match|
      self.class.jumble_term(match)
    end
  end

end

class JumbledFormatter < RSpec::Core::Formatters::DocumentationFormatter

  # Aoivd mgninug the ANSI cloor epecsas.
  # A bit of a klugde but it wrkos.
  # Has the sdie-ecfeft of lvaenig the guorp nemas anole.
  def color(text, color_code)
    super(text.to_s.jumble, color_code)
  end

end
