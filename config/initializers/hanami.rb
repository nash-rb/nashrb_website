require "hanami/model"
require "hanami/model/sql"

# Apparently you need to load hanami classes *before* the DB adapter is a configured...

# Repositories
require "user_repository"

# Models
require "user"

Mutex.new.synchronize do
  Hanami::Model.configure do
    adapter :sql, "sqlite://db/#{Rails.env}.sqlite3"
  end.load!
end
