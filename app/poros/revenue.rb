class Revenue
  attr_reader :id, :revenue
  def initialize(revenue)
    @id = nil
    @revenue = revenue.to_f
  end
end