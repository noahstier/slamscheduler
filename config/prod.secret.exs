use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :slamscheduler, Slamscheduler.Endpoint,
  secret_key_base: "Bb0B83hMyMHRg2G6rjLFdaJVALJ0iTadIi6muqULdKaxvwK/DIOGkishiFd1Xw7u"

# Configure your database
config :slamscheduler, Slamscheduler.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "slamscheduler_prod",
  pool_size: 20
