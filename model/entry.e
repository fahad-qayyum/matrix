note
	description: "A matrix entry storing an integer index and a generic item."
	author: "Jacke Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ENTRY

inherit
	ANY
	redefine
		default_create,
		is_equal
	end

create
	make,
	default_create

feature -- Attributes
	iv: INTEGER -- ineger value
	sv: STRING -- string value

feature -- Command
	default_create
			-- Set iv and sv of current entry to, respectively, zero and empty string.
		do
			iv := 0
			sv := ""
		ensure then
			iv = 0
			sv.is_empty
		end

	make (i: INTEGER; s: STRING)
			-- Set iv and sv of current entry to, respectively, 'i' and 's'.
		do
			iv := i
			sv := s
		ensure
			key_initialized: iv ~ i
			value_initialized: sv ~ s
		end

	set_iv (i: INTEGER)
			-- Set iv of current entry to 'i'.
		do
			iv := i
		ensure
			iv = i
		end

	set_sv (s: STRING)
			-- Set sv of current entry to 's'.
		do
			sv := s
		ensure
			sv ~ s
		end

feature -- Equality
	is_equal (other: ENTRY): BOOLEAN
			-- Is current entry equal to 'other' entry?
		do
			Result := iv ~ other.iv and sv ~ other.sv
		ensure then
			Result = (iv ~ other.iv and sv ~ other.sv)
		end
end
