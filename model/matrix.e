note
	description: "[
		A 2D Matrix (where row and column numbers start with 0) implemented 
		as a 2D array (where row and column number start with 1).
		Be cautious about this mismatch of starting rows and columns between
		the 2D Matrix (which is an ADT) and the 2D array (which is an implementation).
	]"
	author: "Jackie and Fahad Qayyum"
	date: "$Date$"
	revision: "$Revision$"

class
	MATRIX

inherit
	ANY
	redefine
		-- when you call m1 ~ m2, where m1 and m2 are MATRIX objects,
		-- the redefined (overridden) version of is_equal is called.
		is_equal
	end

create -- declare the following two commands as constructors
	make,
	make_from

feature {NONE} -- Implementation
	imp: ARRAY2[ENTRY]
		-- row numbers start with 1
		-- column numbers start with 1

feature -- Commands
	make (nor: INTEGER; noc: INTEGER)
			-- Initialize a matrix with 'nor' rows and 'noc' columns.
			-- Use the "make_filled" feature from ARRAY2 class,
			-- where for the default value of ENTRY,
			-- use the "default_create" constructor.
		require
			no_precond: True -- Do not modify this.
		do
			-- Initialize 'imp' properly.
			create {ARRAY2[ENTRY]}imp.make_filled (create {ENTRY}.default_create, nor , noc )
		ensure
			number_of_rows_initialized: -- Your Task
				number_of_rows = nor
			number_of_columns_initialized: -- Your Task
				number_of_columns = noc
		end

	make_from (lol: LINKED_LIST[LINKED_LIST[ENTRY]])
			-- Initialize a matrix from a list of lists.
		require
			non_empty_list_of_lists: -- Your Task
				not (lol.is_empty)

			rectangle_shape: -- Your Task
				-- Hint: 'lol' being a list of equal-sized lists.
				across 1 |..| lol.count as i all
					lol.at (i.item).count ~ lol.first.count
				end
		do
			-- Initialize 'imp' properly.
			create imp.make_filled (create {ENTRY}.default_create, lol.count, lol.first.count)
			across 1 |..| lol.count as i loop
				across 1 |..| lol.first.count as j loop
					set_entry(lol.at (i.item).at (j.item),i.item -1,j.item -1)
				end
			end
		ensure
			number_of_rows_initialized: -- Your Task
				number_of_rows = lol.count
			number_of_columns_initialized: -- Your Task
				number_of_columns = lol.first.count
			correct_contents: -- Your Task
				-- Hint: Each row of the matrix matches the corresponding element list of 'lol'.
                    across 1 |..| lol.count as i all
                        across 1 |..| lol.first.count as j all
                            lol.at (i.item).at (j.item) ~ get_entry (i.item - 1, j.item - 1)
                        end
                    end
		end

feature -- Queries

	scalar_multiply (scalar: INTEGER):  MATRIX
			-- Obtain a new matrix by applying a scalar multiplication to the current matrix.

		require
			no_precond: True -- Do not modify this.
		local
			new_mat : MATRIX
			new_entry : ENTRY
		do
			create {MATRIX}new_mat.make (number_of_rows, number_of_columns)
			across 0 |..| (imp.height-1 ) as i loop
				across 0 |..| (imp.width-1 ) as j loop
					create new_entry.make (((get_entry(i.item,j.item).iv)*scalar), (get_entry(i.item,j.item).sv))
					new_mat.set_entry (new_entry, i.item, j.item)
				end
			end
			Result := new_mat
		ensure
			current_matrix_unchanged: -- Your Task
				across 0 |..| ( number_of_rows - 1 ) as x all
						across 0 |..| ( number_of_columns - 1 ) as y all
							result.get_entry(x.item,y.item) ~ result.deep_twin.get_entry(x.item,y.item)
						end
				end
			same_dimension_sizes: -- Your Task
				-- Hint: Returned matrix is as "big" as the current matrix.
				Result.number_of_rows ~ old number_of_rows and Result.number_of_columns ~ old number_of_columns
			iv_of_each_entry_scaled: -- Your Task
				-- Hint: Integer value of each entry is scaled properly.
				across 0 |..| (number_of_rows - 1) as x all
                    across 0 |..| (number_of_columns - 1) as y all
                		((old current).get_entry(x.item,y.item).iv * scalar) ~ (Result.get_entry(x.item,y.item).iv)
                    end
                 end
			sv_of_each_entry_same: -- Your Task
				-- Hint: String value of each entry remains the same.
					across 0 |..| (number_of_rows - 1) as x all
                    	across 0 |..| (number_of_columns - 1) as y all
                        	((old current).get_entry(x.item,y.item).sv) ~ (Result.get_entry(x.item,y.item).sv)
                   		end
                	end

		end

	transpose: MATRIX
			-- Obtain a new matrix by applying taking the transpose of current matrix.
		local
			mat : MATRIX
		do
			create mat.make (number_of_columns, number_of_rows)
			across 0 |..| (imp.height - 1) as i loop
				across 0 |..| (imp.width - 1) as j loop
					mat.set_entry (get_entry(i.item,j.item), j.item, i.item)
				end
			end
			Result := mat
		ensure
			current_matrix_unchanged: -- Your Task
				-- Hint: Shallow or Deep copy?
					across 0 |..| ( number_of_rows - 1 ) as x all
						across 0 |..| ( number_of_columns - 1 ) as y all
							current.get_entry(x.item,y.item) ~ (old current).get_entry(x.item,y.item)
						end
					end
			corresponding_dimensions: -- Your Task
				-- Hint: How do a matrix and its transpose correspond in terms of
				-- their number of rows and columns?
					Result.number_of_rows ~ old number_of_columns and Result.number_of_columns ~ old number_of_rows
			corresponding_cells: -- Your Task
				-- Hint: How do a matrix and its transpose correspond in terms of
				-- their contents? (review the mathematical definition!)
					across 0 |..| (number_of_rows - 1) as i all
                   		across 0 |..| (number_of_columns - 1) as j all
                      		  current.get_entry (i.item, j.item) ~ Result.get_entry(j.item,i.item)
                  		end
                	end

		end

