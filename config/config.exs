# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :slamscheduler2,
  ecto_repos: [Slamscheduler2.Repo]

# Configures the endpoint
config :slamscheduler2, Slamscheduler2.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "L164xbboEx0t0gaVP1kWoZbUMBnvlwQfP/sKvawko/zu3ola2i1unAgaP62FMoY1",
  render_errors: [view: Slamscheduler2.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Slamscheduler2.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
