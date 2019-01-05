note
	description: "Summary description for {ROOT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT

inherit
	ES_SUITE

create
	make

feature
	make
		do
			add_test (create {EXAMPLE_MATRIX_TESTS}.make)
			add_test (create {TEST_MATRIX}.make)
			show_browser
			run_espec
		end
end
