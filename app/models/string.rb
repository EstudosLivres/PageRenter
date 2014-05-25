class String
  def pluralize
    self = self + 's'
  end

  def humanize
    self = self[0].upcase
  end
end