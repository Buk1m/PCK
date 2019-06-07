<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" encoding="utf-8" indent="yes"/>
	<xsl:template match="/">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="raport" page-height="29,7cm" page-width="21cm" margin-top="2cm" margin-bottom="1cm" margin-left="2.5cm" margin-right="2.5cm">
					<fo:region-body margin-top="1cm"/>
					<fo:region-before extent="3cm" />
					<fo:region-after extent="1.5cm" />
					<fo:region-start extent="0.5cm" />
					<fo:region-end extent="0.5cm" />
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="raport">
				<fo:static-content flow-name="xsl-region-before">
					<fo:block text-align="center" font-family="Times-Roman" font-size="20px">
						<fo:block font-weight="bold">
							<xsl:text>Biblioteka&#x20;(raport)</xsl:text>
						</fo:block>
						<fo:block text-align="center" font-family="monospace" font-size="8px">
							<xsl:text>Data&#x20;wygenerowania:&#x20;</xsl:text>
							<xsl:value-of select="substring(//raport//utworzenia_raportu,1,10)"/>
							<xsl:text>&#x20;o&#x20;godz.&#x20;</xsl:text>
							<xsl:value-of select="substring(//raport/data_utworzenia_raportu,12,5)"/>
						</fo:block>
					</fo:block>
				</fo:static-content>
				<fo:static-content flow-name="xsl-region-after">
					<fo:block text-align="center" font-family="monospace" font-size="8px">
						<xsl:text>[&#x20;Strona&#x20;</xsl:text>
						<fo:page-number />
						<xsl:text>&#x20;]</xsl:text>
					</fo:block>
				</fo:static-content>
				<fo:flow flow-name="xsl-region-body">
					<xsl:apply-templates/>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<xsl:template match="autorzy">
		<fo:block font-size="10px" text-align="left" font-family="Times-Roman" margin="25">
			<xsl:text>Autorzy:</xsl:text>
			<xsl:apply-templates />
		</fo:block>
	</xsl:template>
	<xsl:template match="autor">
		<fo:block margin-left="0.5cm">
			<xsl:value-of select="./indeks"/>
			<xsl:value-of select="./imie"/>
			<xsl:text>&#x20;</xsl:text>
			<xsl:value-of select="./nazwisko"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="statystyki/zestawienie_gier">
		<fo:block font-size="12px" text-align="left" font-family="Times-Roman" margin-top="20px">
			<fo:block font-size="14px" text-align="center" font-weight="bold" margin-bottom="10px">
				<xsl:text>Zestawienie gier</xsl:text>
			</fo:block>
			<fo:table border="solid black" width="100%" font-size="8px">
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell border="solid black">
							<fo:block font-weight="bold" text-align="center">
								<xsl:text>Tytuł</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell border="solid black">
							<fo:block font-weight="bold" text-align="center">
								<xsl:text>Średnia ocena</xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<xsl:for-each select="./gra">
						<xsl:sort select="./tytul"/>
						<fo:table-row>
							<fo:table-cell border="solid black">
								<fo:block text-align="center">
									<xsl:value-of select="./tytul" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell border="solid black">
								<fo:block text-align="center">
									<xsl:value-of select="./srednia_ocena_gry" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</fo:block>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="statystyki">
		<fo:block font-size="12px" text-align="left" font-family="Times-Roman">
			<fo:block font-size="14px" text-align="center" font-weight="bold" margin-bottom="10px">
				<xsl:text>Statystyki</xsl:text>
			</fo:block>
			<fo:table border="solid black" width="100%" font-size="8px">
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell border="solid black">
							<fo:block font-weight="bold" text-align="center">
								<xsl:text>Tytuł</xsl:text>
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
					<xsl:for-each select="//statystyki/*[starts-with(name(), 'liczba')]">
						<fo:table-row>
							<fo:table-cell border="solid black">
								<fo:block text-align="center">
									<xsl:value-of select="name()" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell border="solid black">
								<fo:block text-align="center">
									<xsl:value-of select="text()" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</fo:block>
		<xsl:value-of select="name()"/>
		<xsl:apply-templates></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="koszt_wszystkich_gier">
		<fo:block margin-top="20px" font-size="12px">
			<xsl:text>Calkowita wartość gier: </xsl:text>
			<xsl:value-of select="text()"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="recenzje_gry">
		<fo:block font-size="14px" margin-bottom="10px" margin-top="20px">
			<xsl:text>Recenzje </xsl:text>
			<xsl:value-of select="./parent::gra/tytul"/>
			<xsl:text>:</xsl:text>
		</fo:block>
		<fo:block margin-top="20px" font-size="12px">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	<xsl:template match="recenzja">
		<xsl:text>Gracz:&#x20;</xsl:text>
		<xsl:value-of select="gracz"></xsl:value-of>
		<xsl:text>&#x2028;</xsl:text>
		<xsl:text>Gra:&#x20;</xsl:text>
		<xsl:value-of select="tytul"></xsl:value-of>
		<xsl:text>&#x2028;</xsl:text>
		<xsl:text>Treść:&#x20;</xsl:text>
		<xsl:value-of select="tresc"></xsl:value-of>
		<xsl:text>&#x2028;</xsl:text>
	</xsl:template>
	<xsl:template match="text()"/>
	<xsl:template match="data_utworzenia_raportu"/>
</xsl:stylesheet>   