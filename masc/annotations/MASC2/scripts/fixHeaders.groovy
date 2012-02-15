import org.xces.graf.header.*
import org.xces.graf.header.io.*
import org.xces.graf.header.document.*

if (this.args.length != 1)
{
	println "USAGE: groovy fixHeaders.groovy <directory>"
	return
}

File root = new File(this.args[0])
if (!root.exists())
{
	println "Directory not  found."
	return
}

DocumentHeaderStream stream = new DocumentHeaderStream();

def q = new LinkedList<File>()
q << root
while (!q.isEmpty())
{
	File entry = q.removeFirst()
	if (entry.isDirectory())
	{
		entry.eachFile 
		{ 
			q << it
		}
	}
	else if (entry.name.endsWith('.hdr'))
	{
		println "Loading ${entry.path}"
		DocumentHeader header = stream.read(entry)
		boolean save = false
		header.profileDesc.annotations.each { annotation ->
			switch (annotation.fId)
			{
				case 'f.np':
					save = true
					annotation.fId = 'f.nc'
					annotation.loc = annotation.loc.replace('-np.xml', '-nc.xml')
					break
				case 'f.vp':
					save = true
					annotation.fId = 'f.vc'
					annotation.loc = annotation.loc.replace('-vp.xml', '-vc.xml')
					break
				case 'f.hepple':
					save = true
					annotation.fId = 'f.penn'
					annotation.loc = annotation.loc.replace('-hepple.xml', '-penn.xml')
					break
			}
		}
		if (save)
		{
			println "Saving ${entry.path}"
			entry.withWriter('UTF-8') { writer ->
				stream.write(header, writer)
			}
		}
	}
}