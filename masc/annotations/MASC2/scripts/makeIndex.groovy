
String getBaseName(File file)
{
	//println "Getting name for ${file.path}"
	String suffix = file.name[-3..-1]
	//println "Suffix is ${suffix}"
	int dash = file.name.lastIndexOf('-')
	if (suffix == 'txt' || suffix == 'hdr')
	{
		//println "Found a text or header file: ${file.name[0..-5]}"
		return file.name[0..-5]
	}
	if (dash < 0)
	{
		throw new Exception("Not a text or header and does not contain a dash character: " + file.path)
	}
	return file.name.substring(0,dash)
}

File dir = new File('C:/Users/Keith/Dropbox/MASC2-3/FULL_MASC')
int start = dir.path.length()
def Q = []
def index = [:]

Q << dir
while (Q.size())
{
	dir = Q.remove(0)
	println "Indexing ${dir.path}"
	dir.listFiles().each { 
		if (it.isDirectory())
		{
			Q << it
		}
		else
		{
			//println "Indexing ${it.name}"
			//index[getBaseName(it)] = "${it.path[start..-1]}"
			index[getBaseName(it)] = "${it.parent[start..-1]}"
		}
	}
}

FileFilter filter = new FileFilter() {
	boolean accept(File file)
	{
		if (file.isDirectory())
		{
			return true
		}
		return file.name.endsWith('.txt')
	}
}

def release = new File('D:/Corpora/MASC2/ci/data/release/data')
def missing = new HashSet<String>()
dir = new File('D:/Corpora/MASC2/ci/data/working/release')
println "Scanning ${dir.path}"
int filesCopied = 0
dir.listFiles().each {
	def path = index[getBaseName(it)]
	if (path)
	{
		def wd = new File(release, path)
		if (!wd.exists())
		{
			if (!wd.mkdirs())
			{
				throw new Exception("Unable to create ${wd.path}")
			}
		}
		File outFile = new File(wd, it.name)
		outFile.setText(it.getText('UTF-8'), 'UTF-8')
		++filesCopied
		//println "Copied ${it.name} -> ${outFile.path}"
	}
	else
	{
		//println "Not found ${getBaseName(it)}"
		missing.add(getBaseName(it))
	}
}

println "Copied ${filesCopied} files"
println "Missing: "
def m = []
missing.each { m << it }
Collections.sort(m)
m.each { println it }