class String
  def sluganize
    self.downcase.gsub(/[\s.\/_]/, ' ').squeeze(' ').strip.gsub(/[^\w\s-]/, '').tr(' ', '-')
  end
end
