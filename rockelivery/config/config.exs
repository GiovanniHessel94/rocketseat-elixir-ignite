# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rockelivery,
  ecto_repos: [Rockelivery.Repo]

config :rockelivery, Rockelivery.Users.Create, via_cep_adapter: Rockelivery.ViaCep.Client

config :rockelivery, Rockelivery.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :rockelivery, RockeliveryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xTprxb6eyDD+neJBkA73fCZ3aRfB4c6pWmoFgpxODk/8/dvXna4On7PfOEjopRFy",
  render_errors: [view: RockeliveryWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Rockelivery.PubSub,
  live_view: [signing_salt: "RrXyd3Y7"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

config :rockelivery, RockeliveryWeb.Auth.Guardian,
  issuer: "rockelivery",
  secret_key: "AQcwO0r167lB4igbYWrE4RvjeagiHeT7ZojIcRlyEPl0FIggMzhV6L2u3qkmzbM3"

config :rockelivery, RockeliveryWeb.Auth.Pipeline,
  module: RockeliveryWeb.Auth.Guardian,
  error_handler: RockeliveryWeb.Auth.ErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
