class String
  def unjumble
    self.gsub(/[A-Za-z]+/) do |match|
      if match.size < 4
        match
      else
        chars = match.split(//)
        [chars[0], *chars[1..-2].sort, chars[-1]].join('')
      end
    end
  end

  def unjumble_re
    self.unjumble.gsub(/\s+/, '\s+')
  end
end
