class String
  def is_integer?
    self.to_i.to_s == self
  end

  def equals? str
    self == str
  end

  def to_get_param
    self.gsub(' ', '%20')
  end
end