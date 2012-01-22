import javax.xml.parsers.*
import org.xml.sax.helpers.*
import org.xml.sax.*

class Graph {
	List nodes = []
	List edges = []
	List annotations = []
	List regions = []
}

class Node {
	String id;
	List annotations = []
}

class Handler extends DefaultHandler
{
	void startDocument()
	{
		println "Starting document."
	}
	
	void startElement(String ns, String localName, String qName, Attributes atts)
	{
		println "${ns} ${localName} ${qName}"
		if (atts.length > 0)
		{
			for (int i=0; i < atts.length; ++i)
			{
				println "   ${atts.getQName(i)} = ${atts.getValue(i)}"
			}
		}
	}
	
	void endDocument()
	{
		println "Ending document."
	}
	
	
}
File file = new File('../data/data/wsj_0006-ne.xml')
def reader = XMLReaderFactory.createXMLReader()
reader.setContentHandler(new Handler())
InputSource source = new InputSource(new FileReader(file))
reader.parse(source)

