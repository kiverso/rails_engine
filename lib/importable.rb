require 'csv'
module Importable
  def from_csv(filepath)
    CSV.foreach(filepath, :headers => true) do row
      binding.pry
    end
  end
end