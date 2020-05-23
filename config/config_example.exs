use Mix.Config

# Copy this file as config.exs and input your bot token below to start the bot

config :nostrum,
	token: "INSERT_YOUR_BOT_TOKEN_HERE",
	num_shards: :auto

config :logger,
	level: :warn

config :logger, :console,
	metadata: [:shard]
