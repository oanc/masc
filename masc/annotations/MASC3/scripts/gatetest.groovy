
File gateHome  = new File(System.getenv("GATE_HOME"))
File lib = new File(gateHome, "lib")
File gateJar = new File(gateHome, "bin/gate.jar")

this.class.classLoader.rootLoader.addURL( gateJar.toURI().toURL() )

def doc = gate.Factory.newDocument()
println "Gate document created."