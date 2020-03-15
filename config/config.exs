# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chat,
  ecto_repos: [Chat.Repo]

# Configures the endpoint
config :chat, ChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mOA+gWG2/xv74wA/shNGy4/cBIAiiQVbPHVN3H9NUj+R9U9CKKqYWLqEx+XbpCeg",
  render_errors: [view: ChatWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chat.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "DFBpWQqO"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Use Guardian for authentication
config  :chat, Chat.Accounts.Guardian,
        issuer: "chat",
        secret_key: "4kjAl2FbCYhwbJ8OwS2/vCfF6HgnJ6UKc5ur0+MOFbZEk/+VR1IOUvR2Q2HHodRz"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
