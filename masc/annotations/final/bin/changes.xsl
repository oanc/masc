<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:graf="http://www.tc37sc4.org/graf-v0.1.6" xmlns:xces="http://www.xces.org/schema/2003"
    exclude-result-prefixes="#default xces graf">

<!-- A stylesheet to update the revisionDesc section of the header. -->

 <!-- Parameters for the stylesheet.  See Transformer.setParameter(String,Object) for
  !   more details.
  !-->
<xsl:param name="date">2009-04-30</xsl:param>
<xsl:param name="item">Made some changes</xsl:param>
<xsl:param name="name">KBS</xsl:param>

<xsl:strip-space elements="*"/>
<xsl:output indent="yes"/>

<!-- Match the root element and start applying templates. -->
<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>


<!-- Match nodes in the XML tree. Make a copy of the node, process attributes (if any)
 !    and recursively apply templates.
 !-->
<xsl:template match="node()">
    <xsl:copy>
        <xsl:apply-templates select="@*"/>
        <xsl:apply-templates/>
    </xsl:copy>
</xsl:template>

<!-- Make copies of text nodes and attribute nodes. -->
<xsl:template match="text()|@*">
    <xsl:copy-of select="."/>
</xsl:template>

<!-- Process revisionDesc elements. -->
<xsl:template match="xces:revisionDesc">
    <!-- Make a copy of the revisionDesc node -->
    <xsl:copy>
        <!-- Copy any attributes and recursively process the content of the revisionDesc element. -->
        <xsl:apply-templates select="@*"/>
        <xsl:apply-templates/>
        <!-- Append the following change node to the revisionDesc with information from
         !   the command line parameters.
         -->
        <change xmlns="http://www.xces.org/schema/2003">
            <changeDate><xsl:value-of select="$date"/></changeDate>
            <respName><xsl:value-of select="$name"/></respName>
            <item><xsl:value-of select="$item"/></item>
        </change>
    </xsl:copy>
</xsl:template>

</xsl:stylesheet>
