<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="BibliotekaGier"
                                       margin-top="1.5cm"
                                       margin-bottom="2cm"
                                       margin-left="2cm"
                                       margin-right="2cm">
                    page-height="29.7cm"
                    page-width="21cm"
                    <fo:region-body margin-top="2cm"/>
                    <fo:region-before extent="3cm"/>
                    <fo:region-after extent="1.5cm"/>
                    <fo:region-start extent="0.5cm"/>
                    <fo:region-end extent="0.5cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="BibliotekaGier">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="center" font-family="calibri" font-size="22px">
                        <fo:block text-align="right" font-family="monospace" font-size="8px">
                            <xsl:value-of select="//data_utworzenia_raportu"/>
                        </fo:block>
                        <fo:block font-weight="bold">
                            <xsl:text>Biblioteka gier</xsl:text>
                        </fo:block>
                    </fo:block>
                </fo:static-content>

                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="center" font-family="monospace" margin-top="2cm" font-size="8px">
                        <xsl:text>Strona: </xsl:text>
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>

                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates/>
                </fo:flow>

            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="autorzy">
        <fo:block text-align="center" font-family="calibri" font-size="22px">
            <xsl:text>Autorzy dokumentu:</xsl:text>
        </fo:block>
        <fo:list-block>
            <xsl:apply-templates/>
        </fo:list-block>

    </xsl:template>


    <xsl:template match="autor">

        <fo:list-item>
            <fo:list-item-label>
                <fo:block>*</fo:block>
            </fo:list-item-label>
            <fo:list-item-body>
                <fo:block margin-left="0.5cm">
                    <xsl:value-of select="./imie"/>
                    <xsl:text>&#032;</xsl:text>
                    <xsl:value-of select="./nazwisko"/>
                    <xsl:text>&#032;</xsl:text>
                    <xsl:value-of select="./indeks"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <xsl:template match="statystyki">
        <fo:block font-size="12px" text-align="left" font-family="verdana">
            <fo:block font-size="14px" text-align="center" font-weight="bold" margin-bottom="10px">
                <xsl:text>Statystyki</xsl:text>
            </fo:block>

            <fo:block font-size="12px" text-align="left" font-weight="bold" margin-bottom="10px">
                <xsl:text>Ogolne:</xsl:text>
            </fo:block>


            <fo:table border="solid black" width="100%" font-size="8px">
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell border="solid black">
                            <fo:block font-weight="bold" text-align="center">
                                <xsl:text>Gatunek</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid black">
                            <fo:block font-weight="bold" text-align="center">
                                <xsl:text>Ilość</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>

                <fo:table-body>
                    <xsl:for-each select="//statystyki/*[starts-with(name(), 'liczba')][position() &lt; 4]">
                        <xsl:sort select="node()"/>
                        <fo:table-row>
                            <fo:table-cell border="solid black">
                                <fo:block text-align="center">
                                    <xsl:call-template name="substring-after-last">
                                        <xsl:with-param name="input" select="name()"/>
                                        <xsl:with-param name="marker" select="'_'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="solid black">
                                <fo:block text-align="center">
                                    <xsl:value-of select="node()"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>

            <fo:block font-size="12px" text-align="left" font-weight="bold" margin-bottom="10px" margin-top="1cm">
                <xsl:text>Gier:</xsl:text>
            </fo:block>
            <fo:table border="solid black" width="100%" font-size="8px">
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell border="solid black">
                            <fo:block font-weight="bold" text-align="center">
                                <xsl:text>Gatunek</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid black">
                            <fo:block font-weight="bold" text-align="center">
                                <xsl:text>Ilość</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>

                <fo:table-body>
                    <xsl:for-each select="//statystyki/*[starts-with(name(), 'liczba')][position() &gt; 3]">
                        <xsl:sort select="node()"/>
                        <fo:table-row>
                            <fo:table-cell border="solid black">
                                <fo:block text-align="center">
                                    <xsl:call-template name="substring-after-last">
                                        <xsl:with-param name="input" select="name()"/>
                                        <xsl:with-param name="marker" select="'_'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="solid black">
                                <fo:block text-align="center">
                                    <xsl:value-of select="node()"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="koszt_wszystkich_gier">
        <fo:block margin-top="20px">
            <xsl:text>Całkowita wartość gier:</xsl:text>
            <xsl:value-of select="node()"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="zestawienie_gier">
        <fo:block page-break-before="always"/>
        <fo:block font-size="12px" text-align="left" font-family="verdana">
            <fo:block font-size="14px" text-align="center" font-weight="bold" margin-top="1.2cm" margin-bottom="10px">
                <xsl:text>Zestawienie gier</xsl:text>
            </fo:block>

            <fo:table border="solid black" width="100%" font-size="8px">
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell border="solid black">
                            <fo:block font-weight="bold" text-align="center">
                                <xsl:text>Tytul</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid black">
                            <fo:block font-weight="bold" text-align="center">
                                <xsl:text>Srednia ocena</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>

                <fo:table-body>
                    <xsl:for-each select="gra">
                        <xsl:sort select="tytul"/>
                        <fo:table-row>
                            <fo:table-cell border="solid black">
                                <fo:block text-align="center">
                                    <xsl:value-of select="tytul"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="solid black">
                                <fo:block text-align="center">
                                    <xsl:value-of select="srednia_ocena_gry"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <fo:block font-size="14px" text-align="center" font-weight="bold" margin-top="1.2cm" margin-bottom="10px">
            <xsl:text>Recenzje graczy:</xsl:text>
        </fo:block>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="recenzje_gry">
        <fo:block font-size="12px" text-align="left" font-weight="bold" margin-top="1.2cm" margin-bottom="10px">
            <xsl:value-of select="./parent::gra/tytul"/>
        </fo:block>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="recenzja">
        <fo:block margin-top="12px">
            <xsl:text>Gracz: </xsl:text>
            <xsl:value-of select="gracz"/>
            <xsl:text>&#8232;</xsl:text>
            <xsl:text>Tytuł: </xsl:text>
            <xsl:value-of select="tytul"/>
            <xsl:text>&#8232;</xsl:text>
            <xsl:text>Treść: </xsl:text>
            <xsl:value-of select="tresc"/>
            <xsl:text>&#8232;</xsl:text>
        </fo:block>


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
    <xsl:template match="text()">
    </xsl:template>

</xsl:stylesheet>