<!-- https://xslttest.appspot.com/  online transformation xsl 2.0 -->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xpath-default-namespace="http://www.gamelib.org/types"
>
    <xsl:output method="xml" indent="yes"/>

    <xsl:key name="gra" match="Gra" use="@IdGry"/>
    <xsl:key name="gracz" match="Gracz" use="@IdGracza"/>
    <xsl:key name="recenzja_gra" match="Recenzja" use="@IdGry"/>
    <xsl:key name="recenzja_gracz" match="Recenzja" use="@IdGracza"/>

    <xsl:template match="/BibliotekaGier">
        <raport>
            <xsl:apply-templates/>
            <statystyki>
                <liczba_gier>
                    <xsl:value-of select="count(ListaGier/Gra)"/>
                </liczba_gier>
                <liczba_graczy>
                    <xsl:value-of select="count(Gracze/Gracz)"/>
                </liczba_graczy>
                <liczba_recenzji>
                    <xsl:value-of select="count(Recenzje/Recenzja)"/>
                </liczba_recenzji>
                <liczba_bijatyk>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Bijatyki'])"/>
                </liczba_bijatyk>
                <liczba_gier_akcji>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Akcji'])"/>
                </liczba_gier_akcji>
                <liczba_gier_FPS>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='FPS'])"/>
                </liczba_gier_FPS>
                <liczba_gier_horror>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Horror'])"/>
                </liczba_gier_horror>
                <liczba_gier_survival>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Survival'])"/>
                </liczba_gier_survival>
                <liczba_gier_zrecznosciowe>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Zrecznosciowe'])"/>
                </liczba_gier_zrecznosciowe>
                <liczba_gier_strategiczne>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Strategiczne'])"/>
                </liczba_gier_strategiczne>
                <liczba_gier_RPG>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='RPG'])"/>
                </liczba_gier_RPG>
                <liczba_gier_Przygodowe>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Przygodowe'])"/>
                </liczba_gier_Przygodowe>
                <liczba_gier_Platformowki>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Platformowki'])"/>
                </liczba_gier_Platformowki>
                <liczba_gier_Sportowe>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Sportowe'])"/>
                </liczba_gier_Sportowe>
                <liczba_gier_Wyscigi>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Wyscigi'])"/>
                </liczba_gier_Wyscigi>
                <liczba_gier_Symulacje>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Symulacje'])"/>
                </liczba_gier_Symulacje>
                <liczba_gier_Logiczne>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Logiczne'])"/>
                </liczba_gier_Logiczne>
                <liczba_gier_Wyscigi>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='Wyscigi'])"/>
                </liczba_gier_Wyscigi>
                <liczba_gier_MMO>
                    <xsl:value-of select="count(ListaGier/Gra[@Gatunek='MMO'])"/>
                </liczba_gier_MMO>
                <koszt_wszystkich_gier>
                    <xsl:value-of select="format-number(sum(ListaGier/Gra/Cena), '0.00')"/>
                </koszt_wszystkich_gier>
                <zestawienie_gier>
                    <xsl:for-each select="ListaGier/Gra">
                        <gra>
                            <srednia_ocena_gry>
                                <xsl:variable name="suma_ocen_gry"
                                              select="sum(/BibliotekaGier/Recenzje/Recenzja[@IdGry=current()/@IdGry]/Ocena/@Wartosc)"/>
                                <xsl:variable name="ilosc_ocen_gry"
                                              select="count(/BibliotekaGier/Recenzje/Recenzja[@IdGry=current()/@IdGry])"/>
                                <xsl:variable name="avg"
                                              select="if ($ilosc_ocen_gry = 0) then 0 else ($suma_ocen_gry div $ilosc_ocen_gry)"/>
                                <xsl:value-of
                                        select="format-number($avg, '0.00')"/>
                            </srednia_ocena_gry>
                            <recenzje_gry>
                                <xsl:for-each select="key('recenzja_gra', @IdGry)">
                                    <recenzja>
                                        <gracz>
                                            <xsl:for-each select="key('gracz', @IdGracza)">
                                                <xsl:value-of select="PseudonimGracza"/>
                                            </xsl:for-each>
                                        </gracz>
                                        <xsl:copy-of copy-namespaces="no" select="*"/>
                                    </recenzja>
                                </xsl:for-each>
                            </recenzje_gry>
                        </gra>

                    </xsl:for-each>

                </zestawienie_gier>

            </statystyki>
            <xsl:apply-templates select="recenzje_gry"/>
            <data_utworzenia_raportu>
                <xsl:value-of select="format-dateTime(current-dateTime(),'[D01]/[M01]/[Y0001] [h01]:[m01]')"/>
            </data_utworzenia_raportu>
        </raport>
    </xsl:template>

    <xsl:template match="AutorzyDokumentu">
        <autorzy>
            <xsl:copy-of select="Autor" copy-namespaces="no"/>
        </autorzy>
    </xsl:template>


    <xsl:template match="Recenzje"/>
    <xsl:template match="Gracze"/>
    <xsl:template match="ListaGier"/>
    <xsl:template match="Stopka"/>

</xsl:stylesheet>