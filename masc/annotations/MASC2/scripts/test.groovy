import org.xces.graf.api.*
import org.xces.graf.impl.*
import org.xces.graf.io.*

import org.anc.io.*
import org.anc.util.*
import org.anc.conf.AnnotationSpaces

if (this.args.length != 1)
{
	println "USAGE: groovy test.groovy <directory>"
	println ""
	println "Parses all XML files in the directory with the new GrAF API (1.1.0)"
	return
}

File root = new File(this.args[0])
if (!root.exists())
{
	println "${root.path} does not exist."
	return
}

def q = new LinkedList<File>();
def filter = new SuffixFilter(".xml", false)
GraphParser parser = new GraphParser();
parser.addAnnotationSpace(AnnotationSpaces.XCES)
parser.addAnnotationSpace(AnnotationSpaces.PTB)
parser.addAnnotationSpace(AnnotationSpaces.Framenet)

//DotRenderer dot = new DotRenderer();
//dot.setOutputStream(System.out)

println "Starting."
q << root
while (!q.isEmpty())
{
	File entry = q.remove(0)
	if (entry.isDirectory())
	{
		println "Entry is a directory."
		entry.eachFile {
			q << it
		}
	}
	else if (filter.accept(entry))
	{
		println "Parsing ${entry.path}"
		IGraph graph = parser.parse(entry)
		//dot.render(graph)
	}
}

println "Done."