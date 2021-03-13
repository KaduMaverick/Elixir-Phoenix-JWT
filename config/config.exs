# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :myApi,
  ecto_repos: [MyApi.Repo]

# Configures the endpoint
config :myApi, MyApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GMhrlEHcbhzwiZu/K+KWlDarJqz+jGgn3E0cMXD2P9rMgw20asKihWfwopikVk6X",
  render_errors: [view: MyApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MyApi.PubSub,
  live_view: [signing_salt: "5emwyUbX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :myApi, MyApi.Guardian,
  issuer: "myApi",
  secret_key: "Xbpk697Q5RaejWV7aTqt/VFgeiKPrGLYlO/ifn71Dss1/7+GemeP7PMVNECzDjTR"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
