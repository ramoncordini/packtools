<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

    <xsl:template match="article" mode="data-availability">
        <xsl:choose>
            <xsl:when test=".//*[@sec-type='data-availability']">
                <!-- ficará destacado naturalmente por ser uma seção -->
            </xsl:when>
            <xsl:when test=".//*[@fn-type='data-availability'] or .//article-meta/supplementary-material or .//element-citation[@publication-type='data' or @publication-type='database']">
                <xsl:apply-templates select="." mode="data-availability-menu-title"/>
                <xsl:choose>
                    <xsl:when test="sub-article[@xml:lang=$TEXT_LANG and @article-type='translation']">
                        <!-- sub-article -->
                        <xsl:apply-templates select="sub-article[@xml:lang=$TEXT_LANG and @article-type='translation']" mode="doc-version-data-availability"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- article -->
                        <xsl:apply-templates select="." mode="doc-version-data-availability"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates select=".//article-meta/supplementary-material" mode="data-availability"/>
                <xsl:apply-templates select="back//ref-list" mode="data-availability"/>
            </xsl:when>
        </xsl:choose>
        
    </xsl:template>

    <xsl:template match="article | sub-article" mode="doc-version-data-availability">
        <xsl:apply-templates select="body | back" mode="data-availability"/>
    </xsl:template>

    <xsl:template match="body | back" mode="data-availability">
        <xsl:apply-templates select=".//sec[@sec-type='supplementary-material']" mode="data-availability"/>
        <xsl:apply-templates select=".//*[@fn-type='data-availability']" mode="data-availability"/>
    </xsl:template>

    <xsl:template match="article" mode="data-availability-menu-title">
        <xsl:variable name="title">
            <xsl:apply-templates select="." mode="text-labels">
                <xsl:with-param name="text">Data availability</xsl:with-param>
            </xsl:apply-templates>
        </xsl:variable>
        <div class="articleSection">
            <xsl:attribute name="data-anchor"><xsl:value-of select="$title"/></xsl:attribute>
            <h1 class="articleSectionTitle"><xsl:value-of select="$title"/></h1>
        </div>
    </xsl:template>

    <xsl:template match="ref-list" mode="data-availability">
        <xsl:if test=".//element-citation[@publication-type='data' or @publication-type='database']">
            <h2><xsl:apply-templates select="." mode="text-labels">
                    <xsl:with-param name="text">Data citations</xsl:with-param>
                </xsl:apply-templates></h2>
            <xsl:apply-templates select=".//element-citation[@publication-type='data' or @publication-type='database']" mode="data-availability"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="article-meta/supplementary-material" mode="data-availability">
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <p>
                    <xsl:apply-templates select="."/>
                </p>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="element-citation[@publication-type='data' or @publication-type='database']" mode="data-availability">
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <p>
                    <xsl:apply-templates select="../mixed-citation"/>
                </p>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="sec[@sec-type='supplementary-material']" mode="data-availability">
        <xsl:apply-templates select="."/>
    </xsl:template>

    <xsl:template match="fn" mode="data-availability">
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <xsl:apply-templates select="p" mode="data-availability"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="fn/*" mode="data-availability">
        <p>
            <xsl:apply-templates select="*|text()"/>
        </p>
    </xsl:template>

</xsl:stylesheet>