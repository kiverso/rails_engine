class Transaction < ApplicationRecord
  belongs_to :invoice
  extend Importable
end
