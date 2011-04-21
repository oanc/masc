<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:graf="http://www.xces.org/ns/GrAF/1.0/" xmlns:xces="http://www.xces.org/schema/2003"
    xmlns="http://www.xces.org/ns/GrAF/1.0/" exclude-result-prefixes="graf">

<xsl:strip-space elements="*"/>    
<xsl:output indent="yes"/>
    
<!-- Match the root element and start applying templates. -->
<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>


<!-- Match nodes in the XML tree. Make a copy of the node, process attributes (if any)
    !    and recursively apply templates.
    !-->
<xsl:template match="xces:*">
    <xsl:element name="{local-name()}" namespace="http://www.xces.org/ns/GrAF/1.0/">
        <xsl:apply-templates select="@*"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<!-- Make copies of text nodes and attribute nodes. -->
<xsl:template match="text()|@*">
    <xsl:copy-of select="."/>    
</xsl:template>    

<!--
<xsl:template match="@*">
    <xsl:attribute name="{local-name()}" namespace="http://www.xces.org/ns/GrAF/1.0/"><xsl:value-of select="."/></xsl:attribute>
</xsl:template>
-->
<xsl:template match="comment()">
    <xsl:copy/>
</xsl:template>
    
<!-- Process annotation elements. If the annotation element doesn't include a
 !   description a default description will be added.
 !-->
<xsl:template match="xces:annotation">
    <!-- Store the description in a local variable. -->
    <xsl:variable name="content" select="."/>
    <!-- Make a copy of the node and its attributes -->
    <xsl:element name="{local-name()}" namespace="http://www.xces.org/ns/GrAF/1.0/">
        <xsl:apply-templates select="@*"/>
        <xsl:apply-templates/>
        <!-- For each annotation type test to see if the content is empty.  If the content
         !   is empty append a default description for that annotation type.
         !-->
        <xsl:choose>
            <xsl:when test="@type='content'">
                <xsl:if test="$content = ''">Document content</xsl:if>
            </xsl:when>
            <xsl:when test="@type='np'">
                <xsl:if test="$content = ''">Noun chunks</xsl:if>
            </xsl:when>
            <xsl:when test="@type='nc'">
                <xsl:if test="$content = ''">Noun chunks</xsl:if>
            </xsl:when>
            <xsl:when test="@type='logical'">
                <xsl:if test="$content = ''">Document structure</xsl:if>
            </xsl:when>
            <xsl:when test="@type='hepple'">
                <xsl:if test="$content = ''">Penn part of speech tags</xsl:if>
            </xsl:when>
            <xsl:when test="@type='penn'">
                <xsl:if test="$content = ''">Penn part of speech tags</xsl:if>
            </xsl:when>
            <xsl:when test="@type='vp'">
                <xsl:if test="$content = ''">Verb chunks</xsl:if>
            </xsl:when>
            <xsl:when test="@type='vc'">
                <xsl:if test="$content = ''">Verb chunks</xsl:if>
            </xsl:when>
            <xsl:when test="@type='s'">
                <xsl:if test="$content = ''">Sentence boundaries</xsl:if>
            </xsl:when>
            <xsl:when test="@type='ptb'">
                <xsl:if test="$content = ''">Penn Tree Bank</xsl:if>
            </xsl:when>
            <xsl:when test="@type='ptbtok'">
                <xsl:if test="$content = ''">Penn Tree Bank tokens and part of speech tags</xsl:if>
            </xsl:when>
            <xsl:when test="@type='fn'">
                <xsl:if test="$content = ''">FrameNet</xsl:if>
            </xsl:when>
            <xsl:when test="@type='fntok'">
                <xsl:if test="$content = ''">FrameNet tokens and part of speech tags</xsl:if>
            </xsl:when>
            <xsl:when test="@type='ne'">
                <xsl:if test="$content = ''">Named Entities</xsl:if>
            </xsl:when>
            <xsl:when test="@type='seg'">
                <xsl:if test="$content = ''">Base segmentation (quarks)</xsl:if>
            </xsl:when>
            <xsl:when test="@type='cb'">
                <xsl:if test="$content = ''">Committed Belief</xsl:if>
            </xsl:when>
            <xsl:when test="@type='event'">
                <xsl:if test="$content = ''">Events</xsl:if>
            </xsl:when>            
            <xsl:when test="@type='mpqa'">
                <xsl:if test="$content = ''">Multi-Perspective Question Answering opinion corpus</xsl:if>
            </xsl:when>            
        </xsl:choose>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
