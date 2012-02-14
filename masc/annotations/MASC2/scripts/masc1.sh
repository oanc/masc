# Converts the files from MASC 1 into the new GrAF format and puts them the
# the release folder. Also processes the recent fixes to MASC 1.

source ./config.sh

echo running masc1.sh

echo Converting MASC One written.
groovy scripts/masc1.groovy D:/Corpora/MASC-1.0.3/data/written $WORK/release
echo Converting MASC One spoken.
groovy scripts/masc1.groovy D:/Corpora/MASC-1.0.3/data/spoken $WORK/release

echo Converting MASC One fixes.
groovy scripts/convert.groovy C:/Users/Keith/Dropbox/MASC2-3/MASC1-fixes $WORK/release
 