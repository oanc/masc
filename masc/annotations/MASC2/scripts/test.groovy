def getType = { name ->
	int start = name.lastIndexOf('-')
	if (start > 0)
	{
		++start
		return name[start..-5] 
	}
	return 'id'
}

def name = "wsj_0006-mpqa.xml"
println getType(name)
