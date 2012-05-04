@GrabResolver(name="anc-snapshot", root="http://www.anc.org/maven/snapshot")
@Grab(group="org.tc37sc4.graf", module="graf-api", version="1.1.0-SNAPSHOT")
import org.xces.graf.api.*

//@GrabResolver(name="anc-snapshot", root="http://www.anc.org/maven/snapshot")
@Grab(group="org.tc37sc4.graf", module="graf-impl", version="1.1.0-SNAPSHOT")
import org.xces.graf.impl.*

//@GrabResolver(name="anc-snapshot", root="http://www.anc.org/maven/snapshot")
@Grab(group="org.tc37sc4.graf", module="graf-io", version="1.1.0-SNAPSHOT")
import org.xces.graf.io.*
import org.xces.graf.io.dom.*
import org.anc.conf.*

import java.io.*
import java.util.*

if (this.args.size() == 0)
{
	println "Invalid args"
	return
}

File indir = new File(this.args[0])
if (!indir.exists())
{
	println "Input directory not found."
	return;
}

GrafParser parser = new GrafParser()
parser.addAnnotationSpaces(AnnotationSpaces.ALL)
println "Parser constructed."
List<File> Q = new LinkedList<File>();
Q << indir
while (Q.size() > 0)
{
	File entry = Q.remove(0)
	if (entry.isFile())
	{
		println "Parsing ${entry.path}"
		parser.parse(entry)
	}
	else
	{
		entry.listFiles().each { 
			Q << it
		}
	}
}

println "Done."
