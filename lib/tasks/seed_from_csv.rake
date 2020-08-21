# frozen_string_literal: true

desc 'seeds the database, then resets the primary key sequence of each table'
task :seed_from_csv do
  Rake::Task['db:seed'].invoke
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.reset_pk_sequence!(table)
  end
end
