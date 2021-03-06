note
	description: "[
			Summary description for {IRON_ARGUMENTS_PARSER}.
			
			
				iron list 						: List of available packages, i.e. packages that have been installed
												: as well as packages available from the Iron server.
				iron list --installed 			: List of installed packages.
				iron install package_name 		: Install a package.
				iron install -f package_file 	: Install a package from a file.
				iron remove package_name 		: Remove a package.
				iron search package_name 		: Search for a package.
				iron info package_name 			: Information about a package.

		]"
	author: ""
	date: "$Date: 2013-07-03 18:11:55 +0200 (mer., 03 juil. 2013) $"
	revision: "$Revision: 92771 $"

class
	IRON_INSTALL_ARGUMENT_PARSER

inherit
	IRON_ARGUMENT_MULTI_PARSER
		rename
			make as make_parser
		end

	IRON_INSTALL_ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make (a_task: IRON_TASK)
			-- Initialize argument parser
		do
			task := a_task
			make_parser (False, True)
			set_argument_source (a_task.argument_source)
			is_using_builtin_switches := not is_verbose_switch_used
--			set_is_using_separated_switch_values (False)
--			set_non_switched_argument_validator (create {ARGUMENT_DIRECTORY_VALIDATOR})
		end

	task: IRON_TASK

feature -- Access

	installing_all: BOOLEAN
			-- Install all available packages?
		do
			Result := has_option (all_switch)
		end

	ignoring_cache: BOOLEAN
			-- <Precursor>
		do
			Result := has_option (no_cache_switch)
		end

	resources: LIST [IMMUTABLE_STRING_32]
		once
			create {ARRAYED_LIST [IMMUTABLE_STRING_32]} Result.make (values.count)
			across
				values as c
			loop
				Result.force (create {IMMUTABLE_STRING_32}.make_from_string (c.item))
			end
		end

	files: LIST [IMMUTABLE_STRING_32]
		once
			if
				has_option (file_switch) and then
				attached options_values_of_name (file_switch)  as l_values
			then
				create {ARRAYED_LIST [IMMUTABLE_STRING_32]} Result.make (l_values.count)
				across
					l_values as c
				loop
					Result.force (create {IMMUTABLE_STRING_32}.make_from_string (c.item))
				end
			else
				create {ARRAYED_LIST [IMMUTABLE_STRING_32]} Result.make (0)
			end
		end

feature {NONE} -- Usage

	name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ({IRON_CONSTANTS}.executable_name + " " + task.name)
		end

feature {NONE} -- Usage

	non_switched_argument_name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string ({STRING_32} "package name, id or uri")
		end

	non_switched_argument_description: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "Package name, id or full url")
		end

	non_switched_argument_type: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "string")
		end

feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (2)
			Result.extend (create {ARGUMENT_SWITCH}.make (file_switch, "Package file", True, True))
			Result.extend (create {ARGUMENT_SWITCH}.make (all_switch, "Install all available packages", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (no_cache_switch, "Ignore cache and always download iron package.", True, False))
			add_verbose_switch (Result)
			add_simulation_switch (Result)
			add_batch_interactive_switch (Result)
		end

	file_switch: STRING = "f|file"
	all_switch: STRING = "a|all"
	no_cache_switch: STRING = "no_cache"

;note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
