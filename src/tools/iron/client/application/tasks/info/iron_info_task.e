note
	description: "Summary description for {IRON_INFO_TASK}."
	author: ""
	date: "$Date: 2013-06-05 17:10:12 +0200 (mer., 05 juin 2013) $"
	revision: "$Revision: 92670 $"

class
	IRON_INFO_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "info"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_SEARCH_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_SEARCH_ARGUMENTS; a_iron: IRON)
		do
			across
				args.resources as c
			loop
				print (m_title_information_for (c.item))
				print_new_line
				if c.item.starts_with ("http://") or c.item.starts_with ("https://") then
					if attached a_iron.catalog_api.package_associated_with_uri (c.item) as l_package then
						display_information (l_package, args, a_iron)
					end
				else
					if attached a_iron.catalog_api.packages_associated_with_name (c.item) as lst then
						across
							lst as p
						loop
							display_information (p.item, args, a_iron)
						end
					end
				end
				print ("%N")
			end
		end

	display_information (a_package: IRON_PACKAGE; args: IRON_ARGUMENTS; a_iron: IRON)
		do
			print (m_information_for (a_package.human_identifier, a_package.id, a_package.repository.url))
			print_new_line
			if
				a_iron.installation_api.is_installed (a_package) and then
				attached a_iron.installation_api.package_installation_path (a_package) as l_installation_path
			then
				print ("  ")
				print (tk_installation)
				print (": ")
				print (l_installation_path.name)
				print_new_line
			end
			if attached a_package.description as l_description then
				print_new_line
				print ("  description: ")
				print (l_description)
				print_new_line
			end

			if attached a_package.associated_paths as l_paths and then not l_paths.is_empty then
				print_new_line
				print ("  ")
				print (tk_associated_uris)
				print (": ")
				print_new_line
				across
					l_paths as c
				loop
					print ("    - ");
					print (a_package.repository.url)
					print (c.item); print ("%N")
				end
			end
			if attached a_package.items as l_items then
				across
					l_items as c
				loop
					if c.key.starts_with ("_") then
						-- ignored
						if args.verbose then
							print ("  ")
							print (c.key)
							print (": ")
							print (c.item);
							print ("%N")
						end
					else
						print ("  ")
						print (c.key)
						print (": ")
						print (c.item);
						print ("%N")
					end
				end
			end

		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
