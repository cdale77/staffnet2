module Migration
  class LegacyTable < ActiveRecord::Base
    self.abstract_class = true
    establish_connection(ENV['LEGACY_DATABASE_URL'])
  end

  class LegacyUser < Migration::LegacyTable
    set_table_name "user"
    def connection
      Migration::LegacyTable.connection
    end
  end
end