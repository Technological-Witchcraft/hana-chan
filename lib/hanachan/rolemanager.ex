defmodule HanaChan.RoleManager do
	alias Nostrum.Api

	defp add(role, category, msg) do
		roles = get_roles()
		if roles[category] != nil do
			if roles[category][role] != nil do
				result = Api.add_guild_member_role(msg.guild_id, msg.author.id, roles[category][role], "User requested role")
				case result do
					{:ok} -> Api.create_reaction(msg.channel_id, msg.id, "\xF0\x9F\x9F\xA2")
					{:error, error} -> Api.create_reaction(msg.channel_id, msg.id, "\xF0\x9F\x94\xB4")
						IO.inspect error
						:ignore
				end
			else
				Api.create_message(msg.channel_id, "That role doesn't exist! Please use `/role list #{category}` to list the roles associated with that category.")
			end
		else
			Api.create_message(msg.channel_id, "That category doesn't exist! Please use `/role list` to list the categories.")
		end
	end

	def command(args, msg) do
		if Enum.empty? args do
			help(msg)
		else
			[subcmd | rest] = args
			case subcmd do
				"add" -> if rest != [] do
						[category | role] = rest
						role |> Enum.join(" ") |> add(category, msg)
					else
						help(msg)
					end
				"list" -> rest |> List.first |> list(msg)
				"remove" -> if rest != [] do
						[category | role] = rest
						role |> Enum.join(" ") |> remove(category, msg)
					else
						help(msg)
					end
				_ -> help(msg)
			end
		end
	end

	defp get_roles do
		YamlElixir.read_all_from_file!("roles.yml") |> List.first
	end

	defp help(msg) do
		Api.create_message(msg.channel_id, """
		List of Role commands:
		`/role add <category> <role>` - Adds a role to yourself
		`/role list [category]` - List categories or roles in a category
		`/role remove <category> <role>` - Removes a role from yourself
		""")
	end

	defp list(category, msg) when category == nil do
		roles = get_roles()
		message = "List of categories: ```\n#{Enum.join(Map.keys(roles) |> Enum.sort, "\n")}```"
		Api.create_message(msg.channel_id, message)
	end

	defp list(category, msg) do
		roles = get_roles()
		if roles[category] != nil do
			message = "List of roles in \"#{category}\": ```\n#{Enum.join(Map.keys(roles[category]) |> Enum.sort, "\n")}```"
			Api.create_message(msg.channel_id, message)
		else
			Api.create_message(msg.channel_id, "That category doesn't exist! Please use `/role list` to list the categories.")
		end
	end

	defp remove(role, category, msg) do
		roles = get_roles()
		if roles[category] != nil do
			if roles[category][role] != nil do
				result = Api.remove_guild_member_role(msg.guild_id, msg.author.id, roles[category][role], "User requested role removal")
				case result do
					{:ok} -> Api.create_reaction(msg.channel_id, msg.id, "\xF0\x9F\x9F\xA2")
					{:error, error} -> Api.create_reaction(msg.channel_id, msg.id, "\xF0\x9F\x94\xB4")
						IO.inspect error
						:ignore
				end
			else
				Api.create_message(msg.channel_id, "That role doesn't exist! Please use `/role list #{category}` to list the roles associated with that category.")
			end
		else
			Api.create_message(msg.channel_id, "That category doesn't exist! Please use `/role list` to list the categories.")
		end
	end
end
