/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * XML Parser
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  10-Dec-07    325 : File created.
 * CAM  24-Apr-08    358 : Corrected compiler warnings moving to VS2008 (from VC++6).
 * CAM  14-Apr-2009  10418 : Ordered file as per lexer.cs.l (#10416).
 * CAM  22-Sep-2010  10648 : Converted from string operands to PowerHashed.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.xml.h"
#include "PowerHash.h"

#ifdef WIN32

#include <io.h>
#include <set>
using namespace std;

#else

#include <stl.h>
#include <unistd.h>

#endif

int xml_lineno=0;
int j_comments=0;
int c_comments=0;
int cpp_comments=0;
int com_loc=0;

set<int> sloc;
set<int> sltag;
set<int> operators;
set<unsigned int> operands;
int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()       sloc.insert(xml_lineno); sltag.insert(xml_lineno)
#define STORE_OPERATOR(X) operators.insert(X); noperators++; NOTE_SLOC();
#define STORE_OPERAND(X)  operands.insert(PowerHash(X)); noperands++; NOTE_SLOC();
#define SEMI()            nsemi++; NOTE_SLOC();

void lexclear();

%}

%p 4096
%x HTML_COM
%x STRS
%x STRD

NL                                "\n"
NOTNL                             .
ANY                               ({NOTNL}|{NL})
BACKSL                            "\\"
BOL                               ^
LETTER                            [A-Za-z_]
ALNUM                             [A-Za-z_0-9]
DIGIT                             [0-9]
HEXDIGIT                          [0-9A-Fa-f]
DIGITS                            ({DIGIT}+)
EXP                               [Ee][+-]?DIGITS
HEXDIGITS                         ({HEXDIGIT}+)
SIGN                              ("+"|"-")
ELL_SUFFIX                        [lL]([lL]?)
INT_SUFFIX                        ([uU]{ELL_SUFFIX}?|{ELL_SUFFIX}[uU]?)
FLOAT_SUFFIX                      [flFL]
STRCHAR                           [^\"\n\\]
ESCAPE                            ({BACKSL}{ANY})
QUOTE                             [\"]
SPTAB                             [ \t]

%%

"<!--"                            {com_loc++; c_comments++; BEGIN HTML_COM;}
<HTML_COM>"-->"                   {BEGIN 0;}
<HTML_COM>"\n"                    {com_loc++; xml_lineno++;}
<HTML_COM>.                       {;}

\"                                {BEGIN STRD;}
"'"                               {BEGIN STRS;}

<STRD>"\n"                        {NOTE_SLOC(); xml_lineno++; /* Double-quoted string literals */}
<STRD>\"                          {NOTE_SLOC(); BEGIN 0;}
<STRD>.                           {NOTE_SLOC();}

<STRS>"\n"                        {NOTE_SLOC(); xml_lineno++; /* Single-quoted string literals */}
<STRS>"'"                         {NOTE_SLOC(); BEGIN 0;}
<STRS>.                           {NOTE_SLOC();}

\n                                {xml_lineno++;}

"<"                               {NOTE_SLOC();}
">"                               {NOTE_SLOC();}

"wsml:and"                        {STORE_OPERATOR(WSML_AND);}
"wsml:argument"                   {STORE_OPERATOR(WSML_ARGUMENT);}
"wsml:assumption"                 {STORE_OPERATOR(WSML_ASSUMPTION);}
"wsml:atom"                       {STORE_OPERATOR(WSML_ATOM);}
"wsml:attribute"                  {STORE_OPERATOR(WSML_ATTRIBUTE);}
"wsml:attributeDefinition"        {STORE_OPERATOR(WSML_ATTRIBUTEDEFINITION);}
"wsml:attributeID"                {STORE_OPERATOR(WSML_ATTRIBUTEID);}
"wsml:attributeValue"             {STORE_OPERATOR(WSML_ATTRIBUTEVALUE);}
"wsml:axiom"                      {STORE_OPERATOR(WSML_AXIOM);}
"wsml:capability"                 {STORE_OPERATOR(WSML_CAPABILITY);}
"wsml:choreography"               {STORE_OPERATOR(WSML_CHOREOGRAPHY);}
"wsml:concept"                    {STORE_OPERATOR(WSML_CONCEPT);}
"wsml:conjunction"                {STORE_OPERATOR(WSML_CONJUNCTION);}
"wsml:constraint"                 {STORE_OPERATOR(WSML_CONSTRAINT);}
"wsml:definedBy"                  {STORE_OPERATOR(WSML_DEFINEDBY);}
"wsml:disjunction"                {STORE_OPERATOR(WSML_DISJUNCTION);}
"wsml:effect"                     {STORE_OPERATOR(WSML_EFFECT);}
"wsml:equivalent"                 {STORE_OPERATOR(WSML_EQUIVALENT);}
"wsml:exists"                     {STORE_OPERATOR(WSML_EXISTS);}
"wsml:forall"                     {STORE_OPERATOR(WSML_FORALL);}
"wsml:function "                  {STORE_OPERATOR(WSML_FUNCTION );}
"wsml:ggMediator"                 {STORE_OPERATOR(WSML_GGMEDIATOR);}
"wsml:goal"                       {STORE_OPERATOR(WSML_GOAL);}
"wsml:id"                         {STORE_OPERATOR(WSML_ID );}
"wsml:implication"                {STORE_OPERATOR(WSML_IMPLICATION );}
"wsml:impliedBy"                  {STORE_OPERATOR(WSML_IMPLIEDBY);}
"wsml:impliedByLP"                {STORE_OPERATOR(WSML_IMPLIEDBYLP);}
"wsml:implies"                    {STORE_OPERATOR(WSML_IMPLIES);}
"wsml:importsOntology"            {STORE_OPERATOR(WSML_IMPORTSONTOLOGY);}
"wsml:instance"                   {STORE_OPERATOR(WSML_INSTANCE);}
"wsml:interface"                  {STORE_OPERATOR(WSML_INTERFACE);}
"wsml:inverseOf"                  {STORE_OPERATOR(WSML_INVERSEOF);}
"wsml:isa"                        {STORE_OPERATOR(WSML_ISA);}
"wsml:leftHandSide"               {STORE_OPERATOR(WSML_LEFTHANDSIDE);}
"wsml:maxCardinality"             {STORE_OPERATOR(WSML_MAXCARDINALITY);}
"wsml:memberOf"                   {STORE_OPERATOR(WSML_MEMBEROF);}
"wsml:minCardinality"             {STORE_OPERATOR(WSML_MINCARDINALITY);}
"wsml:molecule"                   {STORE_OPERATOR(WSML_MOLECULE);}
"wsml:naf"                        {STORE_OPERATOR(WSML_NAF);}
"wsml:neg"                        {STORE_OPERATOR(WSML_NEG);}
"wsml:nonFunctionalProperties"    {STORE_OPERATOR(WSML_NONFUNCTIONALPROPERTIES);}
"wsml:ontology"                   {STORE_OPERATOR(WSML_ONTOLOGY);}
"wsml:ooMediator"                 {STORE_OPERATOR(WSML_OOMEDIATOR);}
"wsml:or"                         {STORE_OPERATOR(WSML_OR);}
"wsml:orchestration"              {STORE_OPERATOR(WSML_ORCHESTRATION);}
"wsml:parameter"                  {STORE_OPERATOR(WSML_PARAMETER);}
"wsml:parameters"                 {STORE_OPERATOR(WSML_PARAMETERS);}
"wsml:postcondition"              {STORE_OPERATOR(WSML_POSTCONDITION);}
"wsml:precondition"               {STORE_OPERATOR(WSML_PRECONDITION);}
"wsml:predicate"                  {STORE_OPERATOR(WSML_PREDICATE);}
"wsml:quantification "            {STORE_OPERATOR(WSML_QUANTIFICATION );}
"wsml:range"                      {STORE_OPERATOR(WSML_RANGE);}
"wsml:reflexive"                  {STORE_OPERATOR(WSML_REFLEXIVE);}
"wsml:relation"                   {STORE_OPERATOR(WSML_RELATION);}
"wsml:relationInstance"           {STORE_OPERATOR(WSML_RELATIONINSTANCE);}
"wsml:rightHandSide"              {STORE_OPERATOR(WSML_RIGHTHANDSIDE);}
"wsml:sharedVariables"            {STORE_OPERATOR(WSML_SHAREDVARIABLES);}
"wsml:source"                     {STORE_OPERATOR(WSML_SOURCE);}
"wsml:superConcept"               {STORE_OPERATOR(WSML_SUPERCONCEPT);}
"wsml:superRelation"              {STORE_OPERATOR(WSML_SUPERRELATION);}
"wsml:symmetric"                  {STORE_OPERATOR(WSML_SYMMETRIC);}
"wsml:target"                     {STORE_OPERATOR(WSML_TARGET);}
"wsml:term"                       {STORE_OPERATOR(WSML_TERM);}
"wsml:transitive"                 {STORE_OPERATOR(WSML_TRANSITIVE);}
"wsml:type"                       {STORE_OPERATOR(WSML_TYPE);}
"wsml:usesMediator"               {STORE_OPERATOR(WSML_USESMEDIATOR);}
"wsml:usesService"                {STORE_OPERATOR(WSML_USESSERVICE);}
"wsml:value"                      {STORE_OPERATOR(WSML_VALUE);}
"wsml:version"                    {STORE_OPERATOR(WSML_VERSION);}
"wsml:webService"                 {STORE_OPERATOR(WSML_WEBSERVICE);}
"wsml:wgMediator"                 {STORE_OPERATOR(WSML_WGMEDIATOR);}
"wsml:wsml"                       {STORE_OPERATOR(WSML_WSML);}
"wsml:wwMediator"                 {STORE_OPERATOR(WSML_WWMEDIATOR);}
"xs:all"                          {STORE_OPERATOR(XSD_ALL);}
"xs:anyAttribute"                 {STORE_OPERATOR(XSD_ANYATTRIBUTE);}
"xs:attribute"                    {STORE_OPERATOR(XSD_ATTRIBUTE);}
"xs:choice"                       {STORE_OPERATOR(XSD_CHOICE);}
"xs:complexType"                  {STORE_OPERATOR(XSD_COMPLEXTYPE);}
"xs:element"                      {STORE_OPERATOR(XSD_ELEMENT);}
"xs:enumeration"                  {STORE_OPERATOR(XSD_ENUMERATION);}
"xs:fractionDigits"               {STORE_OPERATOR(XSD_FRACTIONDIGITS);}
"xs:length"                       {STORE_OPERATOR(XSD_LENGTH);}
"xs:maxExclusive"                 {STORE_OPERATOR(XSD_MAXEXCLUSIVE);}
"xs:maxInclusive"                 {STORE_OPERATOR(XSD_MAXINCLUSIVE);}
"xs:maxLength"                    {STORE_OPERATOR(XSD_MAXLENGTH);}
"xs:minExclusive"                 {STORE_OPERATOR(XSD_MINEXCLUSIVE);}
"xs:minInclusive"                 {STORE_OPERATOR(XSD_MININCLUSIVE);}
"xs:minLength"                    {STORE_OPERATOR(XSD_MINLENGTH);}
"xs:pattern"                      {STORE_OPERATOR(XSD_PATTERN);}
"xs:restriction"                  {STORE_OPERATOR(XSD_RESTRICTION);}
"xs:schema"                       {STORE_OPERATOR(XSD_SCHEMA);}
"xs:simpleContent"                {STORE_OPERATOR(XSD_SIMPLECONTENT);}
"xs:simpleType"                   {STORE_OPERATOR(XSD_SIMPLETYPE);}
"xs:totalDigits"                  {STORE_OPERATOR(XSD_TOTALDIGITS);}
"xsl:apply-imports"               {STORE_OPERATOR(XSL_APPLY_IMPORTS);}
"xsl:apply-templates"             {STORE_OPERATOR(XSL_APPLY_TEMPLATES);}
"xsl:attribute"                   {STORE_OPERATOR(XSL_ATTRIBUTE);}
"xsl:attribute-set"               {STORE_OPERATOR(XSL_ATTRIBUTE_SET);}
"xsl:call-template"               {STORE_OPERATOR(XSL_CALL_TEMPLATE);}
"xsl:choose"                      {STORE_OPERATOR(XSL_CHOOSE);}
"xsl:comment"                     {STORE_OPERATOR(XSL_COMMENT);}
"xsl:copy"                        {STORE_OPERATOR(XSL_COPY);}
"xsl:copy-of"                     {STORE_OPERATOR(XSL_COPY_OF);}
"xsl:decimal-format"              {STORE_OPERATOR(XSL_DECIMAL_FORMAT);}
"xsl:element"                     {STORE_OPERATOR(XSL_ELEMENT);}
"xsl:fallback"                    {STORE_OPERATOR(XSL_FALLBACK);}
"xsl:for-each"                    {STORE_OPERATOR(XSL_FOR_EACH);}
"xsl:if"                          {STORE_OPERATOR(XSL_IF);}
"xsl:import"                      {STORE_OPERATOR(XSL_IMPORT);}
"xsl:include"                     {STORE_OPERATOR(XSL_INCLUDE);}
"xsl:key"                         {STORE_OPERATOR(XSL_KEY);}
"xsl:message"                     {STORE_OPERATOR(XSL_MESSAGE);}
"xsl:namespace-alias"             {STORE_OPERATOR(XSL_NAMESPACE_ALIAS);}
"xsl:number"                      {STORE_OPERATOR(XSL_NUMBER);}
"xsl:otherwise"                   {STORE_OPERATOR(XSL_OTHERWISE);}
"xsl:output"                      {STORE_OPERATOR(XSL_OUTPUT);}
"xsl:param"                       {STORE_OPERATOR(XSL_PARAM);}
"xsl:preserve-space"              {STORE_OPERATOR(XSL_PRESERVE_SPACE);}
"xsl:processing-instruction"      {STORE_OPERATOR(XSL_PROCESSING_INSTRUCTION);}
"xsl:sort"                        {STORE_OPERATOR(XSL_SORT);}
"xsl:strip-space"                 {STORE_OPERATOR(XSL_STRIP_SPACE);}
"xsl:stylesheet"                  {STORE_OPERATOR(XSL_STYLESHEET);}
"xsl:template"                    {STORE_OPERATOR(XSL_TEMPLATE);}
"xsl:text"                        {STORE_OPERATOR(XSL_TEXT);}
"xsl:transform"                   {STORE_OPERATOR(XSL_TRANSFORM);}
"xsl:value-of"                    {STORE_OPERATOR(XSL_VALUE_OF);}
"xsl:variable"                    {STORE_OPERATOR(XSL_VARIABLE);}
"xsl:when"                        {STORE_OPERATOR(XSL_WHEN);}
"xsl:with-param"                  {STORE_OPERATOR(XSL_WITH_PARAM);}

{LETTER}{ALNUM}*                                            |
[1-9][0-9]*{INT_SUFFIX}?                                    |
[0][0-7]*{INT_SUFFIX}?                                      |
[0][xX][0-9A-Fa-f]+{INT_SUFFIX}?                            |
[0][xX]                                                     |
{DIGITS}"."{DIGITS}?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?   |
{DIGITS}"."?([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?           |
"."{DIGITS}([eE]{SIGN}?{DIGITS})?{FLOAT_SUFFIX}?            |
{DIGITS}"."{DIGITS}?[eE]{SIGN}?                             |
{DIGITS}"."?[eE]{SIGN}?                                     |
"."{DIGITS}[eE]{SIGN}?                                      {STORE_OPERAND(yytext);}

[ \t\v\f]               { /* ignore whitespace     */ }
.                       { /* ignore bad characters */ }

%%
int yywrap() {
  return(1);
}

void lexclear() {
  BEGIN 0;
  noperands=0;
  j_comments=c_comments=cpp_comments=com_loc=0;
  nsemi=noperators=0;
  xml_lineno=1;

  sloc.clear();
  operators.clear();
  operands.clear();

  sltag.clear();
}
