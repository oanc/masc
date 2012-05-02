import javax.xml.bind.*
import org.xces.graf.header.jaxb.*
import org.anc.io.*

if (this.args.length != 1)
{
	println "USAGE: headers.groovy <directory"
	return
}

File directory = new File(this.args[0])
if (!directory.exists())
{
	println "${directory.name} does not exist"
	return
}

JAXBContext context = JAXBContext.newInstance(CesHeader.class)
Marshaller xml = context.createMarshaller()
xml.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE)

ObjectFactory factory = new ObjectFactory();
def types = ['logical', 's', 'penn', 'ne', 'nc', 'vc']
def files = directory.listFiles(new SuffixFilter(".txt"))
files.each { file ->
	println "Generating header for ${file.name}"
	CesHeader header = factory.createCesHeader()
	headerFile.withWriter('UTF-8') { writer ->
		//xml.toXml(header, writer)
		xml.marshall(header, writer)
	}
}

/*
	ProfileDesc profileDesc = factory.createProfileDesc()
	header.profileDesc = profileDesc
	
	PrimaryData primaryData = factory.createPrimaryData()
	primaryData.loc = file.name
	profileDesc.primaryData = primaryData
	
	Annotations annotations = factory.createAnnotations()
	profileDesc.annotations = annotations

	TextClass textClass = factory.createTextClass()
	textClass.catRef = 'WR'
	profileDesc.textClass = textClass
	
	types.each { type ->
		File soFile = new File(file.parent, file.name.replace('.txt', "-${type}.xml"))
		if (soFile.exists())
		{
			def a = factory.createAnnotation()
			a.annLoc = "file-${type}.xml"
			a.type = type
			annotations.annotation << a
		}
	}
	File headerFile = new File(file.parent, file.name.replace('.txt', '.anc'))
	//xml.marshall(header, headerFile)
	//header.headerFile = headerFile
	//m.marshall(header, new FileOutputStream(headerFile))
	headerFile.withWriter('UTF-8') { writer ->
		//xml.toXml(header, writer)
		xml.marshall(header, writer)
	}
}
*/
println "Done."