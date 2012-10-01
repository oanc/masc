// Note: This program is not used during processing.

@Grab(group='org.tc37sc4.graf', module='graf-api', version='1.2.0')
import org.xces.graf.api.*
@Grab(group='org.tc37sc4.graf', module='graf-io', version='1.2.0')
import org.xces.graf.io.*
import org.xces.graf.io.dom.*
@Grab(group='org.tc37sc4.graf', module='graf-impl', version='1.2.0')
import org.xces.graf.impl.*
@Grab(group='org.tc37sc4.graf', module='graf-util', version='1.2.0')
import org.xces.graf.util.*

def files = ['./written/govt-docs/chapter-10', './written/non-fiction/ch5', './written/journal/VOL15_3']

if (this.args.size() != 2)
{
	println "USAGE"
	println ""
	println "groovy fix-strings.groovy /path/to/resource-header.xml /path/to/data"
	println ""
	return
}

def dataDir = new File(this.args[1])
if (!dataDir.exists())
{
	println "Data directory not found."
	return
}

if (!dataDir.isDirectory())
{
	println "Specified location is not a directory."
	return
}

def headerFile = new File(this.args[0])
if (!headerFile.exists())
{
	println "Unable to locate the resource header."
	return
}

ResourceHeader header = new ResourceHeader(headerFile)
GrafParser parser = new GrafParser(header)

files.each { filename ->
	def pennFile = new File(dataDir, filename + '-penn.xml')
	if (!pennFile.exists())
	{
		println "Unable to find ${pennFile.path}"
	}
	else
	{
		println "Updating @strings for ${pennFile.path}"
		def txtFile = new File(dataDir, filename + '.txt')
		String text = txtFile.getText('UTF-8')
		IGraph graph = parser.parse(pennFile)
		graph.nodes.each { node ->
			IRegion region = GraphUtils.getSpan(node)
			int start = GraphUtils.getOffset(region.start)
			int end = GraphUtils.getOffset(region.end)
			node.annotations().each { a ->
				if (a.label == 'tok')
				{
					def substring = text.substring(start, end)
					//println "${node.id} ${a.label} ${start}-${end} ${substring}"
					a.addFeature('string', substring)
				}
			}
		}
		FileOutputStream stream = new FileOutputStream(pennFile)
		IRenderer renderer = new GrafRenderer(stream, 'UTF-8')
		renderer.render(graph)
		renderer.close()
	}
}
