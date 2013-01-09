<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns="http://www.xces.org/ns/GrAF/1.0/"
    xmlns:graf="http://www.xces.org/ns/GrAF/1.0/"
    version="2.0">
    <xsl:param name="prefix"/>
    
    <!-- Updates GrAF 0.99.2 file to GrAF 1.0 -->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="graf:graph">
        <graph>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </graph>
    </xsl:template> 
    

    <xsl:template match="graf:header">
        <graphHeader>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </graphHeader>
    </xsl:template> 
    
    <xsl:template match="graf:tagsDecl">
        <labelsDecl>
            <xsl:apply-templates/>
        </labelsDecl>
    </xsl:template>
    
    <xsl:template match="graf:tagUsage">
        <labelUsage>
            <xsl:attribute name="label"><xsl:value-of select="@gi"/></xsl:attribute>
            <xsl:attribute name="occurs"><xsl:value-of select="@occurs"/></xsl:attribute>
            <xsl:apply-templates/>
        </labelUsage>
    </xsl:template>
    
    <xsl:template match="graf:annotationSets">
        <annotationSpaces>
            <xsl:apply-templates/>
        </annotationSpaces>
    </xsl:template>
    
    <xsl:template match="graf:annotationSet">
        <xsl:variable name="aspace"><xsl:value-of select="@name"/></xsl:variable>
        <annotationSpace>
            <xsl:choose>
                <xsl:when test="$aspace = 'PTB'">
                    <xsl:attribute name="as.id">ptb</xsl:attribute>
                </xsl:when>
                <xsl:when test="$aspace = 'FrameNet'">
                    <xsl:attribute name="as.id">fn</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="as.id"><xsl:value-of select="@name"/></xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <!-- <xsl:attribute name="xlink:href"><xsl:value-of select="@type"/></xsl:attribute> --> 
        </annotationSpace>
    </xsl:template>
    
    <xsl:template match="graf:root">
        <root>
            <xsl:attribute name="node.id"><xsl:value-of select="."/></xsl:attribute>
        </root>
    </xsl:template>
    
    <!--
    <xsl:template match="graf:a">
        <xsl:variable name="id">
            <xsl:text>a</xsl:text>
            <xsl:number level="any" count="*"/>
        </xsl:variable>
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="$id"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    -->
    <xsl:template match="graf:dependsOn">
        <xsl:copy>
            <xsl:attribute name="f.id"><xsl:value-of select="@type"/></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="graf:a">
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="$prefix"/>-<xsl:value-of select="generate-id()"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*"/>
            <xsl:choose>
                <xsl:when test="@label='nchunk'"/>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>        
    </xsl:template>
    
    <xsl:template match="graf:f">
        <xsl:copy>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:attribute name="value">
                <xsl:value-of select="@value"/>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="node()">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*">
        <xsl:choose>
            <xsl:when test="name() = 'as'">
                <xsl:variable name="value"><xsl:value-of select="."/></xsl:variable>
                <xsl:choose>
                    <xsl:when test="$value = 'PTB'">
                        <xsl:attribute name="as">ptb</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$value = 'FrameNet'">
                        <xsl:attribute name="as">fn</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="."/>                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>                        
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>