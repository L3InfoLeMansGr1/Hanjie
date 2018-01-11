# recherche des cases que l'on peut noircire dès les début
# 	1.pour une machine
def getSureIndex(blocks, nCell)
	lenPack = blocks.sum + blocks.size-1
	nb_undefined = nCell - lenPack

	sureIndex = []
	firstCell = 0
	blocks.each{|v|
		(0...v).each{|blockCell|
			sureIndex << firstCell + blockCell unless blockCell < nb_undefined
		}
		firstCell += v+1
	}
	return sureIndex
end

# 	2.pour un humain
def getSureIndexHuman(blocks, nCell)
	sureIndex = getSureIndex(blocks, nCell)

	sol = '.'*nCell
	indexes.each{|i| sol[i] = '#'}
	sol.chars.each_slice(5).map(&:join).join('|')
end



# pour avoir toutes les cases que l'on peut noircire sans réfléchir sur toute une grille
def startInfo(rows, cols)

	lines = rows.map{|row| getSureIndex(row, cols.size)}
	cols.each_with_index{|col, j|
		sureIndex = getSureIndex(col, rows.size)
		sureIndex.each{|i| lines[i] << j}
	}



	return lines.map(&:uniq)
end

def startInfoHuman(rows, cols)
	lines = startInfo(rows, cols)

	lines.map!{|line|
		sol = '.' * cols.size
		line.each{|index| sol[index] = '#'}
		sol.chars.each_slice(5).map(&:join).join('|')
	}

	separator = '-'*(cols.size + cols.size / 5)
	lines = lines.each_slice(5).to_a
	lines[0..-2].map{|t| t << separator}

	lines*"\n"
end



# exemple 1 de la feuille de jacoboni
rows = [[3], [1], [3], [2,1], [1,2]]
cols = [[1], [3], [1, 2], [2,1], [1,2]]
g = startInfo(rows, cols)
puts g.to_s

g = startInfoHuman(rows, cols)
puts g

# big exemple
rows = [
	[5,3,4,2],
	[1,3,3,2,3,3],
	[5,1,3,3,2,1],
	[1,5,7,5],
	[3,6,12],

	[6,3,2,7,1],
	[4,5,1,1,5],
	[1,2,1,2,1,1,2,1],
	[1,2,3,3,1,3,1,1],
	[1,1,2,1,4,3,1],

	[3,6,1,4,3,2],
	[3,3,4,1,2,3],
	[2,2,1,10,4],
	[3,3,3,3,1,4],
	[10,1,9],

	[1,2,5,2,1,1,2,1],
	[1,3,1,1,4,3,4],
	[5,3,7,1],
	[2,2,3,7,3,1],
	[5,11,7],

	[1,4,1,2,2,6],
	[7,1,2,1,5,1],
	[3,1,1,1,6,6],
	[4,1,1,1,1,1,1,1,1],
	[6,3,1,6,1,2],
]

cols = [
	[10,2,4,1],
	[1,3,10,4],
	[13,1,6],
	[4,4,1,8,2],
	[4,1,2,13],

	[2,3,2,3,1,2,1],
	[1,2,2,2,3,3,2,1],
	[3,3,1,3,2,3,1],
	[1,5,2,7,3],
	[2,5,1,3,3,1],

	[1,3,1,1,2,2,2,1],
	[4,2,1,1,1,2,2],
	[3,1,3,3,2,2,1,1],
	[2,6,2,6],
	[6,6,7,1],

	[5,5,4,3],
	[2,2,1,1,2,6,1],
	[1,2,3,4,2,1,1],
	[1,4,3,1,4,1,4],
	[1,3,5,1,7,1],

	[1,5,2,2,7],
	[3,2,5,5,1],
	[2,6,6,5],
	[2,1,1,5,1,3,1,1],
	[2,1,7,4,3,2],
]

g = startInfo(rows, cols)
puts g.to_s

g = startInfoHuman(rows, cols)
puts g
