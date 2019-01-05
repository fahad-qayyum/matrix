note
	description: "Summary description for {TEST_MATRIX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_MATRIX

inherit
	ES_TEST

create
	make

feature --constructor
	make
		do
			add_boolean_case(agent test_make_constructor)
			add_boolean_case(agent test_make_from_constructor)
			add_boolean_case (agent test_scalar)
			add_boolean_case (agent test_transpose)
			add_boolean_case (agent test_number_of_entries)
			add_boolean_case (agent test_set_entry)
			add_boolean_case (agent test_get_column)
			add_violation_case_with_tag ("at_least_1_by_1", agent test_invariant)
			add_violation_case_with_tag ("valid_column", agent test_get_column_pre)
			add_violation_case_with_tag ("valid_row", agent test_get_entry_pre)
			add_violation_case_with_tag ("rectangle_shape", agent test_rectangle_shape)

		end

feature --Test MAKE constructor
	test_make_constructor : BOOLEAN
		local
			m : MATRIX
		do
			comment("Test_0 : Test make constructor")
			create {MATRIX}m.make(2,3)
			result := m.number_of_rows = 2 and m.number_of_columns = 3
			check Result end
		end

feature --Test MAKE_FROM constructor
	test_make_from_constructor : BOOLEAN
		local
			m : MATRIX
			lol: LINKED_LIST[LINKED_LIST[ENTRY]]
			e1, e2, e3, e4, e5, e6: ENTRY
			r1, r2, r3: LINKED_LIST[ENTRY]
		do
			create {ENTRY} e1.make (0, "a")
			create {ENTRY} e2.make (4, "b")
			create {ENTRY} e3.make (7, "c")
			create {ENTRY} e4.make (0, "d")
			create {ENTRY} e5.make (3, "e")
			create {ENTRY} e6.make (1, "f")
			create {LINKED_LIST[LINKED_LIST[ENTRY]]}lol.make
			create r1.make
			create r2.make
			create r3.make
			r1.extend (e1)
			r1.extend (e2)
			r2.extend (e3)
			r2.extend (e4)
			r3.extend (e5)
			r3.extend (e6)
			lol.extend (r1)
			lol.extend (r2)
			lol.extend (r3)
			comment("Test_1 : Test make_from constructor")
			create {MATRIX}m.make_from(lol)
			result := m.number_of_rows = 3 and m.number_of_columns = 2
			check Result end
		end

feature -- Test scalar_multiply
	test_scalar : BOOLEAN
		local
			m, scaled : MATRIX
			e1, e2, e3, e4, e5, e6: ENTRY
		do
			create {ENTRY} e1.make (0, "a")
			create {ENTRY} e2.make (4, "b")
			create {ENTRY} e3.make (7, "c")
			create {ENTRY} e4.make (0, "d")
			create {ENTRY} e5.make (3, "e")
			create {ENTRY} e6.make (1, "f")
			comment("Test_2 : Test scalar multiply")
			create m.make (3,2)
			m.set_entry(e1,0,0)
			m.set_entry(e2,0,1)
			m.set_entry(e3,1,0)
			m.set_entry(e4,1,1)
			m.set_entry(e5,2,0)
			m.set_entry(e6,2,1)

			scaled := m.scalar_multiply (-1)
			Result :=
					scaled.number_of_rows = 3
					and	scaled.number_of_columns = 2
					and scaled.get_entry (0, 0) ~ (create {ENTRY}.make (0, "a"))
					and scaled.get_entry (0, 1) ~ (create {ENTRY}.make (-4, "b"))
					and scaled.get_entry (1, 0) ~ (create {ENTRY}.make (-7, "c"))
					and scaled.get_entry (1, 1) ~ (create {ENTRY}.make (0, "d"))
					and scaled.get_entry (2, 0) ~ (create {ENTRY}.make (-3, "e"))
					and scaled.get_entry (2, 1) ~ (create {ENTRY}.make (-1, "f"))
			check Result end
		end

feature -- Test transpose
	test_transpose : BOOLEAN
		local
			m, transpose : MATRIX
			e1, e2, e3, e4, e5, e6: ENTRY
		do
			create {ENTRY} e1.make (0, "a")
			create {ENTRY} e2.make (4, "b")
			create {ENTRY} e3.make (7, "c")
			create {ENTRY} e4.make (0, "d")
			create {ENTRY} e5.make (3, "e")
			create {ENTRY} e6.make (1, "f")
			comment("Test_3 : Test transpose of the matrix")
			create m.make (3,2)
			m.set_entry(e1,0,0)
			m.set_entry(e2,0,1)
			m.set_entry(e3,1,0)
			m.set_entry(e4,1,1)
			m.set_entry(e5,2,0)
			m.set_entry(e6,2,1)

			transpose := m.transpose
			Result :=
						transpose.number_of_rows = 2
					and	transpose.number_of_columns = 3
					and transpose.get_entry (0, 0) ~ e1
					and	transpose.get_entry (0, 1) ~ e3
					and	transpose.get_entry (0, 2) ~ e5
					and	transpose.get_entry (1, 0) ~ e2
					and	transpose.get_entry (1, 1) ~ e4
					and	transpose.get_entry (1, 2) ~ e6
			check Result end
end

feature --Test number_of_entries constructor
	test_number_of_entries : BOOLEAN
		local
			m : MATRIX
		do
			comment("Test_4 : Test number of entries")
			create {MATRIX}m.make(2,3)
			result := m.number_of_entries = 6
			check Result end
		end

