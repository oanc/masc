@GrabResolver(name='anc-releases', root='http://www.anc.org:8080/nexus/content/repositories/releases')
@Grab(group='org.anc', module='xml', version='2.1.1')
import org.anc.xml.*

/*
void usage() {
	println ""
	println "USAGE"
	println ""
	println "groovy fixPennFeatures.groovy <stylesheet> <input directory> <output directory>"
	println ""
}
*/

File stylesheet = new File('scripts/fix-penn.xsl')
if (!stylesheet.exists())
{
	println "Unable to load the stylesheet."
	return
}

File indir = new File('data/working/release')
if (!indir.exists())
{
	println "Unable to find the input directory."
	return
}

File outdir = new File('data/working/staging')
if (!outdir.exists())
{
	println "Unable to find the output directory."
	return
}

Transformer transformer = new Transformer(stylesheet)
indir.eachFileMatch(~/.*-penn.xml/) { infile ->
	File outfile = new File(outdir, infile.name)
	println "Transforming ${infile.name}"
	transformer.transform(infile, outfile)
}