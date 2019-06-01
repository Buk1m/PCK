<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns="http://www.w3.org/2000/svg"
                xmlns:xlink="http://www.w3.org/1999/xlink">
    <xsl:output method="xml" media-type="image/svg" encoding="utf-8" indent="yes"
                doctype-public="-//W3C//DTD SVG 1.1//EN"
                doctype-system="http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"/>
    <xsl:template match="/">
        <svg:svg width="1000" height="2280" font-family="Calibri">
            <svg:title>Raport</svg:title>
            <svg:desc>Witaj w bibliotece gier</svg:desc>
            <script type="text/javascript">
                <![CDATA[
                function onClickAutorzy(evt) {
                    var element = document.getElementById("autorzy");
                    var atrybut = element.getAttribute("visibility");
                    if(atrybut === "visible"){
                        element.setAttribute("visibility", "hidden");
                    }else{
                        element.setAttribute("visibility", "visible");
                    }
                }]]>
            </script>

            <style>
                .bar:hover
                {
                fill: #71B280;
                }

                .button:hover
                {
                fill: #71B280;
                }

                .wykres_tlo:hover
                {
                fill: #575757;
                }
            </style>

            <svg:defs>
                <svg:linearGradient id="bg-darker">
                    <svg:stop offset="0%" style="stop-color: #000000;"/>
                    <svg:stop offset="100%" style="stop-color: #434343;"/>
                </svg:linearGradient>
                <svg:linearGradient id="bg">
                    <svg:stop offset="0%" style="stop-color: #000000;"/>
                    <svg:stop offset="100%" style="stop-color: #323232;"/>
                </svg:linearGradient>
                <svg:linearGradient id="bar">
                    <svg:stop offset="0%" style="stop-color: #134E5E;"/>
                    <svg:stop offset="100%" style="stop-color: #71B280;"/>
                </svg:linearGradient>
            </svg:defs>

            <svg:rect x="0" y="0" width="860" height="1360" rx="10" ry="10" fill="url(#bg)"/>
            <xsl:apply-templates/>
            <xsl:apply-templates select="autorzy"/>
        </svg:svg>
    </xsl:template>
    <xsl:template match="statystyki">
        <svg:g id="rect">
            <svg:rect x="130" y="90" height="1220" width="600" fill="#323232" stroke="black"/>
            <svg:text x="430" y="130" font-size="16" fill="white" font-weight="bold" text-anchor="middle">
                Podział gier według gatunku
            </svg:text>
        </svg:g>

        <svg:g id="figure" class="bar">

            <xsl:for-each select="*[starts-with(name(), 'liczba')]">
                <xsl:variable name="y_pozycja" select="175 + (60 * (position() - 1))"/>
                <xsl:variable name="scale"
                              select="//statystyki/*[starts-with(name(), 'liczba')][position() &lt;= 3][not(. &lt; ../../*[starts-with(name(), 'liczba')][position() &lt;= 3])][1]"/>
                <xsl:variable name="scaled_width" select=". * 460 div $scale"/>
                <xsl:variable name="text_pos" select="$scaled_width div 2"/>

                <xsl:element name="svg:text">
                    <xsl:attribute name="y">
                        <xsl:value-of select="$y_pozycja - 10"/>
                    </xsl:attribute>
                    <xsl:attribute name="x">
                        <xsl:value-of select="200"/>
                    </xsl:attribute>
                    <xsl:attribute name="fill">white</xsl:attribute>
                    <xsl:attribute name="font-size">10</xsl:attribute>
                    <xsl:attribute name="text-anchor">left</xsl:attribute>
                    <xsl:text>Liczba </xsl:text>
                    <xsl:call-template name="substring-after-last">
                        <xsl:with-param name="input" select="name()"/>
                        <xsl:with-param name="marker" select="'_'"/>
                    </xsl:call-template>
                    <xsl:text>: </xsl:text>
                </xsl:element>

                <svg:g id="{name()}" visibility="visible">
                    <xsl:element name="svg:rect">
                        <xsl:attribute name="class">bar</xsl:attribute>
                        <xsl:attribute name="fill">url(#bar)</xsl:attribute>
                        <xsl:attribute name="y">
                            <xsl:value-of select="$y_pozycja - 5"/>
                        </xsl:attribute>
                        <xsl:attribute name="x">
                            <xsl:value-of select="200"/>
                        </xsl:attribute>
                        <xsl:attribute name="height">25</xsl:attribute>
                        <svg:animate id="bar-animation" attributeName="width" from="1" to="{. * 460 div $scale}"
                                     dur="2s"
                                     fill="freeze"/>

                    </xsl:element>
                    <xsl:element name="svg:text">
                        <xsl:attribute name="y">
                            <xsl:value-of select="$y_pozycja +12"/>
                        </xsl:attribute>
                        <xsl:attribute name="x">
                            <xsl:value-of select="200 + $text_pos"/>
                        </xsl:attribute>
                        <xsl:attribute name="opacity">
                            <xsl:value-of select="0"/>
                        </xsl:attribute>
                        <xsl:attribute name="fill">white</xsl:attribute>
                        <xsl:attribute name="font-size">16</xsl:attribute>
                        <xsl:choose>
                            <xsl:when test=". > 0">
                                <xsl:attribute name="text-anchor">middle</xsl:attribute>
                                <xsl:value-of select="."/>
                            </xsl:when>
                            <xsl:otherwise>

                                <xsl:text>brak</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                        <svg:animate id="label-animation" attributeName="opacity" from="0" to="1" dur="0.8s" begin="2s;"
                                     fill="freeze"/>
                    </xsl:element>
                    <svg:svg>
                        <text id="thepopup" x="180" y="{$y_pozycja+12}" text-anchor="end" font-size="18" fill="white" visibility="hidden">
                            <xsl:text>Liczba </xsl:text>
                            <xsl:call-template name="substring-after-last">
                                <xsl:with-param name="input" select="name()"/>
                                <xsl:with-param name="marker" select="'_'"/>
                            </xsl:call-template>
                            <xsl:text>: </xsl:text>
                            <set attributeName="visibility" from="hidden" to="visible" begin="{name()}.mouseover"
                                 end="{name()}.mouseout"/>
                        </text>
                    </svg:svg>
                </svg:g>

            </xsl:for-each>

        </svg:g>
    </xsl:template>

    <xsl:template match="autorzy">
        <svg:g id="autorzy_pliku" width="100" height="60" onclick="onClickAutorzy(evt)"
               cursor="pointer">
            <svg:rect x="15" y="20" class="button" width="100" height="32" fill="url(#bar)" stroke="black" rx="10"
                      ry="10"/>
            <svg:text x="40" y="41" fill="white" font-size="16">Autorzy</svg:text>
        </svg:g>
        <svg:g id="autorzy" visibility="hidden">
            <svg:rect x="130" y="20" width="600" height="30" fill="url(#bar)" stroke="black"/>
            <svg:text x="420" y="40" font-size="16" fill="white" text-anchor="middle">
                <xsl:apply-templates/>
            </svg:text>
        </svg:g>
    </xsl:template>

    <xsl:template match="autor">
        <xsl:value-of select="concat(imie, ' ')"/>
        <xsl:value-of select="concat(nazwisko, ' ')"/>
        <xsl:value-of select="concat(indeks, ' ')"/>
    </xsl:template>

    <xsl:template name="substring-after-last">
        <xsl:param name="input"/>
        <xsl:param name="marker"/>
        <xsl:choose>
            <xsl:when test="contains($input,$marker)">
                <xsl:call-template name="substring-after-last">
                    <xsl:with-param name="input" select="substring-after($input,$marker)"/>
                    <xsl:with-param name="marker" select="$marker"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$input"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="text()"/>


</xsl:stylesheet>