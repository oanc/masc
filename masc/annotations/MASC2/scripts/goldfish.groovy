/*
 * The "classic" Goldfish example from Gate.
 *
 * Run the default tokenizer and sentece splitter, annotate all occurences
 * of the word "goldfish" and save the generated annotations.
 */
 
import gate.Document
import gate.Factory
import gate.AnnotationSet
import gate.Annotation
import gate.FeatureMap
import gate.creole.metadata.*
import gate.creole.*

//import org.anc.io.SuffixFilter

File root = new File('../data/data')
//def filter = new SuffixFilter('.txt', false)

@CreoleResource
class GoldfishPR extends gate.creole.AbstractLanguageAnalyser
{
	String inputASName
	String outputASName
	
	void execute()
	{
		println "Running goldfish PR on document ${document.sourceUrl.toExternalForm()}"
	}
}

/*
def tokenizer = newResource('gate.creole.tokeniser.DefaultTokeniser') {
	annotationSetName('Annie')
}

def splitter = newResource('gate.creole.splitter.SentenceSplitter') {
	inputASName('Annie')
	outputASName('Annie')
}
*/
FeatureMap fm = Factory.newFeatureMap()
fm.annotationSetName = 'Annie'
def tokenizer = Factory.createResource('gate.creole.tokenizer.DefaultTokeniser', fm)

fm = Factory.newFeatureMap()
fm['inputASName'] = 'Annie'
fm['outputASName'] = 'Annie'
def splitter = Factory.createResource('gate.creole.splitter.SentenceSplitter', fm)

//def datastore = Factory.createDataStore('gate.persist.SerialDataStore', 'file:/D:/Temp/Datastore')
//datastore.open()

println "Creating corpus"
/*
def corpus = newCorpus('Transient corpus') {
	root.listFiles(filter).each { file ->
		println "Adding document ${file.path}"
		addDocument(file)
	}
}
*/
def corpus = Factory.newCorpus('Goldfish Corpus')
root.listFiles().each {
	if (it.name.endsWith('.txt'))
		corpus.add(Factory.newDocument(it.toURI().toURL(), 'UTF-8'))
}
//def persistedCorpus = datastore.adopt(corpus, null)

//println "Goldfish class is ${GoldfishPR.class}"

def pr = new GoldfishPR()
pr.inputASName = 'Annie'
pr.outputASName = 'Goldfish'

gate.Gate.getCreoleRegister().registerComponent(pr.class)
//ResourceData data = new ResourceData()
//gate.Gate.getCreoleRegister().put(pr.class.name, data)
println "Setting up pipeline."
def pipeline = Factory.createResource('gate.creole.SerialAnalyserController', Factory.newFeatureMap())
pipeline.setCorpus(corpus)
pipeline.add(tokenizer)
pipeline.add(splitter)
pipeline.add(pr)
println "Running pipeline."
//pipeline.execute()
println "Synchronizing data store."
//datastore.sync(persistedCorpus)
//datastore.close()
println "Done."
/*
def process = { pr, document ->
	pr.document = document
	pr.execute()
	pr.document = null
}

root.listFiles(filter).each { file -> 
	println "Processing ${file.name}"
	gate.Document doc = newDocument(file)
	[tokenizer, splitter].each { pr ->
		process(pr, doc)
	}
	def tokens = doc.getAnnotations('Tokens').toList()
	Collections.sort(tokens, new gate.util.OffsetComparator())
	String content = doc.content.toString()
	tokens.each { token ->
		if (token.type == 'Token')
		{
			int start = token.startNode.offset.intValue()
			int end = token.endNode.offset.intValue()
			println "${start} ${token.type} ${content[start..end-1]}"
		}
	}
}

*/