note
	description: "Summary description for {TEST_MATRIX}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE_MATRIX_TESTS

inherit
	ES_TEST

create
	make

feature -- Add tests
	make
		do
			add_boolean_case (agent t1)
		end

feature -- Tests
	t1: BOOLEAN
		local
			m1, m2, transpose, scaled: MATRIX
			lol: LINKED_LIST[LINKED_LIST[ENTRY]]
			r1, r2, r3: LINKED_LIST[ENTRY]
			e1, e2, e3, e4, e5, e6: ENTRY
			row_0: ARRAY[ENTRY]
			column_1: LINKED_LIST[ENTRY]
		do
			comment("t1: example use of MATRIX")
			create r1.make
			create r2.make
			create r3.make
			create {ENTRY} e1.make (0, "a")
			create {ENTRY} e2.make (4, "b")
			create {ENTRY} e3.make (7, "c")
			create {ENTRY} e4.make (0, "d")
			create {ENTRY} e5.make (3, "e")
			create {ENTRY} e6.make (1, "f")

			r1.extend (e1)
			r1.extend (e2)
			r2.extend (e3)
			r2.extend (e4)
			r3.extend (e5)
			r3.extend (e6)
			create lol.make
			lol.extend (r1)
			lol.extend (r2)
			lol.extend (r3)

			create {MATRIX} m1.make_from (lol)
			Result :=
						m1.number_of_rows = 3
					and m1.number_of_columns = 2
					and m1.number_of_entries = 3 * 2
			check Result end

			Result :=
					m1.get_entry (0, 0) ~ e1
				and	m1.get_entry (0, 1) ~ e2
				and	m1.get_entry (1, 0) ~ e3
				and	m1.get_entry (1, 1) ~ e4
				and	m1.get_entry (2, 0) ~ e5
				and	m1.get_entry (2, 1) ~ e6
			check Result end

			row_0 := m1.get_row (0)
			Result := 		row_0.count = 2
						and row_0[1] ~ e1
						and row_0[2] ~ e2
			check Result end

			column_1 := m1.get_column (1)
			Result := 		column_1.count = 3
						and column_1[1] ~ e2
						and column_1[2] ~ e4
						and column_1[3] ~ e6
			check Result end

			m1.set_entry (create {ENTRY}.make (0, "d"), 0, 0)
			Result :=
					m1.get_entry (0, 0) ~ e4
				and	m1.get_entry (0, 1) ~ e2
				and	m1.get_entry (1, 0) ~ e3
				and	m1.get_entry (1, 1) ~ e4
				and	m1.get_entry (2, 0) ~ e5
				and	m1.get_entry (2, 1) ~ e6
			check Result end

			create m2.make (3, 2)
			m2.set_entry (create {ENTRY}.make (0, "d"), 0, 0)
			m2.set_entry (create {ENTRY}.make (4, "b"), 0, 1)
			m2.set_entry (create {ENTRY}.make (7, "c"), 1, 0)
			m2.set_entry (create {ENTRY}.make (0, "d"), 1, 1)
			m2.set_entry (create {ENTRY}.make (3, "e"), 2, 0)
			m2.set_entry (create {ENTRY}.make (1, "f"), 2, 1)
			Result := m1 ~ m2 -- m1 is equal to m2
			check Result end

			transpose := m1.transpose
			Result :=
						transpose.number_of_rows = 2
					and	transpose.number_of_columns = 3
					and transpose.get_entry (0, 0) ~ e4
					and	transpose.get_entry (0, 1) ~ e3
					and	transpose.get_entry (0, 2) ~ e5
					and	transpose.get_entry (1, 0) ~ e2
					and	transpose.get_entry (1, 1) ~ e4
					and	transpose.get_entry (1, 2) ~ e6
			check Result end

			scaled := m1.scalar_multiply (-2)
			Result :=
					scaled.number_of_rows = 3
					and	scaled.number_of_columns = 2
					and scaled.get_entry (0, 0) ~ (create {ENTRY}.make (0, "d"))
					and scaled.get_entry (0, 1) ~ (create {ENTRY}.make (-8, "b"))
					and scaled.get_entry (1, 0) ~ (create {ENTRY}.make (-14, "c"))
					and scaled.get_entry (1, 1) ~ (create {ENTRY}.make (0, "d"))
					and scaled.get_entry (2, 0) ~ (create {ENTRY}.make (-6, "e"))
					and scaled.get_entry (2, 1) ~ (create {ENTRY}.make (-2, "f"))
		end
end
