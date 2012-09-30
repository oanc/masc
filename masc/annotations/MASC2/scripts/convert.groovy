/*
 * Transforms standoff annotation files in the old GrAF format to the 
 * new GrAF format.
 */
import javax.xml.transform.*
import javax.xml.transform.stream.*

if (this.args.size() != 2)
{
	println "USAGE: convert <source> <destination>"
	return
}

File source = new File(this.args[0])
if (!source.exists())
{
	println "Source not found"
	return
}

File destination = new File(this.args[1])
if (!destination.exists())
{
	println "Destination not found."
	return
}

File stylesheet = new File('scripts/graf-update.xsl')
if (!stylesheet.exists())
{
	println "Standoff stylesheet not found."
	return
}

String getType(String s)
{
	int start = s.lastIndexOf('-')
	if (start > 0)
	{
		++start
		return s[start..-5] 
	}
	return 'id'
}

void process(Transformer transformer, File indir, File outdir) {
	//StreamSource ssource
	//StreamResult sresult
	if (!outdir.exists() && !outdir.mkdirs())
	{
		throw new IOException("Unable to create output directory ${outdir.name}")
	}
	
	indir.listFiles().each {
		if (it.isDirectory())
		{
			process(transformer, it, new File(outdir, it.name))
		}
		else if (it.name.endsWith('.xml'))
		{
			println "Transforming standoff ${it.name}"			
			File outFile = new File(outdir,it.name)
			def ssource = new StreamSource(it)
			def sresult = new StreamResult(outFile)
			transformer.setParameter("prefix", getType(it.name))
			transformer.transform(ssource,sresult)
		}
	}
}

def factory = TransformerFactory.newInstance()
def transformer = factory.newTransformer(new StreamSource(stylesheet))

process(transformer, source, destination)
