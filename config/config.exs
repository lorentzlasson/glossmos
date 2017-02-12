# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :glossmos,
  ecto_repos: [Glossmos.Repo]

# Configures the endpoint
config :glossmos, Glossmos.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aLWzb+b/I1cDVcl6FdnRpyb/456kCYKC8UET9RZF2AKdUHzxHanaVr/XRvuA6d55",
  render_errors: [view: Glossmos.ErrorView, accepts: ~w(json)],
  pubsub: [name: Glossmos.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