feature -- Test set_entry
	test_set_entry : BOOLEAN
		local
			m: MATRIX
			e1, e2, e3, e4, e5, e6: ENTRY
		do
			create {ENTRY} e1.make (0, "a")
			create {ENTRY} e2.make (4, "b")
			create {ENTRY} e3.make (7, "c")
			create {ENTRY} e4.make (0, "d")
			create {ENTRY} e5.make (3, "e")
			create {ENTRY} e6.make (1, "f")
			comment("Test_5 : Test set_entry feature")
			create m.make (3,2)
			m.set_entry(e1,0,0)
			m.set_entry(e2,0,1)
			m.set_entry(e3,1,0)
			m.set_entry(e4,1,1)
			m.set_entry(e5,2,0)
			m.set_entry(e6,2,1)
			m.set_entry (create {ENTRY}.make (1,"FAHAD"), 0, 0)
			Result :=
					m.number_of_rows = 3
					and	m.number_of_columns = 2
					and m.get_entry (0, 0) ~ (create {ENTRY}.make (1,"FAHAD"))
					and m.get_entry (0, 1) ~ e2
					and m.get_entry (1, 0) ~ e3
					and m.get_entry (1, 1) ~ e4
					and m.get_entry (2, 0) ~ e5
					and m.get_entry (2, 1) ~ e6
			check Result end
		end

feature -- Test set_entry
	test_get_column : BOOLEAN
		local
			m: MATRIX
			e1, e2, e3, e4, e5, e6: ENTRY
			column : LINKED_LIST[ENTRY]
		do
			create {ENTRY} e1.make (0, "a")
			create {ENTRY} e2.make (4, "b")
			create {ENTRY} e3.make (7, "c")
			create {ENTRY} e4.make (0, "d")
			create {ENTRY} e5.make (3, "e")
			create {ENTRY} e6.make (1, "f")
			comment("Test_6 : Test get_column ")
			create m.make (3,2)
			m.set_entry(e1,0,0)
			m.set_entry(e2,0,1)
			m.set_entry(e3,1,0)
			m.set_entry(e4,1,1)
			m.set_entry(e5,2,0)
			m.set_entry(e6,2,1)
			column := m.get_column (1)
			Result := 		column.count = 3
						and column[1] ~ e2
						and column[2] ~ e4
						and column[3] ~ e6
			check Result end
		end

feature --Test invariant
	test_invariant
		local
			m : MATRIX
		do
			comment("TEST_7 : Test invariant")
			create {MATRIX}m.make (0, 0)
		end

feature --Test get_columns pre-condition
	test_get_column_pre
		local
			m: MATRIX
			e1, e2, e3, e4, e5, e6: ENTRY
			column : LINKED_LIST[ENTRY]
		do
			create {ENTRY} e1.make (0, "a")
			create {ENTRY} e2.make (4, "b")
			create {ENTRY} e3.make (7, "c")
			create {ENTRY} e4.make (0, "d")
			create {ENTRY} e5.make (3, "e")
			create {ENTRY} e6.make (1, "f")
			comment("Test_8 : Test get_column feature")
			create m.make (3,2)
			m.set_entry(e1,0,0)
			m.set_entry(e2,0,1)
			m.set_entry(e3,1,0)
			m.set_entry(e4,1,1)
			m.set_entry(e5,2,0)
			m.set_entry(e6,2,1)
			column := m.get_column (3)
		end

feature --Test invariant
	test_get_entry_pre
		local
			m: MATRIX
			e1, e2, e3, e4, e5, e6, e7: ENTRY
		do
			create {ENTRY} e1.make (0, "a")
			create {ENTRY} e2.make (4, "b")
			create {ENTRY} e3.make (7, "c")
			create {ENTRY} e4.make (0, "d")
			create {ENTRY} e5.make (3, "e")
			create {ENTRY} e6.make (1, "f")
			create {ENTRY} e7.default_create
			comment("Test_9 : Test get_entry pre-condition")
			create m.make (3,2)
			m.set_entry(e1,0,0)
			m.set_entry(e2,0,1)
			m.set_entry(e3,1,0)
			m.set_entry(e4,1,1)
			m.set_entry(e5,2,0)
			m.set_entry(e6,2,1)
			e7 := m.get_entry(100,100)
		end

feature --test is_equal post-condition
	test_rectangle_shape
		local
			m : MATRIX
			lol: LINKED_LIST[LINKED_LIST[ENTRY]]
			e1, e2, e3, e4, e5, e6, e7: ENTRY
			r1, r2, r3: LINKED_LIST[ENTRY]
		do
			create {ENTRY} e1.make (0, "a")
			create {ENTRY} e2.make (4, "b")
			create {ENTRY} e3.make (7, "c")
			create {ENTRY} e4.make (0, "d")
			create {ENTRY} e5.make (3, "e")
			create {ENTRY} e6.make (1, "f")
			create {ENTRY} e7.make (1, "f")
			create {LINKED_LIST[LINKED_LIST[ENTRY]]}lol.make
			create r1.make
			create r2.make
			create r3.make
			r1.extend (e1)
			r1.extend (e2)
			r2.extend (e3)
			r2.extend (e4)
			r3.extend (e5)
			r3.extend (e6)
			r3.extend (e7)
			lol.extend (r1)
			lol.extend (r2)
			lol.extend (r3)
			comment("TEST_10 : Test rectangle_shape pre-condition")
			create {MATRIX} m.make_from (lol)
		end

end
