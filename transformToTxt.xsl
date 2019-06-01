<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="text" encoding="UTF-8"/>
	<xsl:variable name="indent-size" select="4" />
	<xsl:template match="/">
		<xsl:text>## STATYSTYKI BIBLIOTEKI ##&#xA;</xsl:text>
		<xsl:for-each select="//statystyki/*[starts-with(name(), 'liczba')][position() &lt;= 3]">
			<xsl:text>Liczba </xsl:text>
			<xsl:value-of select="substring-after(name(),'_')"/>
			<xsl:text>&#x9;</xsl:text>
			<xsl:value-of select="."/>
			<xsl:text>&#xA;</xsl:text>
		</xsl:for-each>
		<xsl:text>&#xA;</xsl:text>
		<xsl:text>&#xA;## STATYSTYKI GIER ##&#xA;</xsl:text>
		<xsl:for-each select="//statystyki/*[starts-with(name(), 'liczba')][position() &gt; 3]">
			<xsl:text>&#xA;----------------------------&#xA;</xsl:text>
			<xsl:text>Liczba </xsl:text>
			<xsl:call-template name="substring-after-last">
				<xsl:with-param name="input" select="name()"/>
				<xsl:with-param name="marker" select="'_'"/>
			</xsl:call-template>
			<xsl:text>: </xsl:text>
			<xsl:value-of select="."/>
			<xsl:text>&#xA;</xsl:text>
		</xsl:for-each>
		<xsl:text>&#xA;## CALKOWITY KOSZT ##&#xA;</xsl:text>
		<xsl:value-of select="//statystyki/koszt_wszystkich_gier"/>
		<xsl:text>&#xA;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#xA;## ZESTAWIENIE GIER ##&#xA;</xsl:text>
		<xsl:for-each select="//zestawienie_gier/gra">
			<xsl:text>&#xA;----------------------------&#xA;</xsl:text>
			<xsl:value-of select="tytul"/>
			<xsl:text>&#xA;</xsl:text>
			<xsl:choose>
				<xsl:when test="count(recenzje_gry/recenzja) &gt; 0">
					<xsl:text>Recenzje gry:&#xA;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Brak recenzji.&#xA;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each select="recenzje_gry/recenzja">
				<xsl:text>Autor:&#xA;</xsl:text>
				<xsl:value-of select="gracz"/>
				<xsl:text>&#xA;</xsl:text>
				<xsl:value-of select="tresc"/>
				<xsl:text>&#xA;</xsl:text>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:text>Data utworzenia:</xsl:text>
		<xsl:value-of select="//data_utworzenia_raportu"/>
	</xsl:template>
	<xsl:template match="autorzy">
		<xsl:text> ## AUTORZY DOKUMENTU ##&#xA;</xsl:text>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="autor">
		<xsl:text>&#x9;[</xsl:text>
		<xsl:value-of select="./indeks" />
		<xsl:text>] </xsl:text>
		<xsl:value-of select="./imie" />
		<xsl:text></xsl:text>
		<xsl:value-of select="./nazwisko" />
		<xsl:text>&#xA;</xsl:text>
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