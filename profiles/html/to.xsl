<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs"
   version="2.0">

   <xsl:import href="../../../../pub-XSLT/Stylesheets/html5-foundation6-chs/to.xsl"/>
   
   <xsl:param name="localWebsite">false</xsl:param>
   
   <xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>
   
   <xsl:param name="outputDir">docs/</xsl:param>
   
   <xsl:param name="homeLabel">SIstory</xsl:param>
   <xsl:param name="homeURL">https://github.com/sistory/zv2-projekt4</xsl:param>
   
   <xsl:param name="title-bar-sticky">false</xsl:param>
   
   <xsl:param name="chapterAsSIstoryPublications">false</xsl:param>
   
   <!-- odstranim pri spodnjih param true -->
   <xsl:param name="numberFigures"></xsl:param>
   <xsl:param name="numberFrontTables"></xsl:param>
   <xsl:param name="numberHeadings"></xsl:param>
   <xsl:param name="numberParagraphs"></xsl:param>
   <xsl:param name="numberTables"></xsl:param>
   
   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description">Pregled mrliških matičnih knjig za ugotovitev števila ter strukture žrtev druge svetovne vojne in neposredno po njej. Zaključno poročilo projekta iz leta 2012 skupaj z objavljenimi raziskovalnimi podatki.</xsl:param>
   <xsl:param name="keywords">žrtve, druga svetovna vojna, Slovenija, nasilje, revolucija</xsl:param>
   <xsl:param name="title">Pregled mrliških matičnih knjig za ugotovitev števila ter strukture žrtev druge svetovne vojne in neposredno po njej</xsl:param>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za glavno vsebino (glavna navigacija)</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="nav-body-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Podatki</xsl:text>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za izpis spremnih študij, glede na število back/div</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="nav-study-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Poročilo</xsl:text>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="divGen-main-content">
      <xsl:param name="thisLanguage"/>
      <!-- kolofon CIP -->
      <xsl:if test="self::tei:divGen[@type='cip']">
         <xsl:apply-templates select="ancestor::tei:TEI/tei:teiHeader/tei:fileDesc" mode="kolofon"/>
      </xsl:if>
      <!-- TEI kolofon -->
      <xsl:if test="self::tei:divGen[@type='teiHeader']">
         <xsl:apply-templates select="ancestor::tei:TEI/tei:teiHeader"/>
      </xsl:if>
      <!-- kazalo vsebine toc -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='toc'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='toc']">
         <xsl:call-template name="mainTOC"/>
      </xsl:if>
      <!-- kazalo slik -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='images'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='images']">
         <xsl:call-template name="images"/>
      </xsl:if>
      <!-- kazalo grafikonov -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='charts'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='charts']">
         <xsl:call-template name="charts"/>
      </xsl:if>
      
      <!-- kazalo tabel -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='tables'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='tables']">
         <xsl:call-template name="tables"/>
      </xsl:if>
      <!-- kazalo vsebine toc, ki izpiše samo glavne naslove poglavij, skupaj z imeni avtorjev poglavij -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='titleAuthor'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='titleAuthor']">
         <xsl:call-template name="TOC-title-author"/>
      </xsl:if>
      <!-- kazalo vsebine toc, ki izpiše samo naslove poglavij, kjer ima div atributa type in xml:id -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='titleType'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='titleType']">
         <xsl:call-template name="TOC-title-type"/>
      </xsl:if>
      <!-- seznam (indeks) oseb -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='persons'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='persons']">
         <xsl:call-template name="persons"/>
      </xsl:if>
      <!-- seznam (indeks) krajev -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='places'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='places']">
         <xsl:call-template name="places"/>
      </xsl:if>
      <!-- seznam (indeks) organizacij -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='organizations'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='organizations']">
         <xsl:call-template name="organizations"/>
      </xsl:if>
      <!-- iskalnik -->
      <xsl:if test="self::tei:divGen[@type='search']">
         <xsl:call-template name="search"/>
      </xsl:if>
      <!-- DODAL SPODNJO SAMO ZA TO PRETVORBO! -->
      <!-- za generiranje datateble -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='main']">
         <xsl:call-template name="datatables-main"/>
      </xsl:if>
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='personal']">
         <xsl:call-template name="datatables-personal"/>
      </xsl:if>
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='residence']">
         <xsl:call-template name="datatables-residence"/>
      </xsl:if>
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='affiliation']">
         <xsl:call-template name="datatables-affiliation"/>
      </xsl:if>
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='death']">
         <xsl:call-template name="datatables-death"/>
      </xsl:if>
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='cause']">
         <xsl:call-template name="datatables-cause"/>
      </xsl:if>
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='burial']">
         <xsl:call-template name="datatables-burial"/>
      </xsl:if>
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='all']">
         <xsl:call-template name="datatables-all"/>
      </xsl:if>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-main">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-main.js' else 'range-filter-external-main.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [];
      </script>
      
      <ul class="accordion" data-accordion="" data-allow-all-closed="true">
         <li class="accordion-item" data-accordion-item="">
            <a href="#" class="accordion-title">Filtriraj po datumu rojstva</a>
            <div class="accordion-content rangeFilterWrapper" data-target="3" data-tab-content="">
               <div class="row">
                  <div class="small-3 columns">
                     <label for="middle-label" class="text-right middle">Filtriraj od datuma rojstva</label>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMinDay" maxlength="2" placeholder="Dan"/>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMinMonth" maxlength="2" placeholder="Mesec"/>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMinYear" maxlength="4" placeholder="Leto"/>
                  </div>
               </div>
               <div class="row">
                  <div class="small-3 columns">
                     <label for="middle-label" class="text-right middle">do datuma rojstva</label>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMaxDay" maxlength="2" placeholder="Dan"/>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMaxMonth" maxlength="2" placeholder="Mesec"/>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMaxYear" maxlength="4" placeholder="Leto"/>
                  </div>
                  <div class="small-12 columns" style="text-align: right;">
                     <a class="clearRangeFilter" href="#">Počisti filter</a>
                  </div>
               </div>
            </div>
         </li>
         <li class="accordion-item" data-accordion-item="">
            <a href="#" class="accordion-title">Filtriraj po datumu smrti</a>
            <div class="accordion-content rangeFilterWrapper" data-target="4" data-tab-content="">
               <div class="row">
                  <div class="small-3 columns">
                     <label for="middle-label" class="text-right middle">Filtriraj od datuma smrti</label>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMinDay" maxlength="2" placeholder="Dan"/>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMinMonth" maxlength="2" placeholder="Mesec"/>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMinYear" maxlength="4" placeholder="Leto"/>
                  </div>
               </div>
               <div class="row">
                  <div class="small-3 columns">
                     <label for="middle-label" class="text-right middle">do datuma smrti</label>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMaxDay" maxlength="2" placeholder="Dan"/>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMaxMonth" maxlength="2" placeholder="Mesec"/>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMaxYear" maxlength="4" placeholder="Leto"/>
                  </div>
                  <div class="small-12 columns" style="text-align: right;">
                     <a class="clearRangeFilter" href="#">Počisti filter</a>
                  </div>
               </div>
            </div>
         </li>
      </ul>
      
      <div class="table-scroll">
         <table id="datatableMain" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Priimek</th>
                  <th>Ime</th>
                  <th>Rojstvo</th>
                  <th>Smrt</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="{$outputDir}data-main.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:person[parent::tei:listPerson]">
                  <xsl:variable name="personID" select="@xml:id"/>
                  <xsl:variable name="personID-number" select="substring-after($personID,'zv2.')"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <xsl:call-template name="victims-core_data">
                     <xsl:with-param name="personID" select="$personID"/>
                     <xsl:with-param name="personID-number" select="$personID-number"/>
                  </xsl:call-template>
                  
                  <!-- Rojstvo -->
                  <xsl:value-of select="concat('&quot;',tei:birth/tei:date/@when,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Smrt -->
                  <xsl:value-of select="concat('&quot;',tei:death/tei:date/@when,'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-personal">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-personal.js' else 'range-filter-external-personal.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [5, 6, 8];
      </script>
      
      <div class="table-scroll">
         <table id="datatablePersonal" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Priimek</th>
                  <th>Ime</th>
                  <th>Rojstvo</th>
                  <th>Kraj roj.</th>
                  <th>Spol</th>
                  <th>Stan</th>
                  <th>Poklic</th>
                  <th>Narodnost</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="{$outputDir}data-personal.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:person[parent::tei:listPerson]">
                  <xsl:variable name="personID" select="@xml:id"/>
                  <xsl:variable name="personID-number" select="substring-after($personID,'zv2.')"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <xsl:call-template name="victims-core_data">
                     <xsl:with-param name="personID" select="$personID"/>
                     <xsl:with-param name="personID-number" select="$personID-number"/>
                  </xsl:call-template>
                  
                  <!-- Rojstvo -->
                  <xsl:value-of select="concat('&quot;',tei:birth/tei:date/@when,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                 
                  <!-- Kraj rojstva -->
                  <xsl:value-of select="concat('&quot;', translate(tei:birth/tei:settlement,'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Spol -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:choose>
                     <xsl:when test="tei:sex[@value = 'M']">moški</xsl:when>
                     <xsl:otherwise>ženska</xsl:otherwise>
                  </xsl:choose>
                  <xsl:text>&quot;</xsl:text>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Stan -->
                  <xsl:value-of select="concat('&quot;',tei:state[@type='maritalStatus']/tei:desc,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Poklic -->
                  <xsl:value-of select="concat('&quot;',tei:occupation,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Narodnost -->
                  <xsl:value-of select="concat('&quot;',tei:nationality,'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
               
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-residence">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-residence.js' else 'range-filter-external-residence.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [4, 5, 6];
      </script>
      
      <div class="table-scroll">
         <table id="datatableResidence" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Priimek</th>
                  <th>Ime</th>
                  <th>Naslov</th>
                  <th>Občina</th>
                  <th>Nova občina</th>
                  <th>Pokrajina</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="{$outputDir}data-residence.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:person[parent::tei:listPerson]">
                  <xsl:variable name="personID" select="@xml:id"/>
                  <xsl:variable name="personID-number" select="substring-after($personID,'zv2.')"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <xsl:call-template name="victims-core_data">
                     <xsl:with-param name="personID" select="$personID"/>
                     <xsl:with-param name="personID-number" select="$personID-number"/>
                  </xsl:call-template>
                  
                  <!-- Naslov -->
                  <xsl:value-of select="concat('&quot;',translate(tei:residence/tei:settlement,'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Občina -->
                  <xsl:value-of select="concat('&quot;',translate(tei:residence/tei:region[@type='municipality'][not(@notBefore)],'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Nova občina -->
                  <xsl:value-of select="concat('&quot;',translate(tei:residence/tei:region[@type='municipality'][@notBefore],'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Pokrajina -->
                  <xsl:value-of select="concat('&quot;',translate(tei:residence/tei:region[@type='province'],'&quot;',''),'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-affiliation">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-affiliation.js' else 'range-filter-external-affiliation.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [3];
      </script>
      
      <div class="table-scroll">
         <table id="datatableAffiliation" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Priimek</th>
                  <th>Ime</th>
                  <th>Vojaški status</th>
                  <th>Vojaška enota</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="{$outputDir}data-affiliation.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:person[parent::tei:listPerson]">
                  <xsl:variable name="personID" select="@xml:id"/>
                  <xsl:variable name="personID-number" select="substring-after($personID,'zv2.')"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <xsl:call-template name="victims-core_data">
                     <xsl:with-param name="personID" select="$personID"/>
                     <xsl:with-param name="personID-number" select="$personID-number"/>
                  </xsl:call-template>
                  
                  <!-- Vojaški status -->
                  <xsl:value-of select="concat('&quot;',translate(tei:socecStatus,'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Vojaška enota -->
                  <xsl:value-of select="concat('&quot;',translate(tei:affiliation,'&quot;',''),'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-death">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-death.js' else 'range-filter-external-death.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [5];
      </script>
      
      <div class="table-scroll">
         <table id="datatableDeath" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Priimek</th>
                  <th>Ime</th>
                  <th>Smrt</th>
                  <th>Kraj</th>
                  <th>Država</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="{$outputDir}data-death.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:person[parent::tei:listPerson]">
                  <xsl:variable name="personID" select="@xml:id"/>
                  <xsl:variable name="personID-number" select="substring-after($personID,'zv2.')"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <xsl:call-template name="victims-core_data">
                     <xsl:with-param name="personID" select="$personID"/>
                     <xsl:with-param name="personID-number" select="$personID-number"/>
                  </xsl:call-template>
                  
                  <!-- Smrt -->
                  <xsl:value-of select="concat('&quot;',tei:death/tei:date/@when,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Kraj smrti -->
                  <xsl:value-of select="concat('&quot;', translate(tei:death/tei:settlement,'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Država smrti -->
                  <xsl:value-of select="concat('&quot;',tei:death/tei:country,'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-cause">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-cause.js' else 'range-filter-external-cause.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [3, 4];
      </script>
      
      <div class="table-scroll">
         <table id="datatableCause" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Priimek</th>
                  <th>Ime</th>
                  <th>Vzrok smrti</th>
                  <th>Povzročitelj</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="{$outputDir}data-cause.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:person[parent::tei:listPerson]">
                  <xsl:variable name="personID" select="@xml:id"/>
                  <xsl:variable name="personID-number" select="substring-after($personID,'zv2.')"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <xsl:call-template name="victims-core_data">
                     <xsl:with-param name="personID" select="$personID"/>
                     <xsl:with-param name="personID-number" select="$personID-number"/>
                  </xsl:call-template>
                  
                  <!-- Vzrok smrti -->
                  <xsl:value-of select="concat('&quot;',tei:death/tei:note[@type='cause'],'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Povzročitelj smrti -->
                  <xsl:value-of select="concat('&quot;',tei:death/tei:note[@type='by']/tei:orgName,'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-burial">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-burial.js' else 'range-filter-external-burial.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [3];
      </script>
      
      <div class="table-scroll">
         <table id="datatableBurial" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Priimek</th>
                  <th>Ime</th>
                  <th>Država</th>
                  <th>Kraj</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="{$outputDir}data-burial.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:person[parent::tei:listPerson]">
                  <xsl:variable name="personID" select="@xml:id"/>
                  <xsl:variable name="personID-number" select="substring-after($personID,'zv2.')"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <xsl:call-template name="victims-core_data">
                     <xsl:with-param name="personID" select="$personID"/>
                     <xsl:with-param name="personID-number" select="$personID-number"/>
                  </xsl:call-template>
                  
                  <!-- Država pokopa -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="translate(tei:event[@type='burial']/tei:desc/tei:location/tei:country,'&quot;','')"/>
                  <xsl:text>&quot;,&#xA;</xsl:text>
                  
                  <!-- Kraj Pokop -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="translate(concat('&quot;',tei:event[@type='burial']/tei:desc/tei:location/tei:settlement,'&quot;'),'&quot;','')"/>
                  <xsl:text>&quot;</xsl:text>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-all">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <!--<script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>-->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-all.js' else 'range-filter-external-all.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [];
      </script>
      
      <div>
         <table id="datatableAll" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Priimek</th>
                  <th>Ime</th>
                  <th>Rojstvo</th>
                  <th>Kraj roj.</th>
                  <th>Spol</th>
                  <th>Stan</th>
                  <th>Poklic</th>
                  <th>Narodnost</th>
                  <th>Naslov</th>
                  <th>Občina</th>
                  <th>Nova občina</th>
                  <th>Pokrajina</th>
                  <th>Vojaški status</th>
                  <th>Vojaška enota</th>
                  <th>Smrt</th>
                  <th>Kraj smrti</th>
                  <th>Država smrti</th>
                  <th>Vzrok smrti</th>
                  <th>Povzročitelj</th>
                  <th>Država pokopa</th>
                  <th>Kraj pokopa</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="{$outputDir}data-all.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:person[parent::tei:listPerson]">
                  <xsl:variable name="personID" select="@xml:id"/>
                  <xsl:variable name="personID-number" select="substring-after($personID,'zv2.')"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <xsl:call-template name="victims-core_data">
                     <xsl:with-param name="personID" select="$personID"/>
                     <xsl:with-param name="personID-number" select="$personID-number"/>
                  </xsl:call-template>
                  
                  <!-- Rojstvo -->
                  <xsl:value-of select="concat('&quot;',tei:birth/tei:date/@when,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Kraj rojstva -->
                  <xsl:value-of select="concat('&quot;', translate(tei:birth/tei:settlement,'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Spol -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:choose>
                     <xsl:when test="tei:sex[@value = 'M']">moški</xsl:when>
                     <xsl:otherwise>ženska</xsl:otherwise>
                  </xsl:choose>
                  <xsl:text>&quot;</xsl:text>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Stan -->
                  <xsl:value-of select="concat('&quot;',tei:state[@type='maritalStatus']/tei:desc,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Poklic -->
                  <xsl:value-of select="concat('&quot;',tei:occupation,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Narodnost -->
                  <xsl:value-of select="concat('&quot;',tei:nationality,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Naslov -->
                  <xsl:value-of select="concat('&quot;',translate(tei:residence/tei:settlement,'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Občina -->
                  <xsl:value-of select="concat('&quot;',translate(tei:residence/tei:region[@type='municipality'][not(@notBefore)],'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Nova občina -->
                  <xsl:value-of select="concat('&quot;',translate(tei:residence/tei:region[@type='municipality'][@notBefore],'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Pokrajina -->
                  <xsl:value-of select="concat('&quot;',translate(tei:residence/tei:region[@type='province'],'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Vojaški status -->
                  <xsl:value-of select="concat('&quot;',translate(tei:socecStatus,'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Vojaška enota -->
                  <xsl:value-of select="concat('&quot;',translate(tei:affiliation,'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Smrt -->
                  <xsl:value-of select="concat('&quot;',tei:death/tei:date/@when,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Kraj smrti -->
                  <xsl:value-of select="concat('&quot;', translate(tei:death/tei:settlement,'&quot;',''),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Država smrti -->
                  <xsl:value-of select="concat('&quot;',tei:death/tei:country,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Vzrok smrti -->
                  <xsl:value-of select="concat('&quot;',tei:death/tei:note[@type='cause'],'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Povzročitelj smrti -->
                  <xsl:value-of select="concat('&quot;',tei:death/tei:note[@type='by']/tei:orgName,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Država pokopa -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="translate(tei:event[@type='burial']/tei:desc/tei:location/tei:country,'&quot;','')"/>
                  <xsl:text>&quot;,&#xA;</xsl:text>
                  
                  <!-- Kraj Pokop -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="translate(concat('&quot;',tei:event[@type='burial']/tei:desc/tei:location/tei:settlement,'&quot;'),'&quot;','')"/>
                  <xsl:text>&quot;</xsl:text>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
      <param name="personID"></param>
      <param name="personID-number"></param>
   </doc>
   <xsl:template name="victims-core_data">
      <xsl:param name="personID"/>
      <xsl:param name="personID-number"/>
      <!-- ID -->
      <xsl:text>&quot;</xsl:text>
      <xsl:value-of select="concat('&lt;a href=\&quot;',ancestor::tei:div[@type='chapter']/@xml:id,'.html#',$personID,'\&quot; target=\&quot;_blank\&quot;&gt;',$personID-number,'&lt;/a&gt;')"/>
      <xsl:text>&quot;,&#xA;</xsl:text>
      
      <!-- Priimek -->
      <xsl:text>&quot;</xsl:text>
      <xsl:value-of select="tei:persName[not(@type)]/tei:surname"/>
      <xsl:text>&quot;,&#xA;</xsl:text>
      
      <!-- Ime -->
      <xsl:text>&quot;</xsl:text>
      <xsl:value-of select="tei:persName[not(@type)]/tei:forename | tei:persName[not(@type)]/tei:addName"/>
      <xsl:text>&quot;,&#xA;</xsl:text>
      
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Sezname oseb procesiram na nov način</desc>
   </doc>
   <xsl:template match="tei:listPerson">
      <xsl:apply-templates/>
   </xsl:template>
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:person">
      <dl id="{@xml:id}">
         <dt>
            <xsl:choose>
               <xsl:when test="$element-gloss-teiHeader = 'true'">
                  <xsl:call-template name="node-gloss"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="name()"/>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="@*">
               <xsl:call-template name="teiHeader-dl-atributes"/>
            </xsl:if>
         </dt>
         <dd>
            <xsl:call-template name="teiHeader-dl"/>
         </dd>
      </dl>
      <p>
         <a href="{concat('person/',@xml:id,'.html')}" target="_blank" class="button">Izpis podatkov</a>
      </p>
      <xsl:call-template name="person-page"/>
      <br/>
      <xsl:if test="position() != last()">
         <hr/>
      </xsl:if>
      <br/>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>dopolnim iskalnik, tako da procesira tudi //tei:div[@type='chapter']/tei:listPerson/tei:person kot samostojne enote</desc>
   </doc>
   <xsl:template name="search">
      <xsl:variable name="tei-id" select="ancestor::tei:TEI/@xml:id"/>
      <xsl:variable name="sistoryAbsolutePath">
         <xsl:if test="$chapterAsSIstoryPublications='true'">http://www.sistory.si</xsl:if>
      </xsl:variable>
      <div id="tipue_search_content">
         <xsl:text></xsl:text>
         <xsl:variable name="datoteka-js" select="concat($outputDir,ancestor::tei:TEI/@xml:id,'/','tipuesearch_content.js')"/>
         <xsl:result-document href="{$datoteka-js}" method="text" encoding="UTF-8">
            <!-- ZAČETEK JavaScript dokumenta -->
            <xsl:text>var tipuesearch = {"pages": [
                                    </xsl:text>
            
            <!-- procesira samo tei:div[@type='chapter']/tei:listPerson -->
            <xsl:for-each select="//tei:div[@type='chapter']/tei:listPerson/tei:person">
               <xsl:variable name="generatedLink">
                  <xsl:apply-templates mode="generateLink" select="."/>
               </xsl:variable>
               <xsl:variable name="oseba-naziv">
                  <xsl:call-template name="oseba-naziv"/>
               </xsl:variable>
               <xsl:variable name="besedilo">
                  <xsl:apply-templates mode="besedilo"/>
               </xsl:variable>
               <xsl:text>{ "title": "</xsl:text>
               <xsl:value-of select="normalize-space(translate(translate($oseba-naziv,'&#xA;',' '),'&quot;',''))"/>
               <xsl:text>", "text": "</xsl:text>
               <xsl:value-of select="normalize-space(translate($besedilo,'&#xA;&quot;','&#x20;'))"/>
               <xsl:text>", "tags": "</xsl:text>
               <xsl:text>", "url": "</xsl:text>
               <xsl:value-of select="concat($sistoryAbsolutePath,$generatedLink)"/>
               <xsl:text>" }</xsl:text>
               <xsl:if test="position() != last()">
                  <xsl:text>,</xsl:text>
               </xsl:if>
               
               <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>
            
            <!-- KONEC JavaScript dokumenta -->
            <xsl:text>
                     ]};
                </xsl:text>
         </xsl:result-document>
      </div>
      
      <!-- JavaScript, s katerim se požene iskanje -->
      <xsl:text disable-output-escaping="yes"><![CDATA[<script>
       $(document).ready(function() {
          $('#tipue_search_input').tipuesearch({
          'show': 10,
          'descriptiveWords': 250,
          'wholeWords': false
        });
      });
</script>]]></xsl:text>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Ime osebe za iskalnik</desc>
   </doc>
   <xsl:template name="oseba-naziv">
      <xsl:for-each select="tei:persName[1]">
         <xsl:for-each select="tei:*">
            <xsl:value-of select="."/>
            <xsl:if test="position() != last()">
               <xsl:text> </xsl:text>
            </xsl:if>
         </xsl:for-each>
      </xsl:for-each>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="person-page">
      <xsl:variable name="datoteka" select="concat($outputDir,'person/',@xml:id,'.html')"/>
      <xsl:result-document href="{$datoteka}" doctype-system="" omit-xml-declaration="yes">
         <!-- vključimo HTML5 deklaracijo, skupaj z kodo za delovanje starejših verzij Internet Explorerja -->
         <xsl:value-of select="$HTML5_declaracion" disable-output-escaping="yes"/>
         <html>
            <xsl:call-template name="addLangAtt"/>
            <!-- vključimo statični head -->
            <xsl:variable name="pagetitle">
               <xsl:call-template name="oseba-naziv"/>
            </xsl:variable>
            <xsl:sequence select="tei:htmlHead($pagetitle, 2)"/>
            <!-- začetek body -->
            <body id="TOP">
               <xsl:call-template name="bodyMicroData"/>
               <xsl:call-template name="bodyJavascriptHook">
                  <xsl:with-param name="thisLanguage"  select="@xml:lang"/>
               </xsl:call-template>
               <xsl:call-template name="bodyHook"/>
               <!-- začetek vsebine -->
               <div class="column row">
                  <!-- GLAVNA VSEBINA -->
                  <section>
                     <div class="row">
                        <div class="medium-2 columns show-for-medium">
                           <!--<xsl:call-template name="previous-divGen-Link">
                              <xsl:with-param name="thisDivGenType" select="@type"/>
                              <xsl:with-param name="thisLanguage" select="@xml:lang"/>
                           </xsl:call-template>-->
                        </div>
                        <div class="medium-8 small-12 columns">
                           <h2>
                              <xsl:call-template name="oseba-naziv"/>
                           </h2>
                        </div>
                        <div class="medium-2 columns show-for-medium text-right">
                           <!--<xsl:call-template name="next-divGen-Link">
                              <xsl:with-param name="thisDivGenType" select="@type"/>
                              <xsl:with-param name="thisLanguage" select="@xml:lang"/>
                           </xsl:call-template>-->
                        </div>
                     </div>
                     <div class="row hide-for-medium">
                        <div class="small-6 columns text-center">
                           <!--<xsl:call-template name="previous-divGen-Link">
                              <xsl:with-param name="thisDivGenType" select="@type"/>
                              <xsl:with-param name="thisLanguage" select="@xml:lang"/>
                           </xsl:call-template>-->
                        </div>
                        <div class="small-6 columns text-center">
                           <!--<xsl:call-template name="next-divGen-Link">
                              <xsl:with-param name="thisDivGenType" select="@type"/>
                              <xsl:with-param name="thisLanguage" select="@xml:lang"/>
                           </xsl:call-template>-->
                        </div>
                     </div>
                     <xsl:if test="$subTocDepth >= 0">
                        <xsl:call-template name="subtoc"/>
                     </xsl:if>
                     <xsl:call-template name="startHook"/>
                     
                     <!-- VSTAVI VSEBINO tabele -->
                     <xsl:call-template name="person-table"/>
                     
                  </section>
               </div>
               <xsl:call-template name="bodyEndHook"/>
            </body>
         </html>
      </xsl:result-document>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="person-table">
      <xsl:variable name="personID" select="@xml:id"/>
      <table id="tblPerson">
         <tbody>
            <tr>
               <th style="text-align:left">ID</th>
               <td>
                  <xsl:value-of select="$personID"/>
               </td>
            </tr>
            <xsl:if test="tei:persName[not(@type)]/tei:surname">
               <tr>
                  <th style="text-align:left">Priimek</th>
                  <td>
                     <xsl:value-of select="tei:persName[not(@type)]/tei:surname"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:persName[not(@type)]/tei:forename">
               <tr>
                  <th style="text-align:left">Ime</th>
                  <td>
                     <xsl:value-of select="tei:persName[not(@type)]/tei:forename"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:persName[not(@type)]/tei:addName[@type='nickname']">
               <tr>
                  <th style="text-align:left">Vzdevek</th>
                  <td>
                     <xsl:value-of select="tei:persName[not(@type)]/tei:addName[@type='nickname']"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:persName[not(@type)]/tei:addName[@type='vulgo']">
               <tr>
                  <th style="text-align:left">Po domače</th>
                  <td>
                     <xsl:value-of select="tei:persName[not(@type)]/tei:addName[@type='vulgo']"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:persName[@type='father']/tei:forename">
               <tr>
                  <th style="text-align:left">Ime očeta</th>
                  <td>
                     <xsl:value-of select="tei:persName[@type='father']/tei:forename"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:persName[@type='mother']/tei:forename">
               <tr>
                  <th style="text-align:left">Ime matere</th>
                  <td>
                     <xsl:value-of select="tei:persName[@type='mother']/tei:forename"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:persName[@type='mother']/tei:surname">
               <tr>
                  <th style="text-align:left">Priimek matere</th>
                  <td>
                     <xsl:value-of select="tei:persName[@type='mother']/tei:surname"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:birth/tei:date/@when">
               <tr>
                  <th style="text-align:left">Datum rojstva</th>
                  <td>
                     <xsl:value-of select="tei:birth/tei:date/@when"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:birth/tei:settlement">
               <tr>
                  <th style="text-align:left">Kraj rojstva</th>
                  <td>
                     <xsl:value-of select="tei:birth/tei:settlement"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:sex">
               <tr>
                  <th style="text-align:left">Spol</th>
                  <td>
                     <xsl:choose>
                        <xsl:when test="@value='M'">moški</xsl:when>
                        <xsl:otherwise>ženski</xsl:otherwise>
                     </xsl:choose>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:state[@type='maritalStatus']/tei:desc">
               <tr>
                  <th style="text-align:left">Stan</th>
                  <td>
                     <xsl:value-of select="tei:state[@type='maritalStatus']/tei:desc"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:occupation">
               <tr>
                  <th style="text-align:left">Socialni status</th>
                  <td>
                     <xsl:value-of select="tei:occupation"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:nationality">
               <tr>
                  <th style="text-align:left">Narodnost</th>
                  <td>
                     <xsl:value-of select="tei:nationality"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:residence/tei:settlement">
               <tr>
                  <th style="text-align:left">Naslov</th>
                  <td>
                     <xsl:value-of select="tei:residence/tei:settlement"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:residence/tei:region[@type='municipality'][not(@notBefore)]">
               <tr>
                  <th style="text-align:left">Občina</th>
                  <td>
                     <xsl:value-of select="tei:residence/tei:region[@type='municipality'][not(@notBefore)]"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:residence/tei:region[@type='municipality'][@notBefore]">
               <tr>
                  <th style="text-align:left">Nova občina</th>
                  <td>
                     <xsl:value-of select="tei:residence/tei:region[@type='municipality'][@notBefore]"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:residence/tei:region[@type='province']">
               <tr>
                  <th style="text-align:left">Pokrajina</th>
                  <td>
                     <xsl:value-of select="tei:residence/tei:region[@type='province']"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:socecStatus">
               <tr>
                  <th style="text-align:left">Vojaški status</th>
                  <td>
                     <xsl:value-of select="tei:socecStatus"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:affiliation">
               <tr>
                  <th style="text-align:left">Vojaška enota</th>
                  <td>
                     <xsl:value-of select="tei:affiliation"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:death/tei:date/@when">
               <tr>
                  <th style="text-align:left">Datum smrti</th>
                  <td>
                     <xsl:value-of select="tei:death/tei:date/@when"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:death/tei:settlement">
               <tr>
                  <th style="text-align:left">Kraj smrti</th>
                  <td>
                     <xsl:value-of select="tei:death/tei:settlement"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:death/tei:country">
               <tr>
                  <th style="text-align:left">Država smrti</th>
                  <td>
                     <xsl:value-of select="tei:death/tei:country"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:note[@type='cause']">
               <tr>
                  <th style="text-align:left">Vzrok smrti</th>
                  <td>
                     <xsl:value-of select="tei:note[@type='cause']"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:note[@type='by']/tei:orgName">
               <tr>
                  <th style="text-align:left">Povzročitelj smrti</th>
                  <td>
                     <xsl:value-of select="tei:note[@type='by']/tei:orgName"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:event[@type='burial']/tei:desc/tei:location/tei:settlement">
               <tr>
                  <th style="text-align:left">Kraj pokopa</th>
                  <td>
                     <xsl:value-of select="tei:event[@type='burial']/tei:desc/tei:location/tei:settlement"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:event[@type='burial']/tei:desc/tei:location/tei:country">
               <tr>
                  <th style="text-align:left">Država pokopa</th>
                  <td>
                     <xsl:value-of select="tei:event[@type='burial']/tei:desc/tei:location/tei:country"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:if test="tei:age">
               <tr>
                  <th style="text-align:left">Starost</th>
                  <td>
                     <xsl:value-of select="tei:age"/>
                  </td>
               </tr>
            </xsl:if>
            <xsl:for-each select="tei:listBibl/tei:bibl">
               <tr>
                  <th style="text-align:left">Viri</th>
                  <td>
                     <xsl:value-of select="."/>
                  </td>
               </tr>
            </xsl:for-each>
            <xsl:for-each select="tei:note">
               <tr>
                  <th style="text-align:left">Opomba</th>
                  <td>
                     <xsl:value-of select="."/>
                  </td>
               </tr>
            </xsl:for-each>
            <tr>
               <td colspan="2">Dunja Dobaja, Marta Rendla, Mojca Šorn in Tadeja Tominšek Čehulić. <i>Smrtne žrtve med prebivalstvom na območju Republike Slovenije med drugo svetovno vojno in neposredno po njej.</i> Ljubljana: Inštitut za novejšo zgodovino, 30. 9. 2014.</td>
            </tr>
         </tbody>
      </table>
      <br/>
      <input type="button" id="btnExport" value="Izvoz podatkov (PDF)" onclick="Export()" />
      <br/>
      <br/>
      <br/>
      <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.22/pdfmake.min.js"></script>
      <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>
      <script type="text/javascript">
         function Export() {
           html2canvas(document.getElementById('tblPerson'), {
             onrendered: function (canvas) {
               var data = canvas.toDataURL();
               var docDefinition = {
                 content: [{
                   image: data,
                   width: 500
                 }]
               };
               pdfMake.createPdf(docDefinition).download("oseba-<xsl:value-of select="$personID"/>.pdf");
             }
           });
         }
      </script>
   </xsl:template>
   
</xsl:stylesheet>
