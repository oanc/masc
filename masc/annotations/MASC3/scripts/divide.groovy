if (this.args.length != 3)
{
	println "Usage: groovy divide.groovy <template directory> <source> <destination>"
	return
}

File templateDir = new File(this.args[0])
File source = new File(this.args[1])
File destination = new File(this.args[2])

if (!templateDir.exists())
{	
	println "Template directory does not exist: ${templateDir.path}"
	return
}

if (!source.exists())
{
	println "Source directory not found: ${source.path}"
	return
}

if (!destination.exists())
{
	println "Destination directory does not exist: ${destination}"
	return
}

def index = [:]
def unindexed = [:]

def start = templateDir.path.length() + 1
def q = new LinkedList()
q.addLast(templateDir)
while (!q.isEmpty())
{
	def entry = q.removeFirst()	
	if (entry.isDirectory())
	{
		entry.eachFile { q.addLast(it) }
	}
	else
	{
		String name = entry.name[0..-5]
		String root = entry.parentFile.path.substring(start)
		//println "${name} -> ${root}"
		index[name] = root
	}
}

source.eachFile { file ->
	String suffix = file.name[-5..-1]
	String name = file.name[0..-5]
	if (file.name.endsWith('.xml'))
	{
		int end = file.name.lastIndexOf('-')
		name = file.name.substring(0, end)
	}
	def dir = index[name]
	if (dir)
	{
		println "Copying ${file.name} to ${dir}"
		File destDir = new File(destination, dir)
		if (!destDir.exists())
		{
			if (!destDir.mkdirs())
			{
				println "Unable to create ${destDir.path}"
				exit 1
			}
		}
		File destFile = new File(destDir, file.name)
		String text = file.getText('UTF-8')
		destFile.setText(text, 'UTF-8')
	}
	else
	{
		println "No entry found for ${file.name}"
		unindexed[name] = Boolean.TRUE;
	}
}

File outfile = new File("../unindexed.txt")
println "Writing ${outfile.path}"
PrintStream out = new PrintStream(outfile)
unindexed.each { key,value ->
	out.println(key)
}
out.close()
