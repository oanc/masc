These are the scripts need to generate MASC 2.

These scripts will:

1. Download the raw data from Subversion
2. Download the source code for all required applications from Subversion.
3. Build all the required applications with Maven
3. Process the data with the applications and prepare the release packages.

The intent is that users can check out this scripts directory and then run
	> ./release.sh build

and all the magic will happen.


PREREQUISITES

1. Java 5 or later.
2. Gate 6.0
3. Groovy 1.8.4
4. Grate 0.0.2


SCRIPTS

All of the work is done by Bash scripts, which in turn launch Java or Groovy programs that to the actual work. The main Bash scripts are:


release.sh
This is the main script and runs the entire pipeline. Run the script with the "build" parameter to cause all programs to be rebuilt with Maven.


build.sh:build-all.sh
Use these to get the required Java applications from Subvsion and build with Maven.


prep.sh
Processes the Sentence, Penn tokens, NE, NC, and VC files and convert into GrAF. 


header.sh
Generates the GrAF header files from the information in the CSV file.


mpqa.sh
Converts the MPQA Gate documents to GraF and aligns with the original text.


ptb.sh
framenet.sh
These two scripts are similar; convert the input formats to GrAF and run the alignment program.


fix-id.sh
Add id elements to sentence annotations that do not have them.


fix-alignment.sh
Trims whitespace from annotations.


tokenize.sh
Extracts the token elements from the PTB and Framenet files and generates the ptbtok, fntok, and seg files.


update-headers.sh
Updates the <annotations> section in each document header so all annotation types are included.


link-tokens.sh
Links MPQA, NE, NC, and NC annotations to the Penn tokens rather than regions in the text.


parse-all.sh
Sanity check. Parse all the generated files with the GraphParser and make sure nothing throws an exception.


check-align.sh
Checks annotations for leading or trailing whitespace. These problems should have been fixed in the fix-alignment.sh script, but we check again.


convert.sh
Converts the old GrAF format to the new GrAF format.


masc1.sh
Converts the MASC1 files to the new GrAF format and puts them in the release directory with the MASC2 files.


validate.sh
Validates headers and standoff annotation files with the latest GrAF schemas.






