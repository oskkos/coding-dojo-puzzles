Class OKO.GameOfLife Extends %RegisteredObject
{

Parameter SPEED = 100;

Parameter COLS = 40;

Parameter ROWS = 20;

ClassMethod Run()
{
	#dim e As %Exception.AbstractException
	try {
		#dim grid // md
		do ..fillGrid(.grid)

		#dim gen As %Integer = 1
		while(1) {
			write #
			write "Generation ", gen, ":", !
			do ..printGrid(.grid)
			#dim change As %Boolean = ..nextGeneration(.grid)
			if ('change) {
				write "No more changes, the game is over", !
				return
			}
			set gen = gen + 1
			hang ..#SPEED / 1000
		}
	} catch (e) {
		// just swallow for a "clean" exit :D
	}
}

ClassMethod fillGrid(ByRef grid)
{
	for i=1:1:..#ROWS {
		for j=1:1:..#COLS {
			set grid(i,j) = $random(2)
		}
	}
}

ClassMethod nextGeneration(ByRef grid) As %Boolean
{
	#dim change As %Boolean = 0
	#dim stateChanged As %Boolean = 0
	#dim newGrid // md
	#dim i As %Integer = ""
	for {
		set i = $order(grid(i))
		quit:i=""

		#dim j As %Integer = ""
		for {
			set j = $order(grid(i,j))
			quit:j=""
			set newGrid(i,j) = ..isAlive(i, j, .grid, .stateChanged)
			if (stateChanged) {
				set change = 1
			}
		}
	}
	merge grid = newGrid
	return change
}

ClassMethod isAlive(
	i As %Integer,
	j As %Integer,
	ByRef grid,
	ByRef stateChanged As %Boolean) As %Boolean
{
	#dim livingNeighbours As %Integer = 0
	#dim isAlive As %Boolean = grid(i, j)
	for x=i-1:1:i+1 {
		for y=j-1:1:j+1 {
			#dim xx As %Integer = $select(
				x = 0: ..#ROWS,  // Previous row is the last one
				x > ..#ROWS: 1,  // Next row is the first one
				1: x             // By default use the same row
				)

			#dim yy As %Integer = $select(
				y = 0: ..#COLS,   // Previous column is the last one
				y > ..#COLS: 1,   // Next column is the first one
				1: y              // By default use the same column
				)

			if ((xx '= i) || (yy '= j)) {
				set livingNeighbours = livingNeighbours + grid(xx, yy)
			}
		}
	}

	if (isAlive && ((livingNeighbours = 2) || (livingNeighbours = 3))) {
		set stateChanged = 0
		return 1
	}
	if ('isAlive && (livingNeighbours = 3)) {
		set stateChanged = 0
		return 1
	}
	set stateChanged = isAlive
	return 0
}

ClassMethod printGrid(ByRef grid)
{
	#dim i As %Integer = ""
	for {
		set i = $order(grid(i))
		quit:i=""

		#dim j As %Integer = ""
		for {
			set j = $order(grid(i,j))
			quit:j=""

			write $select(grid(i,j):"██",1:"  ")
		}
		write !
	}
}

}
