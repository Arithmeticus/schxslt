<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:ex="http://example.com" 
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://www.w3.org/1999/XSL/Transform" prefix="xsl"/>
    <sch:ns uri="http://example.com" prefix="ex"/>
    <xsl:param name="report-test" as="xs:boolean" select="true()"/>
    <xsl:variable name="element-a" as="element()">
        <a>
            <b/>
            <c/>
        </a>
    </xsl:variable>
    <xsl:function name="ex:imprint-name" as="element()">
        <xsl:param name="element-name" as="element()"/>
        <xsl:apply-templates select="$element-name" mode="imprint-name"/>
    </xsl:function>
    <xsl:template match="*" mode="imprint-name">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="concat('name: ', name(.), ' ')"/>
            <xsl:apply-templates mode="#current"/>
        </xsl:copy>
    </xsl:template>
    <sch:pattern>
        <sch:rule context="*">
            <sch:report test="$report-test">Test: <sch:value-of select="ex:imprint-name($element-a)"
                /></sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>