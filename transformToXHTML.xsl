<?xml version="1.0" encoding="UTF-8"?>
<!--https://cedricvb.be/xml-xslt-to-xhtml-transform/-->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
	<xsl:template match="/">
		<html 
			xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>Computer catalog</title>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
				<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"/>
			</head>
			<body class="bg-light">
				<div class="container bg-dark text-light">
					<div class="navbar navbar-expand-md navbar-dark">
						<div class="collapse navbar-collapse d-flex flex-column justify-content-center" id="navbarTop">
							<h2 class="mb-4">
								<i class="text-warning fas fa-gamepad"/> Raport z grania!														
							</h2>
							<ul class="navbar-nav row">
								<li class="nav-item m-2">
									<a class="btn btn-outline-light" href="#statystyki"> Statystyki</a>
								</li>
								<li class="nav-item m-2">
									<a class="btn btn-outline-light" href="#zestawienie_gier">Zestawienie gier</a>
								</li>
								<li class="nav-item m-2">
									<a class="btn btn-outline-light" href="#autorzy">Autorzy</a>
								</li>
							</ul>
						</div>
					</div>
					<hr class="bg-light"/>
					<a href="#navbarTop" class="text-warning">
						<i class="fas fa-arrow-circle-up"/> na górę!										
					</a>
					<div id="autorzy">
						<div class="row justify-content-center pt-4">
							<h2>Autorzy dokumentu:</h2>
						</div>
						<div class="row justify-content-center">
							<xsl:for-each select="raport/autorzy/autor">
								<div class="card bg-secondary font-weight-bold col-3 d-flex flex-column align-items-center p-2 m-3">
									<xsl:for-each select="*">
										<p>
											<xsl:value-of select="."/>
										</p>
									</xsl:for-each>
								</div>
							</xsl:for-each>
						</div>
					</div>
					<hr class="bg-light"/>
					<a href="#navbarTop" class="text-warning">
						<i class="fas fa-arrow-circle-up"/> na górę!										
					</a>
					<div id="statystyki">
						<div class="row m-4 justify-content-center">
							<h2>Statystyki biblioteki:</h2>
						</div>
						<div class="row">
							<xsl:for-each select="//statystyki/*[starts-with(name(), 'liczba')][position() &lt;= 3]">
								<div class="col-4 text-center font-weight-bold p-3 bg-info">                                    Liczba                                    																		
									<xsl:value-of select="substring-after(name(),'_')"/>                                    :                                    																		
									<xsl:value-of select="."/>
								</div>
							</xsl:for-each>
						</div>
						<div class="row m-4 justify-content-center">
							<h2>Statystyki gier:</h2>
						</div>
						<table class="table table-bordered table-dark  w-50 m-auto">
							<thead>
								<tr>
									<th scope="col">Gatunek</th>
									<th scope="col">Liczba gier</th>
								</tr>
							</thead>
							<tbody>
								<xsl:for-each select="//statystyki/*[starts-with(name(), 'liczba')][position() &gt; 3]">
									<tr>
										<th>
											<xsl:call-template name="substring-after-last">
												<xsl:with-param name="input" select="name()"/>
												<xsl:with-param name="marker" select="'_'"/>
											</xsl:call-template>
										</th>
										<td>
											<xsl:value-of select="."/>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</div>
					<hr class="bg-light"/>
					<a href="#navbarTop" class="text-warning">
						<i class="fas fa-arrow-circle-up"/> na górę!										
					</a>
					<div id="zestawienie_gier">
						<div class="row justify-content-center m-4 pt-4">
							<h2>Zestawienie gier i recenzji:</h2>
						</div>
						<xsl:for-each select="//zestawienie_gier/gra">
							<div class="card m-3 text-dark">
								<h5 class="card-header">
									<xsl:value-of select="tytul"/>
									<span class="badge badge-info ml-2">
										<xsl:value-of select="srednia_ocena_gry"/>
									</span>
								</h5>
								<div class="card-body">
									<xsl:choose>
										<xsl:when test="count(recenzje_gry/recenzja) &gt; 0">
											<h5 class="text-primary">Recenzje gry:</h5>
										</xsl:when>
										<xsl:otherwise>
											<h5 class="text-danger">                                                Brak recenzji.                                            </h5>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:for-each select="recenzje_gry/recenzja">
										<div class="card p-2 m-2">
											<p class="card-title font-weight-bold">
												<i class="fas fa-user-circle"/> Autor:                                                																								
												<xsl:value-of select="gracz"/>
											</p>
											<p class="card-text">
												<xsl:value-of select="tresc"/>
											</p>
										</div>
									</xsl:for-each>
								</div>
							</div>
						</xsl:for-each>
					</div>
					<hr class="bg-light"/>
					<a href="#navbarTop" class="text-warning">
						<i class="fas fa-arrow-circle-up"/> na górę!										
					</a>
					<div class="navbar navbar-expand-lg navbar-dark bg-dark">
						<div class="collapse navbar-collapse d-flex flex-column justify-content-center" id="navbarBottom">
							<ul class="navbar-nav row">
								<li class="nav-item m-2">
									<a class="btn btn-outline-light" href="#statystyki"> Statystyki</a>
								</li>
								<li class="nav-item m-2">
									<a class="btn btn-outline-light" href="#zestawienie_gier">Zestawienie gier</a>
								</li>
								<li class="nav-item m-2">
									<a class="btn btn-outline-light" href="#autorzy">Autorzy</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<div class="bg-secondary d-flex flex-column align-items-center text-white p-4 mt-4">
					<h5>
						<i>Data wygenerowania raportu:</i>
					</h5>
					<i>
						<xsl:value-of select="raport/data_utworzenia_raportu"/>
					</i>
				</div>
			</body>
		</html>
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
</xsl:stylesheet>