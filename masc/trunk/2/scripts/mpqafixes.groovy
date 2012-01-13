// when trying to align the annotations.  However, since the problem is /
// the same in all cases the "fix" file can be generated automatically.Fi
// when trying to align the annotations.  However, since the problem is 
// the same in all cases the "fix" file can be generated automatically.
import groovy.xml.MarkupBuilder

def writer = new StringWriter()
File dir = new File("D:/Corpora/MASC2/ci/data/working/mpqa")

def xml = new MarkupBuilder(writer)
xml.fixes() {
	dir.eachFile {
		if (it.name.endsWith('.xml')) {
			xml.fix(file:it.name) {
				source(offset:'1') {
					skip(n:'6')
				}
			} 
		}
	}
}

println writer.toString()


