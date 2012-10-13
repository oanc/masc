<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0" xmlns:graf="http://www.xces.org/ns/GrAF/1.0/">
    <xsl:strip-space elements="graf:fs"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="graf:f">
        <xsl:choose>
            <xsl:when test="@name='msd'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="@name='base'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="@name='string'">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:when>
        </xsl:choose>    
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