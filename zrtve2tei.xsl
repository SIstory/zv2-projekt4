<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Izhodiščni dokument ustvarjen iz združenih datotek v repozitoriju https://dihur.si/ww2/zrtve-2014-10-01.git
    zrtve-2014-09-30-1del-V7.xml
    zrtve-2014-09-30-2del-V7.xml
    zrtve-2014-09-30-3del-V7.xml
    zrtve-2014-09-30-4del-V7.xml
    zrtve-2014-09-30-5del-V7.xml
    -->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="stan-sf">
        <sifra naziv="?">0000</sifra>
        <sifra naziv="samski">0001</sifra>
        <sifra naziv="poročen">0002</sifra>
        <sifra naziv="mladoleten">0003</sifra>
        <sifra naziv="vdovel">0004</sifra>
        <sifra naziv="ločen">0005</sifra>
        <sifra naziv="zaročen">0006</sifra>
    </xsl:variable>
    
    <xsl:variable name="socStatus">
        <xsl:for-each select="document('sifranti-novi-V1/socStatus.xml')//sifra">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="narodnost-sf">
        <xsl:for-each select="document('sifranti-novi-V1/narodnost.xml')//sifra">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="obcina">
        <xsl:for-each select="document('sifranti-novi-V1/obcina.xml')//sifra">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="novaObcina">
        <xsl:for-each select="document('sifranti-novi-V1/novaObcina.xml')//sifra">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="pokrajina">
        <xsl:for-each select="document('sifranti-novi-V1/pokrajina.xml')//sifra">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="vojStatus">
        <xsl:for-each select="document('sifranti-novi-V1/vojStatus.xml')//sifra">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="drzSmrt">
        <xsl:for-each select="document('sifranti-novi-V1/drzSmrt.xml')//sifra">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="vzrokSmrt">
        <xsl:for-each select="document('sifranti-novi-V1/vzrokSmrt.xml')//sifra">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="povzrSmrt">
        <xsl:for-each select="document('sifranti-novi-V1/povzrSmrt.xml')//sifra">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="drzPokop">
        <xsl:for-each select="document('sifranti-novi-V1/drzPokop.xml')//sifra">
            <xsl:copy-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    
    
    <xsl:template match="/">
        <xsl:result-document href="zv2.xml">
            <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:xi="http://www.w3.org/2001/XInclude">
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Pregled mrliških matičnih knjig za ugotovitev števila ter strukture žrtev druge svetovne vojne in neposredno po njej</title>
                            <respStmt>
                                <resp>Zbiranje in urejanje podatkov</resp>
                                <name>Dunja Dobaja</name>
                                <name>Marta Rendla</name>
                                <name>Mojca Šorn</name>
                                <name>Tadeja Tominšek Čehulić</name>
                            </respStmt>
                            <respStmt>
                                <resp>Kodiranje v zapis TEI, urejanje in spletna izdaja</resp>
                                <name>Andrej Pančur</name>
                            </respStmt>
                            <funder>Javna agencija za raziskovalno dejavnost Republike Slovenije (ARRS), Raziskovalna infrastruktura slovenskega zgodovinopisja</funder>
                        </titleStmt>
                        <editionStmt>
                            <edition>1.0</edition>
                        </editionStmt>
                        <publicationStmt>
                            <publisher>Inštitut za novejšo zgodovino</publisher>
                            <availability status="restricted">
                                <p>Dostopno samo za raziskovalne namene.</p>
                            </availability>
                            <date when="2023"/>
                        </publicationStmt>
                        <sourceDesc>
                            <p>Born digital.</p>
                        </sourceDesc>
                    </fileDesc>
                </teiHeader>
                <text>
                    <front>
                        <titlePage>
                            <docTitle>
                                <titlePart>Pregled mrliških matičnih knjig za ugotovitev števila ter strukture žrtev druge svetovne vojne in neposredno po njej</titlePart>
                            </docTitle>
                            <docImprint>
                                <publisher>Inštitut za novejšo zgodovino</publisher>
                                <docDate>2025</docDate>
                            </docImprint>
                        </titlePage>
                        <divGen type="cip" xml:id="cip">
                            <head>Kolofon</head>
                        </divGen>
                        <divGen type="teiHeader" xml:id="teiHeader">
                            <head>Kolofon TEI</head>
                        </divGen>
                        <divGen type="search" xml:id="search">
                            <head>Iskanje</head>
                        </divGen>
                    </front>
                    <body>
                        <xsl:for-each-group select="root/oseba" group-by="concat('../zv2.',(xs:integer(round(number(position())) div 1000) * 1000) + 1,'-',(xs:integer(round(number(position())) div 1000) * 1000) + 1000)">
                            <xsl:variable name="group-number" select="substring-after(current-grouping-key(),'zv2.')"/>
                            <xsl:variable name="group-number_1" select="tokenize($group-number,'-')[1]"/>
                            <xsl:variable name="div-document" select="concat('zv2/',$group-number,'.xml')"/>
                            <xsl:element name="xi:include">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="$div-document"/>
                                </xsl:attribute>
                            </xsl:element>
                            <xsl:result-document href="{$div-document}">
                            <div type="chapter" xml:id="{substring-after(current-grouping-key(),'../')}">
                                <head>Seznam smrtnih žrtev <xsl:value-of select="$group-number"/></head>
                                <listPerson>
                                    <xsl:for-each select="current-group()">
                                        <xsl:variable name="personID" select="concat('zv2.', number(position()) + number($group-number_1) - 1)"/>
                                        <person xml:id="{$personID}">
                                            <xsl:if test="string-length(priimek) != 0 or string-length(ime) != 0 or string-length(poDomace) != 0">
                                                <persName>
                                                    <xsl:if test="string-length(priimek) != 0">
                                                        <xsl:choose>
                                                            <xsl:when test="matches(priimek,'&quot;')">
                                                                <addName type="nickname">
                                                                    <xsl:value-of select="translate(priimek,'&quot;','')"/>
                                                                </addName>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <surname>
                                                                    <xsl:value-of select="priimek"/>
                                                                </surname>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:if>
                                                    <xsl:if test="string-length(ime) != 0">
                                                        <xsl:choose>
                                                            <xsl:when test="matches(ime,'&quot;')">
                                                                <addName type="nickname">
                                                                    <xsl:value-of select="translate(ime,'&quot;','')"/>
                                                                </addName>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <forename>
                                                                    <xsl:value-of select="ime"/>
                                                                </forename>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:if>
                                                    <!-- PODOMACE -->
                                                    <xsl:if test="string-length(poDomace) != 0">
                                                        <addName type="vulgo">
                                                            <xsl:value-of select="translate(poDomace,'&quot;','')"/>
                                                        </addName>
                                                    </xsl:if>
                                                </persName>
                                            </xsl:if>
                                            <xsl:if test="string-length(imeOceta) != 0">
                                                <persName type="father">
                                                    <forename>
                                                        <xsl:value-of select="imeOceta"/>
                                                    </forename>
                                                </persName>
                                            </xsl:if>
                                            <xsl:if test="string-length(imeMati) != 0 or string-length(priimekMati) != 0">
                                                <persName type="mother">
                                                    <xsl:if test="string-length(imeMati) != 0">
                                                        <forename>
                                                            <xsl:value-of select="imeMati"/>
                                                        </forename>
                                                    </xsl:if>
                                                    <xsl:if test="string-length(priimekMati) != 0">
                                                        <surname>
                                                            <xsl:value-of select="priimekMati"/>
                                                        </surname>
                                                    </xsl:if>
                                                </persName>
                                            </xsl:if>
                                            <xsl:if test="(string-length(rojenLeto) != 0 and rojenLeto != 0) or (string-length(rojenMesec) != 0 and rojenMesec != 0) or (string-length(rojenDan) != 0 and rojenDan != 0) or string-length(krajRojstva) != 0">
                                                <xsl:variable name="birth-year">
                                                    <xsl:if test="string-length(rojenLeto) != 0 and rojenLeto != 0">
                                                        <xsl:value-of select="rojenLeto"/>
                                                    </xsl:if>
                                                </xsl:variable>
                                                <xsl:variable name="birth-month">
                                                    <xsl:if test="string-length(rojenMesec) != 0 and rojenMesec != 0">
                                                        <xsl:value-of select="format-number(number(rojenMesec),'00')"/>
                                                    </xsl:if>
                                                </xsl:variable>
                                                <xsl:variable name="birth-day">
                                                    <xsl:if test="string-length(rojenDan) != 0 and rojenDan != 0">
                                                        <xsl:value-of select="format-number(number(rojenDan),'00')"/>
                                                    </xsl:if>
                                                </xsl:variable>
                                                <xsl:variable name="birth-date">
                                                    <xsl:choose>
                                                        <!-- So primeri, ko je samo leto in dan, ni pa meseca, kar naredi napačen zapis datuma YYYY-{2}DD
                                                             V teh primerih zapišem samo letnico in zavržem dan. -->
                                                        <xsl:when test="(string-length($birth-year) gt 0) and (string-length($birth-month) = 0) and (string-length($birth-day) gt 0)">
                                                            <xsl:value-of select="$birth-year"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:choose>
                                                                <xsl:when test="string-length($birth-year) gt 0">
                                                                    <xsl:value-of select="$birth-year"/>
                                                                </xsl:when>
                                                                <xsl:otherwise>-</xsl:otherwise>
                                                            </xsl:choose>
                                                            <xsl:choose>
                                                                <xsl:when test="string-length($birth-month) gt 0">
                                                                    <xsl:text>-</xsl:text>
                                                                    <xsl:value-of select="$birth-month"/>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:if test="string-length($birth-day) gt 0">
                                                                        <xsl:text>-</xsl:text>
                                                                    </xsl:if>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                            <xsl:choose>
                                                                <xsl:when test="string-length($birth-day) gt 0">
                                                                    <xsl:text>-</xsl:text>
                                                                    <xsl:value-of select="$birth-day"/>
                                                                </xsl:when>
                                                            </xsl:choose>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:variable>
                                                <xsl:variable name="birth-date-string">
                                                    <xsl:choose>
                                                        <!-- So primeri, ko je samo leto in dan, ni pa meseca, kar naredi napačen zapis datuma YYYY-{2}DD
                                                             V teh primerih zapišem datum v besedilu, pri katerem je namesto številke meseca zapisan ?? -->
                                                        <xsl:when test="(string-length($birth-year) gt 0) and (string-length($birth-month) = 0) and (string-length($birth-day) gt 0)">
                                                            <xsl:value-of select="$birth-day"/>
                                                            <xsl:text>. ??. </xsl:text>
                                                            <xsl:value-of select="$birth-year"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <!-- pravilno zapisanih datumov ne zapišem še enkrat kot string -->
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:variable>
                                                <birth>
                                                    <xsl:if test="matches($birth-date,'\d')">
                                                        <date>
                                                            <xsl:attribute name="when">
                                                                <xsl:value-of select="$birth-date"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string-length($birth-date-string) gt 0">
                                                                <xsl:value-of select="$birth-date-string"/>
                                                            </xsl:if>
                                                        </date>
                                                    </xsl:if>
                                                    <xsl:if test="string-length(krajRojstva) != 0">
                                                        <settlement>
                                                            <xsl:value-of select="krajRojstva"/>
                                                        </settlement>
                                                    </xsl:if>
                                                </birth>
                                            </xsl:if>
                                            <xsl:if test="spol = 'M' or spol = 'Ž'">
                                                <sex value="{ if (spol = 'M') then 'M' else 'F'}"/>
                                            </xsl:if>
                                            <!-- SFSTAN -->
                                            <xsl:if test="number(stan) gt 0">
                                                <xsl:variable name="stan-id" select="stan"/>
                                                <!-- ali bi raje dal state[@type='maritalStatus']? -->
                                                <state type="maritalStatus">
                                                    <desc>
                                                        <xsl:value-of select="$stan-sf/sifra[. = $stan-id]/@naziv"/>
                                                    </desc>
                                                </state>
                                            </xsl:if>
                                            <!-- SFSOCSTATUS -->
                                            <xsl:if test="number(SFsocStatus) gt 0">
                                                <xsl:variable name="socStatus-id" select="SFsocStatus"/>
                                                <occupation>
                                                    <xsl:value-of select="$socStatus/sifra[. = $socStatus-id]/@naziv"/>
                                                </occupation>
                                            </xsl:if>
                                            <!-- SFNARODNOST -->
                                            <xsl:if test="number(narodnost) gt 0">
                                                <xsl:variable name="narodnost-id" select="narodnost"/>
                                                <nationality>
                                                    <xsl:value-of select="$narodnost-sf/sifra[. = $narodnost-id]/@naziv"/>
                                                </nationality>
                                            </xsl:if>
                                            <!-- podatki o naslavu/izvoru -->
                                            <xsl:if test="(string-length(naslov) != 0) or (number(SFobcina) gt 0) or (number(SFnovaObcina) gt 0) or (number(SFpokrajina) gt 0)">
                                                <residence>
                                                    <!-- NASLOV -->
                                                    <xsl:if test="string-length(naslov) != 0">
                                                        <settlement>
                                                            <xsl:value-of select="naslov"/>
                                                        </settlement>
                                                    </xsl:if>
                                                    <!-- SFOBCINA -->
                                                    <xsl:if test="number(SFobcina) gt 0">
                                                        <xsl:variable name="obcina-id" select="SFobcina"/>
                                                        <region type="municipality">
                                                            <xsl:value-of select="$obcina/sifra[. = $obcina-id]/@naziv"/>
                                                        </region>
                                                    </xsl:if>
                                                    <!-- SFNOVAOBCINA -->
                                                    <xsl:if test="number(SFnovaObcina) gt 0">
                                                        <xsl:variable name="novaObcina-id" select="SFnovaObcina"/>
                                                        <region type="municipality" notBefore="1998">
                                                            <xsl:value-of select="$novaObcina/sifra[. = $novaObcina-id]/@naziv"/>
                                                        </region>
                                                    </xsl:if>
                                                    <!-- SFPOKRAJINA -->
                                                    <xsl:if test="number(SFpokrajina) gt 0">
                                                        <xsl:variable name="pokrajina-id" select="SFpokrajina"/>
                                                        <region type="province">
                                                            <xsl:value-of select="$pokrajina/sifra[. = $pokrajina-id]/@naziv"/>
                                                        </region>
                                                    </xsl:if>
                                                </residence>
                                            </xsl:if>
                                            <!-- SFVOJSTATUS -->
                                            <xsl:if test="number(SFvojStatus) gt 0">
                                                <xsl:variable name="vojStatus-id" select="SFvojStatus"/>
                                                <socecStatus>
                                                    <xsl:value-of select="$vojStatus/sifra[. = $vojStatus-id]/@naziv"/>
                                                </socecStatus>
                                            </xsl:if>
                                            <!-- VOJENOTA -->
                                            <xsl:if test=" string-length(vojEnota) != 0">
                                                <affiliation type="military">
                                                    <xsl:value-of select="vojEnota"/>
                                                </affiliation>
                                            </xsl:if>
                                            <!-- podatki o smrti -->
                                            <xsl:if test="(string-length(smrtLeto) != 0 and smrtLeto != 0) or (string-length(smrtMesec) != 0 and smrtMesec != 0) or (string-length(smrtDan) != 0 and smrtDan != 0) or (string-length(krajSmrt) != 0) or (number(SFdrzSmrt) gt 0) or (number(SFvzrokSmrt) gt 0) or (number(SFpovzrSmrt) gt 0)">
                                                <xsl:variable name="death-year">
                                                    <xsl:if test="string-length(smrtLeto) != 0 and smrtLeto != 0">
                                                        <xsl:value-of select="smrtLeto"/>
                                                    </xsl:if>
                                                </xsl:variable>
                                                <xsl:variable name="death-month">
                                                    <xsl:if test="string-length(smrtMesec) != 0 and smrtMesec != 0">
                                                        <xsl:value-of select="format-number(number(smrtMesec),'00')"/>
                                                    </xsl:if>
                                                </xsl:variable>
                                                <xsl:variable name="death-day">
                                                    <xsl:if test="string-length(smrtDan) != 0 and smrtDan != 0">
                                                        <xsl:value-of select="format-number(number(smrtDan),'00')"/>
                                                    </xsl:if>
                                                </xsl:variable>
                                                <xsl:variable name="death-date">
                                                    <xsl:choose>
                                                        <!-- So primeri, ko je samo leto in dan, ni pa meseca, kar naredi napačen zapis datuma YYYY-{2}DD
                                                             V teh primerih zapišem samo letnico in zavržem dan. -->
                                                        <xsl:when test="(string-length($death-year) gt 0) and (string-length($death-month) = 0) and (string-length($death-day) gt 0)">
                                                            <xsl:value-of select="$death-year"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:choose>
                                                                <xsl:when test="string-length($death-year) gt 0">
                                                                    <xsl:value-of select="$death-year"/>
                                                                </xsl:when>
                                                                <xsl:otherwise>-</xsl:otherwise>
                                                            </xsl:choose>
                                                            <xsl:choose>
                                                                <xsl:when test="string-length($death-month) gt 0">
                                                                    <xsl:text>-</xsl:text>
                                                                    <xsl:value-of select="$death-month"/>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:if test="string-length($death-day) gt 0">
                                                                        <xsl:text>-</xsl:text>
                                                                    </xsl:if>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                            <xsl:choose>
                                                                <xsl:when test="string-length($death-day) gt 0">
                                                                    <xsl:text>-</xsl:text>
                                                                    <xsl:value-of select="$death-day"/>
                                                                </xsl:when>
                                                            </xsl:choose>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:variable>
                                                <xsl:variable name="death-date-string">
                                                    <xsl:choose>
                                                        <!-- So primeri, ko je samo leto in dan, ni pa meseca, kar naredi napačen zapis datuma YYYY-{2}DD
                                                             V teh primerih zapišem datum v besedilu, pri katerem je namesto številke meseca zapisan ?? -->
                                                        <xsl:when test="(string-length($death-year) gt 0) and (string-length($death-month) = 0) and (string-length($death-day) gt 0)">
                                                            <xsl:value-of select="$death-day"/>
                                                            <xsl:text>. ??. </xsl:text>
                                                            <xsl:value-of select="$death-year"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <!-- pravilno zapisanih datumov ne zapišem še enkrat kot string -->
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:variable>
                                                <death>
                                                    <xsl:if test="matches($death-date,'\d')">
                                                        <date>
                                                            <xsl:attribute name="when">
                                                                <xsl:value-of select="$death-date"/>
                                                            </xsl:attribute>
                                                            <xsl:if test="string-length($death-date-string) gt 0">
                                                                <xsl:value-of select="$death-date-string"/>
                                                            </xsl:if>
                                                        </date>
                                                    </xsl:if>
                                                    <!-- KRAJSMRT -->
                                                    <xsl:if test="string-length(krajSmrt) != 0">
                                                        <settlement>
                                                            <xsl:value-of select="krajSmrt"/>
                                                        </settlement>
                                                    </xsl:if>
                                                    <!-- SFDRZSMRT -->
                                                    <xsl:if test="number(SFdrzSmrt) gt 0">
                                                        <xsl:variable name="drzSmrt-id" select="SFdrzSmrt"/>
                                                        <country>
                                                            <xsl:value-of select="$drzSmrt/sifra[. = $drzSmrt-id]/@naziv"/>
                                                        </country>
                                                    </xsl:if>
                                                    <!-- SFVZROKSMRT -->
                                                    <xsl:if test="number(SFvzrokSmrt) gt 0">
                                                        <xsl:variable name="vzrokSmrt-id" select="SFvzrokSmrt"/>
                                                        <note type="cause">
                                                            <xsl:value-of select="$vzrokSmrt/sifra[. = $vzrokSmrt-id]/@naziv"/>
                                                        </note>
                                                    </xsl:if>
                                                    <!-- SFPOVZRSMRT -->
                                                    <xsl:if test="number(SFpovzrSmrt) gt 0">
                                                        <xsl:variable name="povzrSmrt-id" select="SFpovzrSmrt"/>
                                                        <note type="by">
                                                            <orgName>
                                                                <xsl:value-of select="$povzrSmrt/sifra[. = $povzrSmrt-id]/@naziv"/>
                                                            </orgName>
                                                        </note>
                                                    </xsl:if>
                                                </death>
                                            </xsl:if>
                                            <!-- podatki o pokopu -->
                                            <xsl:if test="(string-length(krajPokop) != 0) or (number(SFdrzPokop) gt 0)">
                                                <event type="burial">
                                                    <desc>
                                                        <location>
                                                            <xsl:if test="string-length(krajPokop) != 0">
                                                                <settlement>
                                                                    <xsl:value-of select="krajPokop"/>
                                                                </settlement>
                                                            </xsl:if>
                                                            <xsl:if test="number(SFdrzPokop) gt 0">
                                                                <xsl:variable name="drzPokop-id" select="SFdrzPokop"/>
                                                                <country>
                                                                    <xsl:value-of select="$drzPokop/sifra[. = $drzPokop-id]/@naziv"/>
                                                                </country>
                                                            </xsl:if>
                                                        </location>
                                                    </desc>
                                                </event>
                                            </xsl:if>
                                            <xsl:if test="string-length(starostSmrt) != 0 and starostSmrt != 0">
                                                <age>
                                                    <xsl:value-of select="starostSmrt"/>
                                                </age>
                                            </xsl:if>
                                            <xsl:if test="viri/li">
                                                <listBibl>
                                                    <xsl:for-each select="viri/li">
                                                        <xsl:variable name="string-bibl" select="."/>
                                                        <xsl:variable name="bibl-text" select="normalize-space($string-bibl)"/>
                                                        <xsl:if test="string-length($bibl-text) gt 0">
                                                            <bibl>
                                                                <xsl:value-of select="$bibl-text"/>
                                                            </bibl>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                </listBibl>
                                            </xsl:if>
                                            <xsl:if test="opombe/li">
                                                <xsl:for-each select="opombe/li">
                                                    <xsl:variable name="string-note" select="."/>
                                                    <xsl:variable name="note-text" select="normalize-space($string-note)"/>
                                                    <xsl:if test="string-length($note-text) gt 0">
                                                        <note>
                                                            <xsl:value-of select="$note-text"/>
                                                        </note>
                                                    </xsl:if>
                                                </xsl:for-each>
                                            </xsl:if>
                                            <note type="record">
                                                <xsl:variable name="record-day" select="tokenize(DATUMSP,'\.')[1]"/>
                                                <xsl:variable name="record-day-format" select="format-number(number($record-day),'00')"/>
                                                <xsl:variable name="record-month" select="tokenize(DATUMSP,'\.')[2]"/>
                                                <xsl:variable name="record-month-format" select="format-number(number($record-month),'00')"/>
                                                <xsl:variable name="record-year" select="tokenize(DATUMSP,'\.')[3]"/>
                                                <name>
                                                    <xsl:value-of select="referent"/>
                                                </name>
                                                <xsl:if test="string-length(DATUMSP) gt 0">
                                                    <date>
                                                        <xsl:attribute name="when">
                                                            <xsl:value-of select="concat($record-year,'-',$record-month-format,'-',$record-day-format)"/>
                                                        </xsl:attribute>
                                                    </date>
                                                </xsl:if>
                                            </note>
                                            <!-- preverjen v matični knjigi: vrednosti False ali True -->
                                            <note type="verified">
                                                <xsl:value-of select="MRL"/>
                                            </note>
                                        </person>
                                    </xsl:for-each>
                                </listPerson>
                            </div>
                            </xsl:result-document>
                        </xsl:for-each-group>
                    </body>
                    <back>
                        <divGen type="index" xml:id="main">
                            <head>Osnovni podatki</head>
                        </divGen>
                        <divGen type="index" xml:id="personal">
                            <head>Osebni podatki</head>
                        </divGen>
                        <divGen type="index" xml:id="residence">
                            <head>Izvor</head>
                        </divGen>
                        <divGen type="index" xml:id="affiliation">
                            <head>Pripadnost</head>
                        </divGen>
                        <divGen type="index" xml:id="death">
                            <head>Smrt</head>
                        </divGen>
                        <divGen type="index" xml:id="cause">
                            <head>Vzrok</head>
                        </divGen>
                        <divGen type="index" xml:id="burial">
                            <head>Pokop</head>
                        </divGen>
                        <divGen type="index" xml:id="all">
                            <head>Vsi podatki</head>
                        </divGen>
                    </back>
                </text>
            </TEI>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>