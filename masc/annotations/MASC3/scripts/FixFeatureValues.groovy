/*
 * Ensures that all feature values are represented as @value attributes rather
 * than the content of the <f> element.
 */

//File root = new File(this.args[0])
//File dataDir = new File(root, "data")
File dataDir = new File(this.args[0])

XmlParser parser = new XmlParser(false, false)
dataDir.eachDirRecurse { dir ->
	dir.eachFileMatch(~/.*.xml/) { file ->
		println "Rewriting ${file.path}"
		def graph = parser.parse(file)
		boolean print = false
		graph.a.fs.f.each { feature ->
			String text = feature.text()
			if (text != null && text != "")
			{
				feature.@value = text
				feature.value = null
				print = true
			}
		}
		if (print)
		{
			PrintWriter writer = new PrintWriter(file, 'UTF-8')
			XmlNodePrinter printer = new XmlNodePrinter(writer)
			printer.print(graph)
			writer.flush()
			writer.close()
		}
	}
}

