/* Generates an html file with a table that shows the annotation types
 * present for each file.
 */
 
import groovy.xml.MarkupBuilder

String getName(File file)
{
	String suffix = file.name[-3..-1]
	if (suffix == 'xml')
	{
		int dash = file.name.lastIndexOf('-')
		return file.name[0..dash-1]
	}
	return file.name[0..-5]
}

String getType(File file)
{
	String suffix = file.name[-3..-1]
	if (suffix == 'xml')
	{
		int dash = file.name.lastIndexOf('-')
		return file.name[dash+1..-5]
	}
	return suffix
}

List toSortedList(Set s)
{
	def list = []
	s.each { list << it }
	Collections.sort(list)
	return list
}

if (this.args.size() != 2)
 {
	println "USAGE: groovy summarize.groovy <source> <html_target>"
	return
}

File dir = new File(this.args[0])
if (!dir.exists())
{
	println "Input directory not found."
	return
}
File outdir = new File(this.args[1])
if (!outdir.exists())
{
	println "Output directory not found."
	return
}
File htmlFile = new File(outdir, 'annotations.html')
Set<String> fileNames = new HashSet<String>()
Set<String> columns = new HashSet<String>()
def rows = [:]

dir.listFiles().each {
	String name = getName(it)
	String type = getType(it)
	fileNames.add(name)
	columns.add(type)
	def row = rows[name]
	if (!row)
	{
		row = [:]
		rows[name] = row
	}
	row[type] = true
	//println "${it.name} ${getName(it)} ${getType(it)}"
}

def writer = new StringWriter()
def html = new MarkupBuilder(writer)

def files = toSortedList(fileNames)
def headings = ['txt', 'hdr', 'logical', 'penn', 'nc', 'vc', 'ne', 'mpqa', 'ptb', 'ptbtok', 'fn', 'fntok', 'seg']
//toSortedList(columns)

int count = 0;
html.html {
	html.head {
		html.title('MASC 2 Annotations')
	}
	html.body {
		html.table(border:'1') {
			files.each { name ->
				if (count % 20 == 0)
				{
					html.tr {
						html.th('Filename')
						headings.each { h ->
							html.th(h)
						}
					}
				}
				++count
				html.tr {
					html.td(name)
					def row = rows[name]
					headings.each { h ->
						if (row[h])
						{
							html.td(align:'center', bgcolor:'green', 'X')
						}
						else
						{
							html.td(bgcolor:'red', "_")
						}
					}
				}
			}
		}
	}
}

htmlFile.text = writer.toString()
println "Saved ${htmlFile.path}"