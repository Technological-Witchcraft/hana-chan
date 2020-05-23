defmodule HanaChan do
	use Nostrum.Consumer

	def start_link do
		IO.puts("こんにちは！")
		Consumer.start_link(__MODULE__)
	end

	def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
		if String.starts_with?(msg.content, "/hana ") do
			length = String.length(msg.content)
			if length > 6 do
				[command | rest] = String.slice(msg.content, 6, length)
					|> String.split(" ", trim: true)
				case command do
					_ -> :ignore
				end
			end
		end
	end

	def handle_event(_event) do
		:noop
	end
end
