class String
  def sluganize
    self.downcase.gsub(/[\s.\/_]/, ' ').squeeze(' ').strip.gsub(/[^\w- ]/, '').tr(' ', '-')
  end
end
