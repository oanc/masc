/*
 * Parallel version of the masc1.groovy script.
 *
 * Transforms the MASC 1 files into the final GrAF format for
 * MASC 2. This script transforms headers and standoff annotation
 * files and copies text files into the destination.
 */
import org.anc.xml.Transformer
import static groovyx.gpars.GParsPool.withPool

if (this.args.size() != 2)
{
	println "USAGE: masc1 <source> <destination>"
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

File hdrStylesheet = new File('scripts/graf-update-doc.xsl')
if (!hdrStylesheet.exists())
{
	println "Header stylesheet not found: ${hdrStylesheet.path}"
	return
}

File soStylesheet = new File('scripts/graf-update.xsl')
if (!soStylesheet.exists())
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
int total = 0
withPool {
	total = source.listFiles().eachParallel {
		String suffix = it.name[-5, -1]
		int result = 1
		switch (suffix)
		{
			case '.xml':
				try 
				{
					Transformer t = new Transformer(sStyleSheet)
					t.transform(it, new File(destination, it.name))
				}
				catch (Exception e)
				{
					result = 0
				}
				break
			case '.hdr':
				try
				{
					Transformer t = new Transformer(hdrStyleSheet)
					t.transform(it, new File(destination, it.name))
				}
				catch (Exception e)
				{
					result = 0
				}
				break
			case '.txt':
				new File(destination, it.name).setText('UTF-8', it.getText('UTF-8'))
				break
		}
		return result
	}.sumParallel()
}

/*
void process(Transformer ht, Transformer sot, File indir, File outdir) {
	//StreamSource ssource
	//StreamResult sresult
	if (!outdir.exists())
	{
		if (!outdir.mkdirs())
		{
			throw new IOException("Unable to create output directory ${outdir.name}")
		}
	}
	indir.listFiles().each {
		if (it.isDirectory())
		{
			process(ht, sot, it, new File(outdir, it.name))
		}
		else if (it.name.endsWith('.anc'))
		{
			println "Transforming header ${it.name}"			
			File outFile = new File(outdir, it.name.replace('.anc', '.hdr'))
			def ssource = new StreamSource(it)
			def sresult = new StreamResult(outFile)
			ht.transform(ssource,sresult)
		}
		else if (it.name.endsWith('.xml'))
		{
			println "Transforming standoff ${it.name}"			
			File outFile = new File(outdir,it.name)
			def ssource = new StreamSource(it)
			def sresult = new StreamResult(outFile)
			sot.setParameter("prefix", getType(it.name))
			sot.transform(ssource,sresult)
		}
		else if (it.name.endsWith(".txt"))
		{
			println "Copying ${it.name}"
			File outputFile = new File(outdir, it.name)
			outputFile.text = it.text
		}
	}
}

def factory = TransformerFactory.newInstance()
def headerTransformer = factory.newTransformer((Source) new StreamSource(hdrStylesheet))
def standoffTransformer = factory.newTransformer(new StreamSource(soStylesheet))

process(headerTransformer, standoffTransformer, source, destination)
*/