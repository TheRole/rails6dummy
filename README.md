# README

Dumy App to test TheRole with Rails 7

### how to use

```sh
docker compose -f docker-compose.yml up
docker compose exec rails bash
```

```sh
cd ~
gem install rails -v 6.1.7.3
rails _6.1.7.3_ new rails6dummy
```

```sh
cd rails6dummy
cd vendor

git clone https://github.com/TheRole/the_role_api.git
```

```sh
bundle install
```

```sh
rails generate devise:install
rails generate devise
```

```rb
class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :login, null: false, default: ""

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      # !!! TheRole field !!!
      t.integer :role_id

      t.timestamps null: false
    end
  end
end
```

```sh
rake db:create
rake db:migrate
```

```log
== 20230509135434 DeviseCreateUsers: migrating ================================
-- create_table(:users)
   -> 0.0098s
== 20230509135434 DeviseCreateUsers: migrated (0.0119s) =======================
```

```rb
bundle exec rake the_role_engine:install:migrations
```

```log
Copied migration 20230509135928_create_roles.the_role_engine.rb from the_role_engine
```

```sh
rake db:migrate
```

```rb
class User < ActiveRecord::Base
  include TheRole::Api::User

  # ... code ...
end
```

```sh
bundle exec rails g the_role install
```

```sh
  create  app/models/role.rb
  create  config/initializers/the_role.rb
```

```rb
TheRole.configure do |config|
  # [ Devise => :authenticate_user! | Sorcery => :require_login ]
  config.login_required_method = :authenticate_user!

  # layout for Management panel
  # config.layout = :the_role_management_panel
  # config.layout_title = 'The Role Gem'

  # config.default_user_role          = nil
  config.first_user_should_be_admin = true
  # config.access_denied_method       = :access_denied

  # Depends on Rails::VERSION
  #
  # [ :destroy, :delete_all, :nullify, :restrict, :restrict_with_exception, :restrict_with_error ]
  # config.destroy_strategy = nil
end
```
