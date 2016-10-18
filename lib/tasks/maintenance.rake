namespace :maintenance do
  desc 'truncate tables'
  task :truncate_tables => :environment do |t, args|
    ActiveRecord::Base.connection.tables.each do |table_name|
      if table_name == 'schema_migrations' || table_name == 'ar_internal_metadata'
        next
      end
        ActiveRecord::Base.connection.execute("TRUNCATE #{table_name} RESTART IDENTITY")
    end
  end
end
