class Capital
  attr_reader :name

  def initialize(data)
    @name = data[:capital].first
  end
end
