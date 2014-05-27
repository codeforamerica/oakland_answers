require 'yaml'
require 'pg'

namespace 'db' do
  desc "Create's database and user from database.yml for DEVELOPMENT only: grants all privileges (options: USER=x)"
  task :prepare do
    Rake::Task["db:create_user"].execute
    Rake::Task["db:create_database"].execute
  end

  task :create_user do
    db = YAML.load_file('config/database.yml')
    if config = db[Rails.env]
      conn = PGconn.open(:user => ENV['USER'])
      user_str = "CREATE USER #{config['username']}" if config['username']
      user_str = user_str + " WITH PASSWORD '#{config['password']}'" if config['password']
      unless user_str.blank?
        p user_str
        res = conn.exec(user_str)
        p res.result_status
      end

    else
      raise "NO DATABASE CONFIGURATION FOUND"
    end
  end

  task :create_database do
    db = YAML.load_file('config/database.yml')
    if config = db[Rails.env]
      conn = PGconn.open(:user => ENV['USER'])
      db_str = "CREATE DATABASE #{config['database']}" if config['database']
      p db_str
      res = conn.exec(db_str)
      p res.result_status
      if config['database'] and config['username']
        db_str = "GRANT ALL PRIVILEGES ON DATABASE #{config['database']} to #{config['username']}"
      end
      p db_str
      res = conn.exec(db_str)
      p res.result_status
    else
      raise "NO DATABASE CONFIGURATION FOUND"
    end
  end

end