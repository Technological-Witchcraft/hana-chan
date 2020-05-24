defmodule Hanachan.MixProject do
	use Mix.Project

	def project do
		[
			app: :hanachan,
			version: "0.1.0",
			elixir: "~> 1.10",
			start_permanent: Mix.env() == :prod,
			deps: deps()
		]
	end

	def application do
		[
			extra_applications: [:logger]
		]
	end

	defp deps do
		[
			{:nostrum, "~> 0.4.2"},
			{:yaml_elixir, "~> 2.4"}
		]
	end
end
