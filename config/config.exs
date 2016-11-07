# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pyconar_talks,
  ecto_repos: [PyconarTalks.Repo]

# Configures the endpoint
config :pyconar_talks, PyconarTalks.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eUYqRPVcIB/ZVyuGkv0kyzH7kM6aggLk9QD5xUhYY6aShTuDGfuN5cXKumUlCXFS",
  render_errors: [view: PyconarTalks.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PyconarTalks.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "PyconarTalks",
  ttl: { 10, :days },
  verify_issuer: true,
  secret_key: "lksdjowiurowieurlkjsdlwwer",
  serializer: PyconarTalks.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"