feature -- Queries
	number_of_rows: INTEGER
			-- Number of rows of current matrix.
		do
			Result := imp.height
		ensure
			-- Do not add postconditions.
		end

	number_of_columns: INTEGER
			-- Number of columns of current matrix.
		do
			Result := imp.width
		ensure
			-- Do not add postconditions.
		end

	number_of_entries: INTEGER
			-- Number of entries stored in the current matrix.
		do
			Result := imp.height * imp.width
		ensure
			correct_result: -- Your Task
				Result = number_of_columns * number_of_rows
		end

	set_entry (e: ENTRY; row, column: INTEGER)
			-- Set entry at row 'row' and column 'column' to 'e'.
		require
			valid_row: -- Your Task
				number_of_rows >= row
			valid_column: -- Your Task
				number_of_columns >= column
		do
				imp.put (e, row+1 , column +1)
		ensure
			designated_cell_changed: -- Your Task
				-- How many cells are supposed to be changed?
				old get_entry(row,column) /~  current.get_entry(row,column)

			other_cells_unchanged: -- Your Task
					across 0|..| (number_of_rows-1) as x all
						across 0 |..| (number_of_columns-1) as y all
							if x ~ ( row + 1 ) and y ~ ( column + 1 ) then
									not	( ( old current ).get_entry( x.item , y.item ) ~ current.get_entry( x.item , y.item ) )
								else
									(old current).get_entry(x.item,y.item) ~ current.get_entry(x.item,y.item)
							end
						end
					end
		end

	get_entry (row, column: INTEGER): ENTRY
			-- Entry at row 'row' and column 'column'.
		require
			valid_row: -- Your Task
				number_of_rows >= row
			valid_column: -- Your Task
				number_of_columns >= column
		do
			Result := imp.item (row + 1, column + 1)
		ensure
			-- Do not add postconditions.
		end

	get_row (i: INTEGER): ARRAY[ENTRY]
			-- Row 'i' as an array.
		require
			valid_row: -- Your Task
				number_of_rows >= i
		local
			arr : ARRAY[ENTRY]
			x : INTEGER
		do
			create {ARRAY[ENTRY]}arr.make_empty
			x := 1
			across imp.lower |..| imp.width as j loop
				arr.force (imp.item(i+1,x), x)
				x := x + 1
			end
			Result := arr
		ensure
			return_value_constraint: -- Do Not Modify this.
				Result.lower = 1
			correct_result: -- Your Task
				-- Hint: How does the returned array correspond to the
				-- designated row?
				across 0 |..| (number_of_columns - 1) as j all
                    get_entry(i,j.item) ~ Result.at (j.item+1)
                end
		end

	get_column (i: INTEGER): LINKED_LIST[ENTRY]
			-- Column 'i' as a linked list.
		require
			valid_column: -- Your Task
				number_of_columns >= i
		local
			LL : LINKED_LIST[ENTRY]
			x : INTEGER
		do
			create {LINKED_LIST[ENTRY]}LL.make
			x := 1
			across imp.lower |..| imp.height as j loop
				LL.extend (imp.item(x, i+1))
				x := x + 1
			end
			Result := LL
		ensure
			correct_result: -- Your Task
				-- Hint: How does the returned list correspond to the
				-- designated column?
				across 0 |..| (number_of_rows - 1) as j all
                    get_entry(j.item,i) ~ Result.at (j.item+1)
                end
		end

feature -- Equality
	is_equal(other: like Current): BOOLEAN
			-- Do entries in Current matrix and 'other' match
			-- at each cell?
		do
			across 1 |..| number_of_rows as i loop
				across 1 |..| number_of_columns as j loop
				result := get_entry(i.item-1,j.item-1).is_equal (other.get_entry(i.item-1,j.item-1))
				end
			end
		ensure then
			equal_means_same_dimensioin_sizes: -- Your Task
				-- Hint: equal matrices must at least have same dimension sizes
				(old number_of_columns) ~ current.number_of_columns and
				(old number_of_rows) ~ current.number_of_rows
			equal_means_corresponding_entries_equal: -- Your Task
				-- Hint: equal matrices also have matching entries at corresponding positions.
					across 0 |..| (number_of_rows-1) as x all
						across 0 |..| (number_of_columns-1) as y all
							(old current).get_entry(x.item,y.item) ~ current.get_entry (x.item, y.item)
						end
					end
		end 

invariant
	implementation_constraint: -- Do Not Modify This.
		imp.lower = 1
	at_least_1_by_1: -- Your Task
		-- Hint: Each MATRIX is at least 1 * 1.
		number_of_entries >= 1

end
