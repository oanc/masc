
if (this.args.size() != 2) {
	println 'USAGE: groovy copyheaders.groovy <SOURCE> <TARGET>'
	return
}

File source = new File(this.args[0])
File target = new File(this.args[1])

// Filter so we just get the header files in the list.
FileFilter filter = new FileFilter() {
	boolean accept(File file) {
		return file.name.endsWith('.hdr')
	}
}

println "Source directory is ${source.getPath()}"
println "Target directory is ${target.getPath()}"

int count = 0
source.listFiles(filter).each {
	def txtName = it.name.replace('.hdr','.txt')
	//println "text name is ${txtName}"
	File txtFile = new File(target, txtName)
	if (txtFile.exists())
	{
		File newHeader = new File(target, it.name)
		newHeader.text = it.text
		++count;
	}
	else
	{
		println "No text file found for header ${it.name} : ${txtFile.path}"
	}
}

println "Copied ${count} header files."
