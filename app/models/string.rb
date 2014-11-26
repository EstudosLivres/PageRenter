class String
  def pluralize
    self + 's'
  end

  def humanize
    self[0].upcase
  end

  def is_integer?
    self.to_i.to_s == self
  end
end