To process the MASC data from scratch:

1. prep-release all
   Processes all text, headers and standoff annotation files. Transforms and
   aligns PTB and FrameNet files. Also copies corrected files from
   MASC_CORRECTIONS to the output directory.
2. fix-ids.bat
   Scans the sentence standoff files and generates any missing sentence id values.
3. tokenize.bat
   Performs Quarkification on Penn, PTB, and FrameNet files. Generates the ptbtok,
   fntok, and seg files.
4. Run the HeaderEditor (Brian).
      - Validate the headers with options to create missing headers and
        update missing annotations.
      - Transform with the annotations2.xsl style sheet to add annotation 
        descriptions.
5. fix-logical.bat
   Links the XCES logical annotations into a tree hierarchy.
6. fix-edges.bat
   This runs the LinkToTokens program (Frank) to link NC, VC, and NE annotations to
   the PTB tokens.

