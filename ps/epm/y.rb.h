/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 Power Software
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * Ruby parser lexemes
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  20-Aug-2009  10452 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#define KEY_ALIAS           256
#define KEY_AND             257
#define KEY_BEGIN           258
#define KEY_BREAK           259
#define KEY_CASE            260
#define KEY_CLASS           261
#define KEY_DEF             262
#define KEY_DEFINED         263
#define KEY_DO              264
#define KEY_ELSE            265
#define KEY_ELSIF           266
#define KEY_END             267
#define KEY_ENSURE          268
#define KEY_FALSE           269
#define KEY_FOR             270
#define KEY_HIGH            271
#define KEY_IF              272
#define KEY_IN              273
#define KEY_LOW             274
#define KEY_MODULE          275
#define KEY_NEXT            276
#define KEY_NIL             277
#define KEY_NOT             278
#define KEY_OR              279
#define KEY_REDO            280
#define KEY_RESCUE          281
#define KEY_RETRY           282
#define KEY_RETURN          283
#define KEY_SELF            284
#define KEY_SUPER           285
#define KEY_THEN            286
#define KEY_TRUE            287
#define KEY_UNDEF           288
#define KEY_UNLESS          289
#define KEY_UNTIL           290
#define KEY_WHEN            291
#define KEY_WHILE           292
#define KEY_YIELD           293
#define SYM_MINUS           294
#define SYM_PCT             295
#define SYM_AND             296
#define SYM_CARAT           297
#define SYM_TILDE           298
#define SYM_PLUS            299
#define SYM_EQ              300
#define SYM_NOT             301
#define SYM_AST             302
#define SYM_ELLIPSIS        303
#define SYM_DIV             304
#define SYM_OR              305
#define SYM_LT              306
#define SYM_GT              307
#define SYM_NOTTILDE        308
#define SYM_PCTEQ           309
#define SYM_ORAND           310
#define SYM_AMPEQ           311
#define SYM_ASTAST          312
#define SYM_ASTEQ           313
#define SYM_DIVEQ           314
#define SYM_SCOPE           315
#define SYM_TILDEEQ         316
#define SYM_LOGOR           317
#define SYM_OREQ            318
#define SYM_PLUSEQ          319
#define SYM_LTEQ            320
#define SYM_MINUSEQ         321
#define SYM_GTGT            322
#define SYM_DOTDOT          323
#define SYM_NOTEQ           324
#define SYM_LTLT            325
#define SYM_EQTILDE         326
#define SYM_EQEQ            327
#define SYM_GTEQ            328
#define SYM_LOGANDEQ        329
#define SYM_ASTASTEQ        330
#define SYM_LOGOREQ         331
#define SYM_LTLTEQ          332
#define SYM_GTGTEQ          333
#define SYM_LTEQGT          334
#define SYM_EQEQEQ          335
