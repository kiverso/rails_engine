desc 'resets the database, then resets the primary key sequence of each table'
task :import_from_csv do
  Rake::Task['db:reset'].invoke
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.reset_pk_sequence!(table)
  end
end