class Tag
  PROPERTIES = [:timestamp, :id, :name]
  PROPERTIES.each do |prop|
    attr_accessor prop
  end

  def initialize(hash = {})
    hash.each do |key, value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + "=").to_s, value)
      end
    end
  end
end