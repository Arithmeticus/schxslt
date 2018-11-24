<p:declare-step version="1.0" name="compile-schematron" type="schxslt:compile-schematron"
                xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:schxslt="http://dmaus.name/ns/schxslt">

  <p:option name="phase" select="''"/>

  <p:input  port="source" primary="true"/>
  <p:output port="result" primary="true"/>

  <p:serialization port="result" indent="true"/>

  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="../xslt/include.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>
  </p:xslt>

  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="../xslt/expand.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>
  </p:xslt>

  <p:xslt name="compile">
    <p:with-param name="phase" select="$phase"/>
    <p:input port="stylesheet">
      <p:document href="../xslt/compile.xsl"/>
    </p:input>
  </p:xslt>

</p:declare-step>