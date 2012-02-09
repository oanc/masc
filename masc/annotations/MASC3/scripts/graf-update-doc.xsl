<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:graf="http://www.xces.org/ns/GrAF/1.0/"
    version="1.0">
    
    <xsl:param name="docId"/>
    
    <!-- Updates GrAF 0.99.2 file to GrAF 1.0 -->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="graf:cesHeader">
        <documentHeader xmlns="http://www.xces.org/ns/GrAF/1.0/">
            <xsl:if test="$docId">
                <xsl:attribute name="docId"><xsl:value-of select="$docId"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </documentHeader>
    </xsl:template>
    
    <xsl:template match="graf:extent">
        <xsl:copy>
            <xsl:attribute name="count"><xsl:value-of select="@wordCount"/></xsl:attribute>
            <xsl:attribute name="unit">word</xsl:attribute>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="graf:wsdUsage"/>
    <xsl:template match="graf:encodingDesc"/>
    <xsl:template match="graf:medium"/>
    
    <xsl:template match="graf:sourceDesc">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:choose>
                <xsl:when test="graf:biblStruct">
                    <xsl:apply-templates select="graf:title"/>
                    <xsl:apply-templates select="graf:biblStruct/graf:monogr/graf:imprint/*"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="graf:email">
        <eAddress xmlns="http://www.xces.org/ns/GrAF/1.0/">
            <xsl:attribute name="type">email</xsl:attribute>
            <xsl:apply-templates/>
        </eAddress>
    </xsl:template>
    
    <xsl:template match="graf:url">
        <eAddress xmlns="http://www.xces.org/ns/GrAF/1.0/">
            <xsl:attribute name="type">url</xsl:attribute>
            <xsl:apply-templates/>
        </eAddress>
    </xsl:template>
    
    <xsl:template match="graf:primaryData">
    	<xsl:copy>
   	        <xsl:attribute name="f.id">text</xsl:attribute>
    	    <xsl:attribute name="loc"><xsl:value-of select="@loc"/></xsl:attribute>
    	</xsl:copy>
    </xsl:template>
    
    <xsl:template match="graf:annotation">
        <xsl:if test="@type!='content'">
            <annotation xmlns="http://www.xces.org/ns/GrAF/1.0/">
                <xsl:attribute name="loc"><xsl:value-of select="@ann.loc"/></xsl:attribute>
                <xsl:attribute name="f.id">f.<xsl:value-of select="@type"/></xsl:attribute>
            </annotation>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="graf:person">
    	<xsl:copy>
    		<xsl:attribute name="xml:id"><xsl:value-of select="@id"/></xsl:attribute>
    	    <xsl:if test="@age">
    	        <xsl:attribute name="age"><xsl:value-of select="@age"/></xsl:attribute>
    	    </xsl:if>
    	    <xsl:if test="@sex">
    	        <xsl:attribute name="sex"><xsl:value-of select="@sex"/></xsl:attribute>
    	    </xsl:if>
    	</xsl:copy>
    </xsl:template>
    <xsl:template match="node()">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*">
        <xsl:copy-of select="."/>
    </xsl:template>
</xsl:stylesheet>