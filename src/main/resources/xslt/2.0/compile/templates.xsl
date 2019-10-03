<!-- Compiler templates -->
<xsl:transform version="2.0"
               xmlns="http://www.w3.org/1999/XSL/TransformAlias"
               xmlns:sch="http://purl.oclc.org/dsdl/schematron"
               xmlns:schxslt="https://doi.org/10.5281/zenodo.1495494"
               xmlns:schxslt-api="https://doi.org/10.5281/zenodo.1495494#api"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Match templates; set as both #default and compile-sch-xslt to facilitate importing into other xslt files -->
  <xsl:template match="sch:assert" mode="#default compile-sch-xslt">
    <if test="not({@test})">
      <xsl:sequence select="@xml:base"/>
      <xsl:call-template name="schxslt-api:failed-assert">
        <xsl:with-param name="assert" as="element(sch:assert)" select="."/>
      </xsl:call-template>
    </if>
  </xsl:template>

  <xsl:template match="sch:report" mode="#default compile-sch-xslt">
    <if test="{@test}">
      <xsl:sequence select="@xml:base"/>
      <xsl:call-template name="schxslt-api:successful-report">
        <xsl:with-param name="report" as="element(sch:report)" select="."/>
      </xsl:call-template>
    </if>
  </xsl:template>

  <xsl:template match="sch:name" mode="#default compile-sch-xslt">
    <value-of select="{if (@path) then @path else 'name()'}">
      <xsl:sequence select="@xml:base"/>
    </value-of>
  </xsl:template>

  <xsl:template match="sch:value-of" mode="#default compile-sch-xslt">
    <value-of select="{@select}">
      <xsl:sequence select="@xml:base"/>
    </value-of>
  </xsl:template>

  <!-- Named templates -->
  <xsl:template name="schxslt:let-variable">
    <xsl:param name="bindings" as="element(sch:let)*"/>
    <xsl:for-each select="$bindings">
      <variable name="{@name}" select="{@value}">
        <xsl:sequence select="(@xml:base, ../@xml:base)[1]"/>
      </variable>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="schxslt:let-param">
    <xsl:param name="bindings" as="element(sch:let)*"/>
    <xsl:for-each select="$bindings">
      <param name="{@name}" select="{@value}">
        <xsl:sequence select="(@xml:base, ../@xml:base)[1]"/>
      </param>
    </xsl:for-each>
  </xsl:template>

</xsl:transform>
