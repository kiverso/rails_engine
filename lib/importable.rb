require 'csv'
module Importable
  def from_csv(filepath)
    CSV.foreach(filepath, :headers => true) do |row|
      row_as_hash = row.to_hash
      if row_as_hash['unit_price']
        row_as_hash['unit_price'] = ((row_as_hash['unit_price'].to_f)/ 100.00)
      end
      self.create!(row_as_hash)
    end
  end
end