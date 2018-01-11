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

	return lines
end

def startInfoHuman(rows, cols)
	lines = startInfo(rows, cols)

	lines.map!{|line|
		sol = '.' * cols.size
		line.each{|index| sol[index] = '#'}
		sol.chars.each_slice(5).map(&:join).join('|')
	}

	lines*"\n"
end



# exemple 1 de la feuille de jacoboni
rows = [[3], [1], [3], [2,1], [1,2]]
cols = [[1], [3], [1, 2], [2,1], [1,2]]
g = startInfo(rows, cols)
puts g.to_s

g = startInfoHuman(rows, cols)
puts g
