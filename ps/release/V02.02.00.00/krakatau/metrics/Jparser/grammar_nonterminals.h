/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Krakatau Java Parser (JPARSER.EXE)
 * Copyright (c) 2000,2008 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  29-Mar-08  346 : File added to source control.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

int parse_VariableInitializer();
void parse_ArgumentList_opt();
void parse_VariableInitializers_opt();
int parse_BlockStatement();
int parse_LocalVariableDeclarationStatement();
void parse_SwitchBlockStatementGroups_opt();
int parse_ArrayCreationExpression();
int parse_MultiplicativeOperator();
int parse_AdditiveOperator();
int parse_ShiftOperator();
int parse_RelationalOperator();
int parse_EqualityOperator();
int parse_SwitchLabels();
int parse_Goal(char*);
int parse_Literal();
int parse_Type();
int parse_PrimitiveType();
int parse_NumericType();
int parse_IntegralType();
int parse_FloatingPointType();
int parse_ReferenceType();
int parse_ClassOrInterfaceType();
int parse_ClassType();
int parse_INterfaceType();
int parse_ArrayType();
int parse_Name();
int parse_SimpleName();
int parse_QualifiedName();
int parse_CompilationUnit();
int parse_ImportDeclarations();
void parse_ImportDeclarations_opt();
int parse_TypeDeclarations();
void parse_TypeDeclarations_opt();
int parse_PackageDeclaration();
void parse_PackageDeclaration_opt();
int parse_ImportDeclaration();
int parse_SingleTypeImportDeclaration();
int parse_TypeImportOnDemandDeclaration();
int parse_TypeDeclaration();
int parse_Modifiers();
void parse_Modifiers_opt();
int parse_Modifier();
int parse_ClassDeclaration();
int parse_Super();
void parse_Super_opt();
int parse_Interfaces();
void parse_Interfaces_opt();
int parse_InterfaceTypeList();
int parse_ClassBody();
int parse_ClassBodyDeclarations();
void parse_ClassBodyDeclarations_opt();
int parse_ClassBodyDeclaration();
int parse_ClassMemberDeclaration();
int parse_FieldDeclaration();
int parse_VariableDeclarators();
int parse_VariableDeclarator();
int parse_VariableDeclaratorId();
int parse_MethodDeclaration();
int parse_MethodHeader();
int parse_MethodDeclarator();
int parse_FormalParameterList();
void parse_FormalParameterList_opt();
int parse_FormalParameter();
int parse_Throws();
void parse_Throws_opt();
int parse_ClassTypeList();
int parse_MethodBody();
int parse_StaticInitializer();
int parse_ConstructorDeclaration();
int parse_ConstructorDeclarator();
int parse_ConstructorBody();
int parse_ExplicitConstructorInvocation();
void parse_ExplicitConstructorInvocation_opt();
int parse_InterfaceDeclaration();
int parse_ExtendsInterfaces();
void parse_ExtendsInterfaces_opt();
int parse_InterfaceBody();
int parse_InterfaceMemberDeclarations();
void parse_InterfaceMemberDeclarations_opt();
int parse_InterfaceMemberDeclaration();
int parse_ConstantDeclaration();
int parse_AbstractMethodDeclaration();
int parse_ArrayInitializer();
int parse_VariableInitializers();
int parse_Block();
int parse_BlockStatements();
void parse_BlockStatements_opt();
int parse_LocalVariableDeclarationSTatement();
int parse_LocalVariableDeclaration();
int parse_Statement();
int parse_StatementNoShortIf();
int parse_StatementWithoutTrailingSubstatement();
int parse_EmptyStatement();
int parse_LabeledStatement();
int parse_LabeledStatementNoShortIf();
int parse_ExpressionStatement();
int parse_StatementExpression();
int parse_IfThenStatement();
int parse_IfThenElseStatement();
int parse_IfThenElseStatementNoShortIf();
int parse_SwitchStatement();
int parse_SwitchBlock();
int parse_SwitchBlockStatementGroups();
int parse_SwitchBlockStatementGroup();
int parse_SwitchLabeles();
void parse_SwitchLabels_opt();
int parse_SwitchLabel();
int parse_WhileStatement();
int parse_WhileStatementNoShortIf();
int parse_DoStatement();
int parse_ForStatement();
int parse_ForStatementNoShortIf();
int parse_ForInit();
void parse_ForInit_opt();
int parse_ForUpdate();
void parse_ForUpdate_opt();
int parse_StatementExpressionList();
int parse_BreakStatement();
int parse_ContinueStatement();
int parse_ReturnStatement();
int parse_ThrowStatement();
int parse_SynchronizedStatement();
int parse_TryStatement();
int parse_Catches();
int parse_CatchClause();
int parse_Finally();
void parse_Finally_opt();
int parse_Primary();
int parse_PrimaryNoNewArray();
int parse_ClassInstanceCreationExpression();
int parse_argumentList();
int parse_DimExprs();
int parse_DimExpr();
int parse_Dims();
void parse_Dims_opt();
int parse_FieldAccess();
int parse_MethodInvocation();
int parse_ArrayAccess();
int parse_PostfixExpression();
int parse_PostIncrementExpression();
int parse_PostDecrementExpression();
int parse_UnaryExpression();
int parse_PreIncrementExpression();
int parse_PreDecrementExpression();
int parse_UnaryExpressionNotPlusMinus();
int parse_CastExpression();
int parse_MultiplicativeExpression();
int parse_AdditiveExpression();
int parse_ShiftExpression();
int parse_RelationalExpression();
int parse_EqualityExpression();
int parse_AndExpression();
int parse_ExclusiveOrExpression();
int parse_InclusiveOrExpression();
int parse_ConditionalAndExpression();
int parse_ConditionalOrExpression();
int parse_ConditionalExpression();
int parse_AssignmentExpression();
int parse_Assignment();
int parse_NewExpression();
int parse_Constant();
int parse_NewArray();
int parse_ExpressionList();
void parse_ExpressionList_opt();
int parse_LeftHandSide();
int parse_AssignmentOperator();
int parse_Expression();
void parse_Expression_opt();
int parse_ConstantExpression();

int parse_DeclReferenceType();
int parse_DeclArrayType();
int parse_DeclClassOrInterfaceType();
