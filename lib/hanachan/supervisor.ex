defmodule HanaChan.Supervisor do
	def start_link do
		children = [HanaChan]
		Supervisor.start_link(children, strategy: :one_for_one)
	end
end
