class String
  def pluralize
    self + 's'
  end

  def humanize
    self[0].upcase
  end
end