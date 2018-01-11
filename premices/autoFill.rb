def autoFill(infos, nCase, debut=0)
	lenPack = infos.sum + infos.size-1
	nb_not_sure = nCase-lenPack
	sol = info.map {|v|
		sure=[v-nb_not_sure,0].max;
		'.'*(v-sure) + '#'*sure
	}*'.' + '.'*(nCase-lenPack)

	sol.chars.each_slice(5).map(&:join).join('|')
end
