note
	description: "Summary description for {IRON_REPO_VERSION}."
	date: "$Date: 2013-05-23 21:54:29 +0200 (jeu., 23 mai 2013) $"
	revision: "$Revision: 92585 $"

class
	IRON_REPO_VERSION

inherit
	DEBUG_OUTPUT
		redefine
			is_equal
		end

create
	make,
	make_default

convert
	value: {READABLE_STRING_8}

feature {NONE} -- Initialization

	make (v: READABLE_STRING_8)
		do
			create value.make_from_string (v)
		end

	make_default
			-- Make Current as default
			-- the default version is known by the IRON server
		do
			make ("")
		end

feature -- Access

	value: IMMUTABLE_STRING_8

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := value
		end

feature -- Status report

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := value.is_case_insensitive_equal (other.value)
		end

	is_default: BOOLEAN
		do
			Result := value.is_empty
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
