# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :connect,
  ecto_repos: [Connect.Repo]

# Configures the endpoint
config :connect, ConnectWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1GpRFXQnmEph90yw+RSEK2gP5RtfqtiA6H5vchelG4o9dUDXamN7zdWq/IN9u1yt",
  render_errors: [view: ConnectWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Connect.PubSub,
  live_view: [signing_salt: "YChm8dKF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :connect, Connect.Guardian,
        issuer: "connect",
        secret_key: "Wr1PemoMJ4HpJgvPVR7Z6zJv5xEgaAEbw0cFj3Zj2bZf7tLJ0pQevvGxNJ6NF8TL"