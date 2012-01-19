class Offset 
{
	int start
	int end
	
	public Offset(int start, int end)
	{
		this.start = start
		this.end = end
	}
	
	boolean equals(other)
	{
		println "Equating"
		return (other.start == start) && (other.end == end)
	}
	
	int compareTo(other)
	{
		println "comparing"
		return other.start - start
	}
	
	String toString()
	{
		"[${start}, ${end}]"
	}
}

def o1 = new Offset(0, 5)
def o2 = new Offset(6, 10)
def o3 = new Offset(0, 5)
def o4 = new Offset(6,10)

def list1 = [o1, o2]
def list2 = [o1, o3, o4]

list1.intersect(list2).each {  println "${it}" }
