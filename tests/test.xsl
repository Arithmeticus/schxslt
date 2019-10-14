<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:dc="http://purl.org/dc/elements/1.1/"
               xmlns:sch="http://purl.oclc.org/dsdl/schematron"
               xmlns:error="https://doi.org/10.5281/zenodo.1495494#error"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
               xmlns:schxslt-api="https://doi.org/10.5281/zenodo.1495494#api"
               xmlns:schxslt="https://doi.org/10.5281/zenodo.1495494"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:ex="http://example.com"
               version="2.0">
   <rdf:Description>
      <dc:creator>SchXslt 1.4-SNAPSHOT / SAXON PE 9.8.0.12 (Saxonica)</dc:creator>
      <dc:date>2019-10-14T05:04:35.073-04:00</dc:date>
   </rdf:Description>
   <xsl:output indent="yes"/>
   <xsl:variable xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 name="element-a"
                 as="element()">
        <a>
            <b/>
            <c/>
        </a>
    </xsl:variable>
   <xsl:function xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 name="ex:imprint-name"
                 as="element()">
        <xsl:param name="element-name" as="element()"/>
        <xsl:apply-templates select="$element-name" mode="imprint-name"/>
    </xsl:function>
   <xsl:template xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 match="*"
                 mode="imprint-name">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="concat('name: ', name(.), ' ')"/>
            <xsl:apply-templates mode="#current"/>
        </xsl:copy>
    </xsl:template>
   <xsl:template match="/" mode="#default schxslt:test.sch">
      <xsl:variable name="report" as="element(schxslt:report)">
         <schxslt:report>
            <xsl:call-template name="d10e39">
               <xsl:with-param name="default-document" as="document-node()" select="."/>
            </xsl:call-template>
         </schxslt:report>
      </xsl:variable>
      <xsl:variable name="schxslt:report" as="node()*">
         <xsl:for-each select="$report/schxslt:pattern">
            <xsl:sequence select="node()"/>
            <xsl:sequence select="$report/schxslt:rule[@pattern = current()/@id]/node()"/>
         </xsl:for-each>
      </xsl:variable>
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
         <svrl:metadata>
            <dc:creator>
               <xsl:value-of select="normalize-space(concat(system-property('xsl:product-name'), ' ', system-property('xsl:product-version')))"/>
            </dc:creator>
            <dc:date>2019-10-14T05:04:35.073-04:00</dc:date>
            <dc:source>
               <rdf:Description>
                  <dc:creator>SchXslt 1.4-SNAPSHOT / SAXON PE 9.8.0.12 (Saxonica)</dc:creator>
                  <dc:date>2019-10-14T05:04:35.073-04:00</dc:date>
               </rdf:Description>
            </dc:source>
         </svrl:metadata>
         <svrl:ns-prefix-in-attribute-values prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
         <svrl:ns-prefix-in-attribute-values prefix="ex" uri="http://example.com"/>
         <xsl:sequence select="$schxslt:report"/>
      </svrl:schematron-output>
   </xsl:template>
   <!--By default, the modes employed in this schxslt file are shallow skips...-->
   <xsl:template match="text() | @*" mode="#default schxslt:test.sch d10e39"/>
   <xsl:template match="* | processing-instruction() | comment()"
                 mode="#default schxslt:test.sch d10e39">
      <xsl:apply-templates mode="#current" select="@* | node()"/>
   </xsl:template>
   <!--...but all other template modes should defer to rules specified by any imported stylesheets.-->
   <xsl:template match="document-node() | node() | @*" mode="#all" priority="-1">
      <xsl:apply-imports/>
   </xsl:template>
   <xsl:template name="d10e39">
      <xsl:param name="default-document" as="document-node()"/>
      <xsl:variable name="documents" as="item()+">
         <xsl:sequence select="$default-document"/>
      </xsl:variable>
      <xsl:for-each select="$documents">
         <xsl:variable name="this-base-uri" select="(*/@xml:base, base-uri(.))[1]"/>
         <schxslt:pattern id="d10e39@{$this-base-uri}">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
               <xsl:attribute name="documents" select="$this-base-uri"/>
            </svrl:active-pattern>
         </schxslt:pattern>
         <xsl:apply-templates mode="d10e39" select="."/>
      </xsl:for-each>
   </xsl:template>
   <xsl:template match="*" priority="1" mode="d10e39">
      <xsl:param name="schxslt:rules" as="element(schxslt:rule)*"/>
      <xsl:choose>
         <xsl:when test="empty($schxslt:rules[@pattern = 'd10e39'][@context = generate-id(current())])">
            <schxslt:rule pattern="d10e39@{base-uri(.)}">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*"/>
               <xsl:if test="$report-test">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                          location="{schxslt:location(.)}"
                                          test="$report-test">
                     <svrl:text>Test: <xsl:value-of select="ex:imprint-name($element-a)"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d10e39@{base-uri(.)}">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "*" shadowed by preceeding rule</xsl:comment>
               <xsl:message xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "*" shadowed by preceeding rule</xsl:message>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*"/>
            </schxslt:rule>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:next-match>
         <xsl:with-param name="schxslt:rules" as="element(schxslt:rule)*">
            <xsl:sequence select="$schxslt:rules"/>
            <schxslt:rule context="{generate-id()}" pattern="d10e39"/>
         </xsl:with-param>
      </xsl:next-match>
   </xsl:template>
   <xsl:function xmlns="http://www.w3.org/1999/XSL/TransformAlias"
                 xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                 name="schxslt:location"
                 as="xs:string">
      <xsl:param name="node" as="node()"/>
      <xsl:variable name="segments" as="xs:string*">
         <xsl:for-each select="($node/ancestor-or-self::node())">
            <xsl:variable name="position">
               <xsl:number level="single"/>
            </xsl:variable>
            <xsl:choose>
               <xsl:when test=". instance of element()">
                  <xsl:value-of select="concat('Q{', namespace-uri(.), '}', local-name(.), '[', $position, ']')"/>
               </xsl:when>
               <xsl:when test=". instance of attribute()">
                  <xsl:value-of select="concat('@Q{', namespace-uri(.), '}', local-name(.))"/>
               </xsl:when>
               <xsl:when test=". instance of processing-instruction()">
                  <xsl:value-of select="concat('processing-instruction(&#34;', name(.), '&#34;)[', $position, ']')"/>
               </xsl:when>
               <xsl:when test=". instance of comment()">
                  <xsl:value-of select="concat('comment()[', $position, ']')"/>
               </xsl:when>
               <xsl:when test=". instance of text()">
                  <xsl:value-of select="concat('text()[', $position, ']')"/>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>
         </xsl:for-each>
      </xsl:variable>

      <xsl:value-of select="concat('/', string-join($segments, '/'))"/>
  </xsl:function>
</xsl:transform>
