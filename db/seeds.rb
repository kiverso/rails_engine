# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.from_csv('db/csv_seeds/customers.csv')

Merchant.from_csv('db/csv_seeds/merchants.csv')

Invoice.from_csv('db/csv_seeds/invoices.csv')

Item.from_csv('db/csv_seeds/items.csv')

InvoiceItem.from_csv('db/csv_seeds/invoice_items.csv')

Transaction.from_csv('db/csv_seeds/transactions.csv')
