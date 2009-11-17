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
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{

#include <stdio.h>
#include <string.h>
#include "y.xml.h"

#ifdef WIN32

#include <io.h>
#include <vector>
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
vector<char*> operands[255];
int nsemi=0 ;           // Number of semi-colons
int noperators=0 ;      // Total number of operators
int noperands=0;        // Total number of operands

#define NOTE_SLOC()     sloc.insert(xml_lineno); sltag.insert(xml_lineno)

void lexclear();
void store_operand(char* txt);
void store_operator(int op);

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

"wsml:and"                        {store_operator(WSML_AND);}
"wsml:argument"                   {store_operator(WSML_ARGUMENT);}
"wsml:assumption"                 {store_operator(WSML_ASSUMPTION);}
"wsml:atom"                       {store_operator(WSML_ATOM);}
"wsml:attribute"                  {store_operator(WSML_ATTRIBUTE);}
"wsml:attributeDefinition"        {store_operator(WSML_ATTRIBUTEDEFINITION);}
"wsml:attributeID"                {store_operator(WSML_ATTRIBUTEID);}
"wsml:attributeValue"             {store_operator(WSML_ATTRIBUTEVALUE);}
"wsml:axiom"                      {store_operator(WSML_AXIOM);}
"wsml:capability"                 {store_operator(WSML_CAPABILITY);}
"wsml:choreography"               {store_operator(WSML_CHOREOGRAPHY);}
"wsml:concept"                    {store_operator(WSML_CONCEPT);}
"wsml:conjunction"                {store_operator(WSML_CONJUNCTION);}
"wsml:constraint"                 {store_operator(WSML_CONSTRAINT);}
"wsml:definedBy"                  {store_operator(WSML_DEFINEDBY);}
"wsml:disjunction"                {store_operator(WSML_DISJUNCTION);}
"wsml:effect"                     {store_operator(WSML_EFFECT);}
"wsml:equivalent"                 {store_operator(WSML_EQUIVALENT);}
"wsml:exists"                     {store_operator(WSML_EXISTS);}
"wsml:forall"                     {store_operator(WSML_FORALL);}
"wsml:function "                  {store_operator(WSML_FUNCTION );}
"wsml:ggMediator"                 {store_operator(WSML_GGMEDIATOR);}
"wsml:goal"                       {store_operator(WSML_GOAL);}
"wsml:id"                         {store_operator(WSML_ID );}
"wsml:implication"                {store_operator(WSML_IMPLICATION );}
"wsml:impliedBy"                  {store_operator(WSML_IMPLIEDBY);}
"wsml:impliedByLP"                {store_operator(WSML_IMPLIEDBYLP);}
"wsml:implies"                    {store_operator(WSML_IMPLIES);}
"wsml:importsOntology"            {store_operator(WSML_IMPORTSONTOLOGY);}
"wsml:instance"                   {store_operator(WSML_INSTANCE);}
"wsml:interface"                  {store_operator(WSML_INTERFACE);}
"wsml:inverseOf"                  {store_operator(WSML_INVERSEOF);}
"wsml:isa"                        {store_operator(WSML_ISA);}
"wsml:leftHandSide"               {store_operator(WSML_LEFTHANDSIDE);}
"wsml:maxCardinality"             {store_operator(WSML_MAXCARDINALITY);}
"wsml:memberOf"                   {store_operator(WSML_MEMBEROF);}
"wsml:minCardinality"             {store_operator(WSML_MINCARDINALITY);}
"wsml:molecule"                   {store_operator(WSML_MOLECULE);}
"wsml:naf"                        {store_operator(WSML_NAF);}
"wsml:neg"                        {store_operator(WSML_NEG);}
"wsml:nonFunctionalProperties"    {store_operator(WSML_NONFUNCTIONALPROPERTIES);}
"wsml:ontology"                   {store_operator(WSML_ONTOLOGY);}
"wsml:ooMediator"                 {store_operator(WSML_OOMEDIATOR);}
"wsml:or"                         {store_operator(WSML_OR);}
"wsml:orchestration"              {store_operator(WSML_ORCHESTRATION);}
"wsml:parameter"                  {store_operator(WSML_PARAMETER);}
"wsml:parameters"                 {store_operator(WSML_PARAMETERS);}
"wsml:postcondition"              {store_operator(WSML_POSTCONDITION);}
"wsml:precondition"               {store_operator(WSML_PRECONDITION);}
"wsml:predicate"                  {store_operator(WSML_PREDICATE);}
"wsml:quantification "            {store_operator(WSML_QUANTIFICATION );}
"wsml:range"                      {store_operator(WSML_RANGE);}
"wsml:reflexive"                  {store_operator(WSML_REFLEXIVE);}
"wsml:relation"                   {store_operator(WSML_RELATION);}
"wsml:relationInstance"           {store_operator(WSML_RELATIONINSTANCE);}
"wsml:rightHandSide"              {store_operator(WSML_RIGHTHANDSIDE);}
"wsml:sharedVariables"            {store_operator(WSML_SHAREDVARIABLES);}
"wsml:source"                     {store_operator(WSML_SOURCE);}
"wsml:superConcept"               {store_operator(WSML_SUPERCONCEPT);}
"wsml:superRelation"              {store_operator(WSML_SUPERRELATION);}
"wsml:symmetric"                  {store_operator(WSML_SYMMETRIC);}
"wsml:target"                     {store_operator(WSML_TARGET);}
"wsml:term"                       {store_operator(WSML_TERM);}
"wsml:transitive"                 {store_operator(WSML_TRANSITIVE);}
"wsml:type"                       {store_operator(WSML_TYPE);}
"wsml:usesMediator"               {store_operator(WSML_USESMEDIATOR);}
"wsml:usesService"                {store_operator(WSML_USESSERVICE);}
"wsml:value"                      {store_operator(WSML_VALUE);}
"wsml:version"                    {store_operator(WSML_VERSION);}
"wsml:webService"                 {store_operator(WSML_WEBSERVICE);}
"wsml:wgMediator"                 {store_operator(WSML_WGMEDIATOR);}
"wsml:wsml"                       {store_operator(WSML_WSML);}
"wsml:wwMediator"                 {store_operator(WSML_WWMEDIATOR);}
"xs:all"                          {store_operator(XSD_ALL);}
"xs:anyAttribute"                 {store_operator(XSD_ANYATTRIBUTE);}
"xs:attribute"                    {store_operator(XSD_ATTRIBUTE);}
"xs:choice"                       {store_operator(XSD_CHOICE);}
"xs:complexType"                  {store_operator(XSD_COMPLEXTYPE);}
"xs:element"                      {store_operator(XSD_ELEMENT);}
"xs:enumeration"                  {store_operator(XSD_ENUMERATION);}
"xs:fractionDigits"               {store_operator(XSD_FRACTIONDIGITS);}
"xs:length"                       {store_operator(XSD_LENGTH);}
"xs:maxExclusive"                 {store_operator(XSD_MAXEXCLUSIVE);}
"xs:maxInclusive"                 {store_operator(XSD_MAXINCLUSIVE);}
"xs:maxLength"                    {store_operator(XSD_MAXLENGTH);}
"xs:minExclusive"                 {store_operator(XSD_MINEXCLUSIVE);}
"xs:minInclusive"                 {store_operator(XSD_MININCLUSIVE);}
"xs:minLength"                    {store_operator(XSD_MINLENGTH);}
"xs:pattern"                      {store_operator(XSD_PATTERN);}
"xs:restriction"                  {store_operator(XSD_RESTRICTION);}
"xs:schema"                       {store_operator(XSD_SCHEMA);}
"xs:simpleContent"                {store_operator(XSD_SIMPLECONTENT);}
"xs:simpleType"                   {store_operator(XSD_SIMPLETYPE);}
"xs:totalDigits"                  {store_operator(XSD_TOTALDIGITS);}
"xsl:apply-imports"               {store_operator(XSL_APPLY_IMPORTS);}
"xsl:apply-templates"             {store_operator(XSL_APPLY_TEMPLATES);}
"xsl:attribute"                   {store_operator(XSL_ATTRIBUTE);}
"xsl:attribute-set"               {store_operator(XSL_ATTRIBUTE_SET);}
"xsl:call-template"               {store_operator(XSL_CALL_TEMPLATE);}
"xsl:choose"                      {store_operator(XSL_CHOOSE);}
"xsl:comment"                     {store_operator(XSL_COMMENT);}
"xsl:copy"                        {store_operator(XSL_COPY);}
"xsl:copy-of"                     {store_operator(XSL_COPY_OF);}
"xsl:decimal-format"              {store_operator(XSL_DECIMAL_FORMAT);}
"xsl:element"                     {store_operator(XSL_ELEMENT);}
"xsl:fallback"                    {store_operator(XSL_FALLBACK);}
"xsl:for-each"                    {store_operator(XSL_FOR_EACH);}
"xsl:if"                          {store_operator(XSL_IF);}
"xsl:import"                      {store_operator(XSL_IMPORT);}
"xsl:include"                     {store_operator(XSL_INCLUDE);}
"xsl:key"                         {store_operator(XSL_KEY);}
"xsl:message"                     {store_operator(XSL_MESSAGE);}
"xsl:namespace-alias"             {store_operator(XSL_NAMESPACE_ALIAS);}
"xsl:number"                      {store_operator(XSL_NUMBER);}
"xsl:otherwise"                   {store_operator(XSL_OTHERWISE);}
"xsl:output"                      {store_operator(XSL_OUTPUT);}
"xsl:param"                       {store_operator(XSL_PARAM);}
"xsl:preserve-space"              {store_operator(XSL_PRESERVE_SPACE);}
"xsl:processing-instruction"      {store_operator(XSL_PROCESSING_INSTRUCTION);}
"xsl:sort"                        {store_operator(XSL_SORT);}
"xsl:strip-space"                 {store_operator(XSL_STRIP_SPACE);}
"xsl:stylesheet"                  {store_operator(XSL_STYLESHEET);}
"xsl:template"                    {store_operator(XSL_TEMPLATE);}
"xsl:text"                        {store_operator(XSL_TEXT);}
"xsl:transform"                   {store_operator(XSL_TRANSFORM);}
"xsl:value-of"                    {store_operator(XSL_VALUE_OF);}
"xsl:variable"                    {store_operator(XSL_VARIABLE);}
"xsl:when"                        {store_operator(XSL_WHEN);}
"xsl:with-param"                  {store_operator(XSL_WITH_PARAM);}

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
"."{DIGITS}[eE]{SIGN}?                                      {store_operand(_strdup(yytext));NOTE_SLOC();}

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
  sltag.clear();

  for (int i=0; i<255; i++) {
    if (operands[i].size() > 0) operands[i].clear();
  }
}

void store_operand(char* txt) {
  char c;
  unsigned int i;
  noperands++;

  c=txt[0];
  for (i=0;i<operands[c].size();i++) {
    if (!strcmp(txt,operands[c][i])) return;
  }
  operands[c].push_back(txt);

  NOTE_SLOC();
}

void store_operator(int op) {
  operators.insert(op);
  noperators++;
  NOTE_SLOC();
}
