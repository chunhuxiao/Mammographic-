for x in range(1,331):
	line = raw_input().split()
	if len(line)==7 and line[3]=='M':
		print line[0],'2',str(1025-int(line[5])),line[4]
	elif len(line)==7 and line[3]=='B':
		print line[0],'1',str(1025-int(line[5])),line[4]
	else:
		print line[0],'0',str(-1),str(-1)