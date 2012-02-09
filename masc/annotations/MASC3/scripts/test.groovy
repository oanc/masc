
import org.anc.constants.Constants
import org.anc.constants.Constants.Default

class MyConstants extends Constants
{
	@Default("Bonjour")
	public static final String HELLO = null
	
	public MyConstants()
	{
		super.init()
	}
}

MyConstants C = new MyConstants()
println "Host name is ${System.getenv('HOSTNAME')}";
println "${C.HELLO}"