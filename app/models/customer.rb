class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  extend Importable
end
