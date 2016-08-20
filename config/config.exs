# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :slamscheduler,
  ecto_repos: [Slamscheduler.Repo]

# Configures the endpoint
config :slamscheduler, Slamscheduler.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kyGPhLX50MPwuxTWbOLjY1JjWndpiZhvC3w6xPXLEes8xws35drE1TpdAaUqaxq0",
  render_errors: [view: Slamscheduler.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Slamscheduler.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
