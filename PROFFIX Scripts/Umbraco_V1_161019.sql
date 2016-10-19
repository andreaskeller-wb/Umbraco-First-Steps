/*
    Author:      andreas.kellr@workbooster.ch
    Created on:  19.10.2016
    Description: Additional fields for Umbraco_V1
*/



/*  
    Additional Field: Z_Datum, Table: ADR_Adressen, Date: 19.10.2016  
*/

IF  EXISTS (SELECT 
        * 
    FROM 
        sys.objects        obj
    LEFT JOIN 
        sys.columns        col
    ON     
        obj.object_id      = col.object_id
    WHERE 
        obj.object_id      = OBJECT_ID(N'[dbo].[ADR_Adressen]') 
    AND    obj.type        IN (N'U')
    AND    col.name        = 'Z_Datum')

BEGIN

    ALTER TABLE [dbo].[ADR_Adressen] DROP COLUMN [Z_Datum]
    
    PRINT ''
    PRINT 'Z_Datum: Additional field exists - overwritten!'
    
END

ALTER TABLE ADR_Adressen ADD Z_Datum [datetime] NULL

DELETE FROM 
    Zusatzfelder 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Datum'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'Zusatzfelder') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'Zusatzfelder')
END

INSERT INTO 
    Zusatzfelder
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    TableName,
    ColName,
    ColType,
    ColLength,
    ColDec,
    ColDefValue,
    ColZwang,
    ColPosition,
    ColTitle,
    ColSelection,
    ColGroup,
    ColLeft,
    ReadOnly) 
VALUES
(   /* LaufNr */    (    SELECT 
                             LaufNr + 1 
                         FROM 
                             LaufNummern 
                         WHERE 
                             Tabelle = 'Zusatzfelder'),    
    /* ImportNr */       0,    
    /* ErstelltAm */     { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */    '',    
    /* Geaendert */      1,    
    /* Exportiert */     0,    
    /* GeaendertAm */    { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */   '',    
    /* TableName */      'ADR_Adressen',
    /* ColName */        'Z_Datum',
    /* ColType */        'pxTools.pxDate',
    /* ColLength */      10,
    /* ColDec */         0,
    /* ColDefValue */    null,
    /* ColZwang */       0,
    /* ColPosition */    13,
    /* ColTitle */       'Datum',
    /* ColSelection */   null,
    /* ColGroup */       'Datentypen',
    /* ColLeft */        0,
    /* ReadOnly */       0)

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'Zusatzfelder'

DELETE FROM 
    TableColumn 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Datum'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'TableColumn') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'TableColumn')
END

INSERT INTO 
    TableColumn
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    COLALIGNMENT,
    COLDEC,
    COLDISPLAYLENGTH,
    COLFIELDTYPE,
    COLFORMAT,
    COLLEFT,
    COLLENGTH,
    COLNAME,
    COLPOSITION,
    COLSEARCH,
    COLTITLE,
    COLTOP,
    COLTYPE,
    TABLENAME,
    GROUPNAME,
    GROUPLEFT,
    GROUPTOP,
    COLHIDE,
    COLHEIGHT,
    GETKEY,
    COLVALIDATE,
    TABLETITEL,
    COLLINK,
    COLREMARKS,
    SUCHFELD,
    TOOLTIPDEF) 
VALUES
(   /* LaufNr */        (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'TableColumn'),
    /* ImportNr */          0,    
    /* ErstelltAm */        { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */       '',    
    /* Geaendert  */        1,    
    /* Exportiert */        0,    
    /* GeaendertAm */       { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */      '',    
    /* COLALIGNMENT */      0,    
    /* COLDEC */            0,    
    /* COLDISPLAYLENGTH */  1275,    
    /* COLFIELDTYPE */      null,    
    /* COLFORMAT */         'NotVisible',    
    /* COLLEFT */           0,    
    /* COLLENGTH */         10,    
    /* COLNAME */           'Z_Datum',    
    /* COLPOSITION */       0,    
    /* COLSEARCH */         0,    
    /* COLTITLE */          'Datum',    
    /* COLTOP */            0,    
    /* COLTYPE */           'DATE',    
    /* TABLENAME */         'ADR_Adressen',    
    /* GROUPNAME */         null,    
    /* GROUPLEFT */         0,    
    /* GROUPTOP */          0,    
    /* COLHIDE */           1,    
    /* COLHEIGHT */         0,    
    /* GETKEY */            0,    
    /* COLVALIDATE */       null,    
    /* TABLETITEL */        'Adressen',    
    /* COLLINK */           null,    
    /* COLREMARKS */        'Zusatzfeld Datum',    
    /* SUCHFELD */          null,    
    /* TOOLTIPDEF */        'True')

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'TableColumn'

IF 
((    SELECT 
        COUNT(*) 
    FROM 
        USE_Rechte  
    WHERE 
        Modul     = 'PXZUSATZ' 
    AND 
        Form     = 'ADR_Adressen' 
    AND Menu     = 'OHNE') = 0)

BEGIN

    IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'USE_Rechte') = 0 
    BEGIN
        INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'USE_Rechte')
    END

    INSERT INTO 
        USE_Rechte
    (   LaufNr,
        ImportNr,
        ErstelltAm,
        ErstelltVon,
        Geaendert,
        Exportiert,
        GeaendertAm,
        GeaendertVon,
        Modul,
        Form,
        Menu,
        GruppeUSE,
        Recht) 
    VALUES
    (   /* LaufNr */    (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'USE_Rechte'),
        /* ImportNr */      0,   
        /* ErstelltAm */    { ts '2015-10-06 21:06:37'},  
        /* ErstelltVon */   '',
        /* Geaendert */     1,
        /* Exportiert */    0,
        /* GeaendertAm */   { ts '2015-10-06 21:06:37'},
        /* GeaendertVon */  '', 
        /* Modul */         'PXZUSATZ',
        /* Form */          'ADR_Adressen', 
        /* Menu */          'OHNE',
        /* GruppeUSE */     'ADMIN',
        /* Recht */         'S')

    UPDATE 
        LaufNummern 
    SET 
        LaufNr         = LaufNr + 1 
    WHERE 
        Tabelle     = 'USE_Rechte'

END


/*  
    Additional Field: Z_Geburtstag, Table: ADR_Adressen, Date: 19.10.2016  
*/

IF  EXISTS (SELECT 
        * 
    FROM 
        sys.objects        obj
    LEFT JOIN 
        sys.columns        col
    ON     
        obj.object_id      = col.object_id
    WHERE 
        obj.object_id      = OBJECT_ID(N'[dbo].[ADR_Adressen]') 
    AND    obj.type        IN (N'U')
    AND    col.name        = 'Z_Geburtstag')

BEGIN

    ALTER TABLE [dbo].[ADR_Adressen] DROP COLUMN [Z_Geburtstag]
    
    PRINT ''
    PRINT 'Z_Geburtstag: Additional field exists - overwritten!'
    
END

ALTER TABLE ADR_Adressen ADD Z_Geburtstag [datetime] NULL

DELETE FROM 
    Zusatzfelder 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Geburtstag'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'Zusatzfelder') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'Zusatzfelder')
END

INSERT INTO 
    Zusatzfelder
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    TableName,
    ColName,
    ColType,
    ColLength,
    ColDec,
    ColDefValue,
    ColZwang,
    ColPosition,
    ColTitle,
    ColSelection,
    ColGroup,
    ColLeft,
    ReadOnly) 
VALUES
(   /* LaufNr */    (    SELECT 
                             LaufNr + 1 
                         FROM 
                             LaufNummern 
                         WHERE 
                             Tabelle = 'Zusatzfelder'),    
    /* ImportNr */       0,    
    /* ErstelltAm */     { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */    '',    
    /* Geaendert */      1,    
    /* Exportiert */     0,    
    /* GeaendertAm */    { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */   '',    
    /* TableName */      'ADR_Adressen',
    /* ColName */        'Z_Geburtstag',
    /* ColType */        'pxTools.pxDate',
    /* ColLength */      10,
    /* ColDec */         0,
    /* ColDefValue */    null,
    /* ColZwang */       0,
    /* ColPosition */    8,
    /* ColTitle */       'Geburtstag',
    /* ColSelection */   null,
    /* ColGroup */       'Umbraco',
    /* ColLeft */        0,
    /* ReadOnly */       0)

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'Zusatzfelder'

DELETE FROM 
    TableColumn 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Geburtstag'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'TableColumn') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'TableColumn')
END

INSERT INTO 
    TableColumn
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    COLALIGNMENT,
    COLDEC,
    COLDISPLAYLENGTH,
    COLFIELDTYPE,
    COLFORMAT,
    COLLEFT,
    COLLENGTH,
    COLNAME,
    COLPOSITION,
    COLSEARCH,
    COLTITLE,
    COLTOP,
    COLTYPE,
    TABLENAME,
    GROUPNAME,
    GROUPLEFT,
    GROUPTOP,
    COLHIDE,
    COLHEIGHT,
    GETKEY,
    COLVALIDATE,
    TABLETITEL,
    COLLINK,
    COLREMARKS,
    SUCHFELD,
    TOOLTIPDEF) 
VALUES
(   /* LaufNr */        (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'TableColumn'),
    /* ImportNr */          0,    
    /* ErstelltAm */        { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */       '',    
    /* Geaendert  */        1,    
    /* Exportiert */        0,    
    /* GeaendertAm */       { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */      '',    
    /* COLALIGNMENT */      0,    
    /* COLDEC */            0,    
    /* COLDISPLAYLENGTH */  1275,    
    /* COLFIELDTYPE */      null,    
    /* COLFORMAT */         'NotVisible',    
    /* COLLEFT */           0,    
    /* COLLENGTH */         10,    
    /* COLNAME */           'Z_Geburtstag',    
    /* COLPOSITION */       0,    
    /* COLSEARCH */         0,    
    /* COLTITLE */          'Geburtstag',    
    /* COLTOP */            0,    
    /* COLTYPE */           'DATE',    
    /* TABLENAME */         'ADR_Adressen',    
    /* GROUPNAME */         null,    
    /* GROUPLEFT */         0,    
    /* GROUPTOP */          0,    
    /* COLHIDE */           1,    
    /* COLHEIGHT */         0,    
    /* GETKEY */            0,    
    /* COLVALIDATE */       null,    
    /* TABLETITEL */        'Adressen',    
    /* COLLINK */           null,    
    /* COLREMARKS */        'Zusatzfeld Geburtstag',    
    /* SUCHFELD */          null,    
    /* TOOLTIPDEF */        'True')

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'TableColumn'

IF 
((    SELECT 
        COUNT(*) 
    FROM 
        USE_Rechte  
    WHERE 
        Modul     = 'PXZUSATZ' 
    AND 
        Form     = 'ADR_Adressen' 
    AND Menu     = 'OHNE') = 0)

BEGIN

    IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'USE_Rechte') = 0 
    BEGIN
        INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'USE_Rechte')
    END

    INSERT INTO 
        USE_Rechte
    (   LaufNr,
        ImportNr,
        ErstelltAm,
        ErstelltVon,
        Geaendert,
        Exportiert,
        GeaendertAm,
        GeaendertVon,
        Modul,
        Form,
        Menu,
        GruppeUSE,
        Recht) 
    VALUES
    (   /* LaufNr */    (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'USE_Rechte'),
        /* ImportNr */      0,   
        /* ErstelltAm */    { ts '2015-10-06 21:06:37'},  
        /* ErstelltVon */   '',
        /* Geaendert */     1,
        /* Exportiert */    0,
        /* GeaendertAm */   { ts '2015-10-06 21:06:37'},
        /* GeaendertVon */  '', 
        /* Modul */         'PXZUSATZ',
        /* Form */          'ADR_Adressen', 
        /* Menu */          'OHNE',
        /* GruppeUSE */     'ADMIN',
        /* Recht */         'S')

    UPDATE 
        LaufNummern 
    SET 
        LaufNr         = LaufNr + 1 
    WHERE 
        Tabelle     = 'USE_Rechte'

END


/*  
    Additional Field: Z_Password, Table: ADR_Adressen, Date: 19.10.2016  
*/

IF  EXISTS (SELECT 
        * 
    FROM 
        sys.objects        obj
    LEFT JOIN 
        sys.columns        col
    ON     
        obj.object_id      = col.object_id
    WHERE 
        obj.object_id      = OBJECT_ID(N'[dbo].[ADR_Adressen]') 
    AND    obj.type        IN (N'U')
    AND    col.name        = 'Z_Password')

BEGIN

    ALTER TABLE [dbo].[ADR_Adressen] DROP COLUMN [Z_Password]
    
    PRINT ''
    PRINT 'Z_Password: Additional field exists - overwritten!'
    
END

ALTER TABLE ADR_Adressen ADD Z_Password [varchar](32) NULL

DELETE FROM 
    Zusatzfelder 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Password'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'Zusatzfelder') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'Zusatzfelder')
END

INSERT INTO 
    Zusatzfelder
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    TableName,
    ColName,
    ColType,
    ColLength,
    ColDec,
    ColDefValue,
    ColZwang,
    ColPosition,
    ColTitle,
    ColSelection,
    ColGroup,
    ColLeft,
    ReadOnly) 
VALUES
(   /* LaufNr */    (    SELECT 
                             LaufNr + 1 
                         FROM 
                             LaufNummern 
                         WHERE 
                             Tabelle = 'Zusatzfelder'),    
    /* ImportNr */       0,    
    /* ErstelltAm */     { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */    '',    
    /* Geaendert */      1,    
    /* Exportiert */     0,    
    /* GeaendertAm */    { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */   '',    
    /* TableName */      'ADR_Adressen',
    /* ColName */        'Z_Password',
    /* ColType */        'pxTools.pxText',
    /* ColLength */      32,
    /* ColDec */         0,
    /* ColDefValue */    null,
    /* ColZwang */       0,
    /* ColPosition */    3,
    /* ColTitle */       'Password',
    /* ColSelection */   null,
    /* ColGroup */       'Umbraco',
    /* ColLeft */        0,
    /* ReadOnly */       0)

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'Zusatzfelder'

DELETE FROM 
    TableColumn 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Password'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'TableColumn') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'TableColumn')
END

INSERT INTO 
    TableColumn
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    COLALIGNMENT,
    COLDEC,
    COLDISPLAYLENGTH,
    COLFIELDTYPE,
    COLFORMAT,
    COLLEFT,
    COLLENGTH,
    COLNAME,
    COLPOSITION,
    COLSEARCH,
    COLTITLE,
    COLTOP,
    COLTYPE,
    TABLENAME,
    GROUPNAME,
    GROUPLEFT,
    GROUPTOP,
    COLHIDE,
    COLHEIGHT,
    GETKEY,
    COLVALIDATE,
    TABLETITEL,
    COLLINK,
    COLREMARKS,
    SUCHFELD,
    TOOLTIPDEF) 
VALUES
(   /* LaufNr */        (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'TableColumn'),
    /* ImportNr */          0,    
    /* ErstelltAm */        { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */       '',    
    /* Geaendert  */        1,    
    /* Exportiert */        0,    
    /* GeaendertAm */       { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */      '',    
    /* COLALIGNMENT */      0,    
    /* COLDEC */            0,    
    /* COLDISPLAYLENGTH */  3150,    
    /* COLFIELDTYPE */      null,    
    /* COLFORMAT */         'NotVisible',    
    /* COLLEFT */           0,    
    /* COLLENGTH */         32,    
    /* COLNAME */           'Z_Password',    
    /* COLPOSITION */       0,    
    /* COLSEARCH */         0,    
    /* COLTITLE */          'Password',    
    /* COLTOP */            0,    
    /* COLTYPE */           'CHAR',    
    /* TABLENAME */         'ADR_Adressen',    
    /* GROUPNAME */         null,    
    /* GROUPLEFT */         0,    
    /* GROUPTOP */          0,    
    /* COLHIDE */           1,    
    /* COLHEIGHT */         0,    
    /* GETKEY */            0,    
    /* COLVALIDATE */       null,    
    /* TABLETITEL */        'Adressen',    
    /* COLLINK */           null,    
    /* COLREMARKS */        'Zusatzfeld Password',    
    /* SUCHFELD */          null,    
    /* TOOLTIPDEF */        'True')

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'TableColumn'

IF 
((    SELECT 
        COUNT(*) 
    FROM 
        USE_Rechte  
    WHERE 
        Modul     = 'PXZUSATZ' 
    AND 
        Form     = 'ADR_Adressen' 
    AND Menu     = 'OHNE') = 0)

BEGIN

    IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'USE_Rechte') = 0 
    BEGIN
        INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'USE_Rechte')
    END

    INSERT INTO 
        USE_Rechte
    (   LaufNr,
        ImportNr,
        ErstelltAm,
        ErstelltVon,
        Geaendert,
        Exportiert,
        GeaendertAm,
        GeaendertVon,
        Modul,
        Form,
        Menu,
        GruppeUSE,
        Recht) 
    VALUES
    (   /* LaufNr */    (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'USE_Rechte'),
        /* ImportNr */      0,   
        /* ErstelltAm */    { ts '2015-10-06 21:06:37'},  
        /* ErstelltVon */   '',
        /* Geaendert */     1,
        /* Exportiert */    0,
        /* GeaendertAm */   { ts '2015-10-06 21:06:37'},
        /* GeaendertVon */  '', 
        /* Modul */         'PXZUSATZ',
        /* Form */          'ADR_Adressen', 
        /* Menu */          'OHNE',
        /* GruppeUSE */     'ADMIN',
        /* Recht */         'S')

    UPDATE 
        LaufNummern 
    SET 
        LaufNr         = LaufNr + 1 
    WHERE 
        Tabelle     = 'USE_Rechte'

END


/*  
    Additional Field: Z_Proffix_Newsletter, Table: ADR_Adressen, Date: 19.10.2016  
*/

IF  EXISTS (SELECT 
        * 
    FROM 
        sys.objects        obj
    LEFT JOIN 
        sys.columns        col
    ON     
        obj.object_id      = col.object_id
    WHERE 
        obj.object_id      = OBJECT_ID(N'[dbo].[ADR_Adressen]') 
    AND    obj.type        IN (N'U')
    AND    col.name        = 'Z_Proffix_Newsletter')

BEGIN

    ALTER TABLE [dbo].[ADR_Adressen] DROP COLUMN [Z_Proffix_Newsletter]
    
    PRINT ''
    PRINT 'Z_Proffix_Newsletter: Additional field exists - overwritten!'
    
END

ALTER TABLE ADR_Adressen ADD Z_Proffix_Newsletter [smallint] NULL

DELETE FROM 
    Zusatzfelder 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Proffix_Newsletter'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'Zusatzfelder') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'Zusatzfelder')
END

INSERT INTO 
    Zusatzfelder
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    TableName,
    ColName,
    ColType,
    ColLength,
    ColDec,
    ColDefValue,
    ColZwang,
    ColPosition,
    ColTitle,
    ColSelection,
    ColGroup,
    ColLeft,
    ReadOnly) 
VALUES
(   /* LaufNr */    (    SELECT 
                             LaufNr + 1 
                         FROM 
                             LaufNummern 
                         WHERE 
                             Tabelle = 'Zusatzfelder'),    
    /* ImportNr */       0,    
    /* ErstelltAm */     { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */    '',    
    /* Geaendert */      1,    
    /* Exportiert */     0,    
    /* GeaendertAm */    { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */   '',    
    /* TableName */      'ADR_Adressen',
    /* ColName */        'Z_Proffix_Newsletter',
    /* ColType */        'pxTools.pxCheck',
    /* ColLength */      0,
    /* ColDec */         0,
    /* ColDefValue */    null,
    /* ColZwang */       0,
    /* ColPosition */    5,
    /* ColTitle */       'Proffix Newsletter',
    /* ColSelection */   null,
    /* ColGroup */       'Umbraco',
    /* ColLeft */        0,
    /* ReadOnly */       0)

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'Zusatzfelder'

DELETE FROM 
    TableColumn 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Proffix_Newsletter'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'TableColumn') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'TableColumn')
END

INSERT INTO 
    TableColumn
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    COLALIGNMENT,
    COLDEC,
    COLDISPLAYLENGTH,
    COLFIELDTYPE,
    COLFORMAT,
    COLLEFT,
    COLLENGTH,
    COLNAME,
    COLPOSITION,
    COLSEARCH,
    COLTITLE,
    COLTOP,
    COLTYPE,
    TABLENAME,
    GROUPNAME,
    GROUPLEFT,
    GROUPTOP,
    COLHIDE,
    COLHEIGHT,
    GETKEY,
    COLVALIDATE,
    TABLETITEL,
    COLLINK,
    COLREMARKS,
    SUCHFELD,
    TOOLTIPDEF) 
VALUES
(   /* LaufNr */        (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'TableColumn'),
    /* ImportNr */          0,    
    /* ErstelltAm */        { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */       '',    
    /* Geaendert  */        1,    
    /* Exportiert */        0,    
    /* GeaendertAm */       { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */      '',    
    /* COLALIGNMENT */      1,    
    /* COLDEC */            0,    
    /* COLDISPLAYLENGTH */  3150,    
    /* COLFIELDTYPE */      'CheckBox',    
    /* COLFORMAT */         'NotVisible',    
    /* COLLEFT */           0,    
    /* COLLENGTH */         0,    
    /* COLNAME */           'Z_Proffix_Newsletter',    
    /* COLPOSITION */       0,    
    /* COLSEARCH */         0,    
    /* COLTITLE */          'Proffix Newsletter',    
    /* COLTOP */            0,    
    /* COLTYPE */           'INT',    
    /* TABLENAME */         'ADR_Adressen',    
    /* GROUPNAME */         null,    
    /* GROUPLEFT */         0,    
    /* GROUPTOP */          0,    
    /* COLHIDE */           1,    
    /* COLHEIGHT */         0,    
    /* GETKEY */            0,    
    /* COLVALIDATE */       null,    
    /* TABLETITEL */        'Adressen',    
    /* COLLINK */           null,    
    /* COLREMARKS */        'Zusatzfeld Proffix Newsletter',    
    /* SUCHFELD */          null,    
    /* TOOLTIPDEF */        'True')

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'TableColumn'

IF 
((    SELECT 
        COUNT(*) 
    FROM 
        USE_Rechte  
    WHERE 
        Modul     = 'PXZUSATZ' 
    AND 
        Form     = 'ADR_Adressen' 
    AND Menu     = 'OHNE') = 0)

BEGIN

    IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'USE_Rechte') = 0 
    BEGIN
        INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'USE_Rechte')
    END

    INSERT INTO 
        USE_Rechte
    (   LaufNr,
        ImportNr,
        ErstelltAm,
        ErstelltVon,
        Geaendert,
        Exportiert,
        GeaendertAm,
        GeaendertVon,
        Modul,
        Form,
        Menu,
        GruppeUSE,
        Recht) 
    VALUES
    (   /* LaufNr */    (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'USE_Rechte'),
        /* ImportNr */      0,   
        /* ErstelltAm */    { ts '2015-10-06 21:06:37'},  
        /* ErstelltVon */   '',
        /* Geaendert */     1,
        /* Exportiert */    0,
        /* GeaendertAm */   { ts '2015-10-06 21:06:37'},
        /* GeaendertVon */  '', 
        /* Modul */         'PXZUSATZ',
        /* Form */          'ADR_Adressen', 
        /* Menu */          'OHNE',
        /* GruppeUSE */     'ADMIN',
        /* Recht */         'S')

    UPDATE 
        LaufNummern 
    SET 
        LaufNr         = LaufNr + 1 
    WHERE 
        Tabelle     = 'USE_Rechte'

END


/*  
    Additional Field: Z_Topal_Newsletter, Table: ADR_Adressen, Date: 19.10.2016  
*/

IF  EXISTS (SELECT 
        * 
    FROM 
        sys.objects        obj
    LEFT JOIN 
        sys.columns        col
    ON     
        obj.object_id      = col.object_id
    WHERE 
        obj.object_id      = OBJECT_ID(N'[dbo].[ADR_Adressen]') 
    AND    obj.type        IN (N'U')
    AND    col.name        = 'Z_Topal_Newsletter')

BEGIN

    ALTER TABLE [dbo].[ADR_Adressen] DROP COLUMN [Z_Topal_Newsletter]
    
    PRINT ''
    PRINT 'Z_Topal_Newsletter: Additional field exists - overwritten!'
    
END

ALTER TABLE ADR_Adressen ADD Z_Topal_Newsletter [smallint] NULL

DELETE FROM 
    Zusatzfelder 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Topal_Newsletter'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'Zusatzfelder') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'Zusatzfelder')
END

INSERT INTO 
    Zusatzfelder
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    TableName,
    ColName,
    ColType,
    ColLength,
    ColDec,
    ColDefValue,
    ColZwang,
    ColPosition,
    ColTitle,
    ColSelection,
    ColGroup,
    ColLeft,
    ReadOnly) 
VALUES
(   /* LaufNr */    (    SELECT 
                             LaufNr + 1 
                         FROM 
                             LaufNummern 
                         WHERE 
                             Tabelle = 'Zusatzfelder'),    
    /* ImportNr */       0,    
    /* ErstelltAm */     { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */    '',    
    /* Geaendert */      1,    
    /* Exportiert */     0,    
    /* GeaendertAm */    { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */   '',    
    /* TableName */      'ADR_Adressen',
    /* ColName */        'Z_Topal_Newsletter',
    /* ColType */        'pxTools.pxCheck',
    /* ColLength */      0,
    /* ColDec */         0,
    /* ColDefValue */    null,
    /* ColZwang */       0,
    /* ColPosition */    6,
    /* ColTitle */       'Topal_Newsletter',
    /* ColSelection */   null,
    /* ColGroup */       'Umbraco',
    /* ColLeft */        0,
    /* ReadOnly */       0)

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'Zusatzfelder'

DELETE FROM 
    TableColumn 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Topal_Newsletter'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'TableColumn') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'TableColumn')
END

INSERT INTO 
    TableColumn
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    COLALIGNMENT,
    COLDEC,
    COLDISPLAYLENGTH,
    COLFIELDTYPE,
    COLFORMAT,
    COLLEFT,
    COLLENGTH,
    COLNAME,
    COLPOSITION,
    COLSEARCH,
    COLTITLE,
    COLTOP,
    COLTYPE,
    TABLENAME,
    GROUPNAME,
    GROUPLEFT,
    GROUPTOP,
    COLHIDE,
    COLHEIGHT,
    GETKEY,
    COLVALIDATE,
    TABLETITEL,
    COLLINK,
    COLREMARKS,
    SUCHFELD,
    TOOLTIPDEF) 
VALUES
(   /* LaufNr */        (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'TableColumn'),
    /* ImportNr */          0,    
    /* ErstelltAm */        { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */       '',    
    /* Geaendert  */        1,    
    /* Exportiert */        0,    
    /* GeaendertAm */       { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */      '',    
    /* COLALIGNMENT */      1,    
    /* COLDEC */            0,    
    /* COLDISPLAYLENGTH */  3150,    
    /* COLFIELDTYPE */      'CheckBox',    
    /* COLFORMAT */         'NotVisible',    
    /* COLLEFT */           0,    
    /* COLLENGTH */         0,    
    /* COLNAME */           'Z_Topal_Newsletter',    
    /* COLPOSITION */       0,    
    /* COLSEARCH */         0,    
    /* COLTITLE */          'Topal_Newsletter',    
    /* COLTOP */            0,    
    /* COLTYPE */           'INT',    
    /* TABLENAME */         'ADR_Adressen',    
    /* GROUPNAME */         null,    
    /* GROUPLEFT */         0,    
    /* GROUPTOP */          0,    
    /* COLHIDE */           1,    
    /* COLHEIGHT */         0,    
    /* GETKEY */            0,    
    /* COLVALIDATE */       null,    
    /* TABLETITEL */        'Adressen',    
    /* COLLINK */           null,    
    /* COLREMARKS */        'Zusatzfeld Topal_Newsletter',    
    /* SUCHFELD */          null,    
    /* TOOLTIPDEF */        'True')

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'TableColumn'

IF 
((    SELECT 
        COUNT(*) 
    FROM 
        USE_Rechte  
    WHERE 
        Modul     = 'PXZUSATZ' 
    AND 
        Form     = 'ADR_Adressen' 
    AND Menu     = 'OHNE') = 0)

BEGIN

    IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'USE_Rechte') = 0 
    BEGIN
        INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'USE_Rechte')
    END

    INSERT INTO 
        USE_Rechte
    (   LaufNr,
        ImportNr,
        ErstelltAm,
        ErstelltVon,
        Geaendert,
        Exportiert,
        GeaendertAm,
        GeaendertVon,
        Modul,
        Form,
        Menu,
        GruppeUSE,
        Recht) 
    VALUES
    (   /* LaufNr */    (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'USE_Rechte'),
        /* ImportNr */      0,   
        /* ErstelltAm */    { ts '2015-10-06 21:06:37'},  
        /* ErstelltVon */   '',
        /* Geaendert */     1,
        /* Exportiert */    0,
        /* GeaendertAm */   { ts '2015-10-06 21:06:37'},
        /* GeaendertVon */  '', 
        /* Modul */         'PXZUSATZ',
        /* Form */          'ADR_Adressen', 
        /* Menu */          'OHNE',
        /* GruppeUSE */     'ADMIN',
        /* Recht */         'S')

    UPDATE 
        LaufNummern 
    SET 
        LaufNr         = LaufNr + 1 
    WHERE 
        Tabelle     = 'USE_Rechte'

END


/*  
    Additional Field: Z_TranferToUmbraco, Table: ADR_Adressen, Date: 19.10.2016  
*/

IF  EXISTS (SELECT 
        * 
    FROM 
        sys.objects        obj
    LEFT JOIN 
        sys.columns        col
    ON     
        obj.object_id      = col.object_id
    WHERE 
        obj.object_id      = OBJECT_ID(N'[dbo].[ADR_Adressen]') 
    AND    obj.type        IN (N'U')
    AND    col.name        = 'Z_TranferToUmbraco')

BEGIN

    ALTER TABLE [dbo].[ADR_Adressen] DROP COLUMN [Z_TranferToUmbraco]
    
    PRINT ''
    PRINT 'Z_TranferToUmbraco: Additional field exists - overwritten!'
    
END

ALTER TABLE ADR_Adressen ADD Z_TranferToUmbraco [smallint] NULL

DELETE FROM 
    Zusatzfelder 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_TranferToUmbraco'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'Zusatzfelder') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'Zusatzfelder')
END

INSERT INTO 
    Zusatzfelder
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    TableName,
    ColName,
    ColType,
    ColLength,
    ColDec,
    ColDefValue,
    ColZwang,
    ColPosition,
    ColTitle,
    ColSelection,
    ColGroup,
    ColLeft,
    ReadOnly) 
VALUES
(   /* LaufNr */    (    SELECT 
                             LaufNr + 1 
                         FROM 
                             LaufNummern 
                         WHERE 
                             Tabelle = 'Zusatzfelder'),    
    /* ImportNr */       0,    
    /* ErstelltAm */     { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */    '',    
    /* Geaendert */      1,    
    /* Exportiert */     0,    
    /* GeaendertAm */    { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */   '',    
    /* TableName */      'ADR_Adressen',
    /* ColName */        'Z_TranferToUmbraco',
    /* ColType */        'pxTools.pxCheck',
    /* ColLength */      0,
    /* ColDec */         0,
    /* ColDefValue */    null,
    /* ColZwang */       0,
    /* ColPosition */    1,
    /* ColTitle */       'Nach Umbtaco übertragen',
    /* ColSelection */   null,
    /* ColGroup */       'Umbraco',
    /* ColLeft */        0,
    /* ReadOnly */       0)

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'Zusatzfelder'

DELETE FROM 
    TableColumn 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_TranferToUmbraco'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'TableColumn') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'TableColumn')
END

INSERT INTO 
    TableColumn
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    COLALIGNMENT,
    COLDEC,
    COLDISPLAYLENGTH,
    COLFIELDTYPE,
    COLFORMAT,
    COLLEFT,
    COLLENGTH,
    COLNAME,
    COLPOSITION,
    COLSEARCH,
    COLTITLE,
    COLTOP,
    COLTYPE,
    TABLENAME,
    GROUPNAME,
    GROUPLEFT,
    GROUPTOP,
    COLHIDE,
    COLHEIGHT,
    GETKEY,
    COLVALIDATE,
    TABLETITEL,
    COLLINK,
    COLREMARKS,
    SUCHFELD,
    TOOLTIPDEF) 
VALUES
(   /* LaufNr */        (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'TableColumn'),
    /* ImportNr */          0,    
    /* ErstelltAm */        { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */       '',    
    /* Geaendert  */        1,    
    /* Exportiert */        0,    
    /* GeaendertAm */       { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */      '',    
    /* COLALIGNMENT */      1,    
    /* COLDEC */            0,    
    /* COLDISPLAYLENGTH */  3150,    
    /* COLFIELDTYPE */      'CheckBox',    
    /* COLFORMAT */         'NotVisible',    
    /* COLLEFT */           0,    
    /* COLLENGTH */         0,    
    /* COLNAME */           'Z_TranferToUmbraco',    
    /* COLPOSITION */       0,    
    /* COLSEARCH */         0,    
    /* COLTITLE */          'Nach Umbtaco übertragen',    
    /* COLTOP */            0,    
    /* COLTYPE */           'INT',    
    /* TABLENAME */         'ADR_Adressen',    
    /* GROUPNAME */         null,    
    /* GROUPLEFT */         0,    
    /* GROUPTOP */          0,    
    /* COLHIDE */           1,    
    /* COLHEIGHT */         0,    
    /* GETKEY */            0,    
    /* COLVALIDATE */       null,    
    /* TABLETITEL */        'Adressen',    
    /* COLLINK */           null,    
    /* COLREMARKS */        'Zusatzfeld Nach Umbtaco übertragen',    
    /* SUCHFELD */          null,    
    /* TOOLTIPDEF */        'True')

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'TableColumn'

IF 
((    SELECT 
        COUNT(*) 
    FROM 
        USE_Rechte  
    WHERE 
        Modul     = 'PXZUSATZ' 
    AND 
        Form     = 'ADR_Adressen' 
    AND Menu     = 'OHNE') = 0)

BEGIN

    IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'USE_Rechte') = 0 
    BEGIN
        INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'USE_Rechte')
    END

    INSERT INTO 
        USE_Rechte
    (   LaufNr,
        ImportNr,
        ErstelltAm,
        ErstelltVon,
        Geaendert,
        Exportiert,
        GeaendertAm,
        GeaendertVon,
        Modul,
        Form,
        Menu,
        GruppeUSE,
        Recht) 
    VALUES
    (   /* LaufNr */    (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'USE_Rechte'),
        /* ImportNr */      0,   
        /* ErstelltAm */    { ts '2015-10-06 21:06:37'},  
        /* ErstelltVon */   '',
        /* Geaendert */     1,
        /* Exportiert */    0,
        /* GeaendertAm */   { ts '2015-10-06 21:06:37'},
        /* GeaendertVon */  '', 
        /* Modul */         'PXZUSATZ',
        /* Form */          'ADR_Adressen', 
        /* Menu */          'OHNE',
        /* GruppeUSE */     'ADMIN',
        /* Recht */         'S')

    UPDATE 
        LaufNummern 
    SET 
        LaufNr         = LaufNr + 1 
    WHERE 
        Tabelle     = 'USE_Rechte'

END


/*  
    Additional Field: Z_Umbraco_Id, Table: ADR_Adressen, Date: 19.10.2016  
*/

IF  EXISTS (SELECT 
        * 
    FROM 
        sys.objects        obj
    LEFT JOIN 
        sys.columns        col
    ON     
        obj.object_id      = col.object_id
    WHERE 
        obj.object_id      = OBJECT_ID(N'[dbo].[ADR_Adressen]') 
    AND    obj.type        IN (N'U')
    AND    col.name        = 'Z_Umbraco_Id')

BEGIN

    ALTER TABLE [dbo].[ADR_Adressen] DROP COLUMN [Z_Umbraco_Id]
    
    PRINT ''
    PRINT 'Z_Umbraco_Id: Additional field exists - overwritten!'
    
END

ALTER TABLE ADR_Adressen ADD Z_Umbraco_Id [int] NULL

DELETE FROM 
    Zusatzfelder 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Umbraco_Id'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'Zusatzfelder') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'Zusatzfelder')
END

INSERT INTO 
    Zusatzfelder
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    TableName,
    ColName,
    ColType,
    ColLength,
    ColDec,
    ColDefValue,
    ColZwang,
    ColPosition,
    ColTitle,
    ColSelection,
    ColGroup,
    ColLeft,
    ReadOnly) 
VALUES
(   /* LaufNr */    (    SELECT 
                             LaufNr + 1 
                         FROM 
                             LaufNummern 
                         WHERE 
                             Tabelle = 'Zusatzfelder'),    
    /* ImportNr */       0,    
    /* ErstelltAm */     { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */    '',    
    /* Geaendert */      1,    
    /* Exportiert */     0,    
    /* GeaendertAm */    { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */   '',    
    /* TableName */      'ADR_Adressen',
    /* ColName */        'Z_Umbraco_Id',
    /* ColType */        'pxTools.pxNumberLong',
    /* ColLength */      6,
    /* ColDec */         0,
    /* ColDefValue */    null,
    /* ColZwang */       0,
    /* ColPosition */    2,
    /* ColTitle */       'Umbraco Id',
    /* ColSelection */   null,
    /* ColGroup */       'Umbraco',
    /* ColLeft */        0,
    /* ReadOnly */       0)

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'Zusatzfelder'

DELETE FROM 
    TableColumn 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Umbraco_Id'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'TableColumn') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'TableColumn')
END

INSERT INTO 
    TableColumn
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    COLALIGNMENT,
    COLDEC,
    COLDISPLAYLENGTH,
    COLFIELDTYPE,
    COLFORMAT,
    COLLEFT,
    COLLENGTH,
    COLNAME,
    COLPOSITION,
    COLSEARCH,
    COLTITLE,
    COLTOP,
    COLTYPE,
    TABLENAME,
    GROUPNAME,
    GROUPLEFT,
    GROUPTOP,
    COLHIDE,
    COLHEIGHT,
    GETKEY,
    COLVALIDATE,
    TABLETITEL,
    COLLINK,
    COLREMARKS,
    SUCHFELD,
    TOOLTIPDEF) 
VALUES
(   /* LaufNr */        (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'TableColumn'),
    /* ImportNr */          0,    
    /* ErstelltAm */        { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */       '',    
    /* Geaendert  */        1,    
    /* Exportiert */        0,    
    /* GeaendertAm */       { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */      '',    
    /* COLALIGNMENT */      1,    
    /* COLDEC */            0,    
    /* COLDISPLAYLENGTH */  1500,    
    /* COLFIELDTYPE */      null,    
    /* COLFORMAT */         'NotVisible',    
    /* COLLEFT */           0,    
    /* COLLENGTH */         6,    
    /* COLNAME */           'Z_Umbraco_Id',    
    /* COLPOSITION */       0,    
    /* COLSEARCH */         0,    
    /* COLTITLE */          'Umbraco Id',    
    /* COLTOP */            0,    
    /* COLTYPE */           'INT',    
    /* TABLENAME */         'ADR_Adressen',    
    /* GROUPNAME */         null,    
    /* GROUPLEFT */         0,    
    /* GROUPTOP */          0,    
    /* COLHIDE */           1,    
    /* COLHEIGHT */         0,    
    /* GETKEY */            0,    
    /* COLVALIDATE */       null,    
    /* TABLETITEL */        'Adressen',    
    /* COLLINK */           null,    
    /* COLREMARKS */        'Zusatzfeld Umbraco Id',    
    /* SUCHFELD */          null,    
    /* TOOLTIPDEF */        'True')

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'TableColumn'

IF 
((    SELECT 
        COUNT(*) 
    FROM 
        USE_Rechte  
    WHERE 
        Modul     = 'PXZUSATZ' 
    AND 
        Form     = 'ADR_Adressen' 
    AND Menu     = 'OHNE') = 0)

BEGIN

    IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'USE_Rechte') = 0 
    BEGIN
        INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'USE_Rechte')
    END

    INSERT INTO 
        USE_Rechte
    (   LaufNr,
        ImportNr,
        ErstelltAm,
        ErstelltVon,
        Geaendert,
        Exportiert,
        GeaendertAm,
        GeaendertVon,
        Modul,
        Form,
        Menu,
        GruppeUSE,
        Recht) 
    VALUES
    (   /* LaufNr */    (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'USE_Rechte'),
        /* ImportNr */      0,   
        /* ErstelltAm */    { ts '2015-10-06 21:06:37'},  
        /* ErstelltVon */   '',
        /* Geaendert */     1,
        /* Exportiert */    0,
        /* GeaendertAm */   { ts '2015-10-06 21:06:37'},
        /* GeaendertVon */  '', 
        /* Modul */         'PXZUSATZ',
        /* Form */          'ADR_Adressen', 
        /* Menu */          'OHNE',
        /* GruppeUSE */     'ADMIN',
        /* Recht */         'S')

    UPDATE 
        LaufNummern 
    SET 
        LaufNr         = LaufNr + 1 
    WHERE 
        Tabelle     = 'USE_Rechte'

END


/*  
    Additional Field: Z_Workbooster_Newsletter, Table: ADR_Adressen, Date: 19.10.2016  
*/

IF  EXISTS (SELECT 
        * 
    FROM 
        sys.objects        obj
    LEFT JOIN 
        sys.columns        col
    ON     
        obj.object_id      = col.object_id
    WHERE 
        obj.object_id      = OBJECT_ID(N'[dbo].[ADR_Adressen]') 
    AND    obj.type        IN (N'U')
    AND    col.name        = 'Z_Workbooster_Newsletter')

BEGIN

    ALTER TABLE [dbo].[ADR_Adressen] DROP COLUMN [Z_Workbooster_Newsletter]
    
    PRINT ''
    PRINT 'Z_Workbooster_Newsletter: Additional field exists - overwritten!'
    
END

ALTER TABLE ADR_Adressen ADD Z_Workbooster_Newsletter [smallint] NULL

DELETE FROM 
    Zusatzfelder 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Workbooster_Newsletter'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'Zusatzfelder') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'Zusatzfelder')
END

INSERT INTO 
    Zusatzfelder
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    TableName,
    ColName,
    ColType,
    ColLength,
    ColDec,
    ColDefValue,
    ColZwang,
    ColPosition,
    ColTitle,
    ColSelection,
    ColGroup,
    ColLeft,
    ReadOnly) 
VALUES
(   /* LaufNr */    (    SELECT 
                             LaufNr + 1 
                         FROM 
                             LaufNummern 
                         WHERE 
                             Tabelle = 'Zusatzfelder'),    
    /* ImportNr */       0,    
    /* ErstelltAm */     { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */    '',    
    /* Geaendert */      1,    
    /* Exportiert */     0,    
    /* GeaendertAm */    { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */   '',    
    /* TableName */      'ADR_Adressen',
    /* ColName */        'Z_Workbooster_Newsletter',
    /* ColType */        'pxTools.pxCheck',
    /* ColLength */      0,
    /* ColDec */         0,
    /* ColDefValue */    null,
    /* ColZwang */       0,
    /* ColPosition */    4,
    /* ColTitle */       'Workbooster_Newsletter',
    /* ColSelection */   null,
    /* ColGroup */       'Umbraco',
    /* ColLeft */        0,
    /* ReadOnly */       0)

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'Zusatzfelder'

DELETE FROM 
    TableColumn 
WHERE 
    TableName    = 'ADR_Adressen'
AND ColName      = 'Z_Workbooster_Newsletter'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'TableColumn') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'TableColumn')
END

INSERT INTO 
    TableColumn
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    COLALIGNMENT,
    COLDEC,
    COLDISPLAYLENGTH,
    COLFIELDTYPE,
    COLFORMAT,
    COLLEFT,
    COLLENGTH,
    COLNAME,
    COLPOSITION,
    COLSEARCH,
    COLTITLE,
    COLTOP,
    COLTYPE,
    TABLENAME,
    GROUPNAME,
    GROUPLEFT,
    GROUPTOP,
    COLHIDE,
    COLHEIGHT,
    GETKEY,
    COLVALIDATE,
    TABLETITEL,
    COLLINK,
    COLREMARKS,
    SUCHFELD,
    TOOLTIPDEF) 
VALUES
(   /* LaufNr */        (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'TableColumn'),
    /* ImportNr */          0,    
    /* ErstelltAm */        { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */       '',    
    /* Geaendert  */        1,    
    /* Exportiert */        0,    
    /* GeaendertAm */       { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */      '',    
    /* COLALIGNMENT */      1,    
    /* COLDEC */            0,    
    /* COLDISPLAYLENGTH */  3150,    
    /* COLFIELDTYPE */      'CheckBox',    
    /* COLFORMAT */         'NotVisible',    
    /* COLLEFT */           0,    
    /* COLLENGTH */         0,    
    /* COLNAME */           'Z_Workbooster_Newsletter',    
    /* COLPOSITION */       0,    
    /* COLSEARCH */         0,    
    /* COLTITLE */          'Workbooster_Newsletter',    
    /* COLTOP */            0,    
    /* COLTYPE */           'INT',    
    /* TABLENAME */         'ADR_Adressen',    
    /* GROUPNAME */         null,    
    /* GROUPLEFT */         0,    
    /* GROUPTOP */          0,    
    /* COLHIDE */           1,    
    /* COLHEIGHT */         0,    
    /* GETKEY */            0,    
    /* COLVALIDATE */       null,    
    /* TABLETITEL */        'Adressen',    
    /* COLLINK */           null,    
    /* COLREMARKS */        'Zusatzfeld Workbooster_Newsletter',    
    /* SUCHFELD */          null,    
    /* TOOLTIPDEF */        'True')

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'TableColumn'

IF 
((    SELECT 
        COUNT(*) 
    FROM 
        USE_Rechte  
    WHERE 
        Modul     = 'PXZUSATZ' 
    AND 
        Form     = 'ADR_Adressen' 
    AND Menu     = 'OHNE') = 0)

BEGIN

    IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'USE_Rechte') = 0 
    BEGIN
        INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'USE_Rechte')
    END

    INSERT INTO 
        USE_Rechte
    (   LaufNr,
        ImportNr,
        ErstelltAm,
        ErstelltVon,
        Geaendert,
        Exportiert,
        GeaendertAm,
        GeaendertVon,
        Modul,
        Form,
        Menu,
        GruppeUSE,
        Recht) 
    VALUES
    (   /* LaufNr */    (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'USE_Rechte'),
        /* ImportNr */      0,   
        /* ErstelltAm */    { ts '2015-10-06 21:06:37'},  
        /* ErstelltVon */   '',
        /* Geaendert */     1,
        /* Exportiert */    0,
        /* GeaendertAm */   { ts '2015-10-06 21:06:37'},
        /* GeaendertVon */  '', 
        /* Modul */         'PXZUSATZ',
        /* Form */          'ADR_Adressen', 
        /* Menu */          'OHNE',
        /* GruppeUSE */     'ADMIN',
        /* Recht */         'S')

    UPDATE 
        LaufNummern 
    SET 
        LaufNr         = LaufNr + 1 
    WHERE 
        Tabelle     = 'USE_Rechte'

END


/*  
    Additional Field: Z_TranferToUmbraco, Table: AUF_Dokumente, Date: 19.10.2016  
*/

IF  EXISTS (SELECT 
        * 
    FROM 
        sys.objects        obj
    LEFT JOIN 
        sys.columns        col
    ON     
        obj.object_id      = col.object_id
    WHERE 
        obj.object_id      = OBJECT_ID(N'[dbo].[AUF_Dokumente]') 
    AND    obj.type        IN (N'U')
    AND    col.name        = 'Z_TranferToUmbraco')

BEGIN

    ALTER TABLE [dbo].[AUF_Dokumente] DROP COLUMN [Z_TranferToUmbraco]
    
    PRINT ''
    PRINT 'Z_TranferToUmbraco: Additional field exists - overwritten!'
    
END

ALTER TABLE AUF_Dokumente ADD Z_TranferToUmbraco [smallint] NULL

DELETE FROM 
    Zusatzfelder 
WHERE 
    TableName    = 'AUF_Dokumente'
AND ColName      = 'Z_TranferToUmbraco'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'Zusatzfelder') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'Zusatzfelder')
END

INSERT INTO 
    Zusatzfelder
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    TableName,
    ColName,
    ColType,
    ColLength,
    ColDec,
    ColDefValue,
    ColZwang,
    ColPosition,
    ColTitle,
    ColSelection,
    ColGroup,
    ColLeft,
    ReadOnly) 
VALUES
(   /* LaufNr */    (    SELECT 
                             LaufNr + 1 
                         FROM 
                             LaufNummern 
                         WHERE 
                             Tabelle = 'Zusatzfelder'),    
    /* ImportNr */       0,    
    /* ErstelltAm */     { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */    '',    
    /* Geaendert */      1,    
    /* Exportiert */     0,    
    /* GeaendertAm */    { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */   '',    
    /* TableName */      'AUF_Dokumente',
    /* ColName */        'Z_TranferToUmbraco',
    /* ColType */        'pxTools.pxCheck',
    /* ColLength */      0,
    /* ColDec */         0,
    /* ColDefValue */    null,
    /* ColZwang */       0,
    /* ColPosition */    2,
    /* ColTitle */       'Nach Umbtaco übertragen',
    /* ColSelection */   null,
    /* ColGroup */       'Umbraco',
    /* ColLeft */        0,
    /* ReadOnly */       0)

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'Zusatzfelder'

DELETE FROM 
    TableColumn 
WHERE 
    TableName    = 'AUF_Dokumente'
AND ColName      = 'Z_TranferToUmbraco'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'TableColumn') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'TableColumn')
END

INSERT INTO 
    TableColumn
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    COLALIGNMENT,
    COLDEC,
    COLDISPLAYLENGTH,
    COLFIELDTYPE,
    COLFORMAT,
    COLLEFT,
    COLLENGTH,
    COLNAME,
    COLPOSITION,
    COLSEARCH,
    COLTITLE,
    COLTOP,
    COLTYPE,
    TABLENAME,
    GROUPNAME,
    GROUPLEFT,
    GROUPTOP,
    COLHIDE,
    COLHEIGHT,
    GETKEY,
    COLVALIDATE,
    TABLETITEL,
    COLLINK,
    COLREMARKS,
    SUCHFELD,
    TOOLTIPDEF) 
VALUES
(   /* LaufNr */        (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'TableColumn'),
    /* ImportNr */          0,    
    /* ErstelltAm */        { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */       '',    
    /* Geaendert  */        1,    
    /* Exportiert */        0,    
    /* GeaendertAm */       { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */      '',    
    /* COLALIGNMENT */      1,    
    /* COLDEC */            0,    
    /* COLDISPLAYLENGTH */  3150,    
    /* COLFIELDTYPE */      'CheckBox',    
    /* COLFORMAT */         'NotVisible',    
    /* COLLEFT */           0,    
    /* COLLENGTH */         0,    
    /* COLNAME */           'Z_TranferToUmbraco',    
    /* COLPOSITION */       0,    
    /* COLSEARCH */         0,    
    /* COLTITLE */          'Nach Umbtaco übertragen',    
    /* COLTOP */            0,    
    /* COLTYPE */           'INT',    
    /* TABLENAME */         'AUF_Dokumente',    
    /* GROUPNAME */         null,    
    /* GROUPLEFT */         0,    
    /* GROUPTOP */          0,    
    /* COLHIDE */           1,    
    /* COLHEIGHT */         0,    
    /* GETKEY */            0,    
    /* COLVALIDATE */       null,    
    /* TABLETITEL */        'Dokumente Auftrag',    
    /* COLLINK */           null,    
    /* COLREMARKS */        'Zusatzfeld Nach Umbtaco übertragen',    
    /* SUCHFELD */          null,    
    /* TOOLTIPDEF */        'True')

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'TableColumn'

IF 
((    SELECT 
        COUNT(*) 
    FROM 
        USE_Rechte  
    WHERE 
        Modul     = 'PXZUSATZ' 
    AND 
        Form     = 'AUF_Dokumente' 
    AND Menu     = 'OHNE') = 0)

BEGIN

    IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'USE_Rechte') = 0 
    BEGIN
        INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'USE_Rechte')
    END

    INSERT INTO 
        USE_Rechte
    (   LaufNr,
        ImportNr,
        ErstelltAm,
        ErstelltVon,
        Geaendert,
        Exportiert,
        GeaendertAm,
        GeaendertVon,
        Modul,
        Form,
        Menu,
        GruppeUSE,
        Recht) 
    VALUES
    (   /* LaufNr */    (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'USE_Rechte'),
        /* ImportNr */      0,   
        /* ErstelltAm */    { ts '2015-10-06 21:06:37'},  
        /* ErstelltVon */   '',
        /* Geaendert */     1,
        /* Exportiert */    0,
        /* GeaendertAm */   { ts '2015-10-06 21:06:37'},
        /* GeaendertVon */  '', 
        /* Modul */         'PXZUSATZ',
        /* Form */          'ADR_Adressen', 
        /* Menu */          'OHNE',
        /* GruppeUSE */     'ADMIN',
        /* Recht */         'S')

    UPDATE 
        LaufNummern 
    SET 
        LaufNr         = LaufNr + 1 
    WHERE 
        Tabelle     = 'USE_Rechte'

END


/*  
    Additional Field: Z_Umbraco_Id, Table: AUF_Dokumente, Date: 19.10.2016  
*/

IF  EXISTS (SELECT 
        * 
    FROM 
        sys.objects        obj
    LEFT JOIN 
        sys.columns        col
    ON     
        obj.object_id      = col.object_id
    WHERE 
        obj.object_id      = OBJECT_ID(N'[dbo].[AUF_Dokumente]') 
    AND    obj.type        IN (N'U')
    AND    col.name        = 'Z_Umbraco_Id')

BEGIN

    ALTER TABLE [dbo].[AUF_Dokumente] DROP COLUMN [Z_Umbraco_Id]
    
    PRINT ''
    PRINT 'Z_Umbraco_Id: Additional field exists - overwritten!'
    
END

ALTER TABLE AUF_Dokumente ADD Z_Umbraco_Id [int] NULL

DELETE FROM 
    Zusatzfelder 
WHERE 
    TableName    = 'AUF_Dokumente'
AND ColName      = 'Z_Umbraco_Id'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'Zusatzfelder') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'Zusatzfelder')
END

INSERT INTO 
    Zusatzfelder
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    TableName,
    ColName,
    ColType,
    ColLength,
    ColDec,
    ColDefValue,
    ColZwang,
    ColPosition,
    ColTitle,
    ColSelection,
    ColGroup,
    ColLeft,
    ReadOnly) 
VALUES
(   /* LaufNr */    (    SELECT 
                             LaufNr + 1 
                         FROM 
                             LaufNummern 
                         WHERE 
                             Tabelle = 'Zusatzfelder'),    
    /* ImportNr */       0,    
    /* ErstelltAm */     { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */    '',    
    /* Geaendert */      1,    
    /* Exportiert */     0,    
    /* GeaendertAm */    { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */   '',    
    /* TableName */      'AUF_Dokumente',
    /* ColName */        'Z_Umbraco_Id',
    /* ColType */        'pxTools.pxNumberLong',
    /* ColLength */      6,
    /* ColDec */         0,
    /* ColDefValue */    null,
    /* ColZwang */       0,
    /* ColPosition */    1,
    /* ColTitle */       'Umbraco_Id',
    /* ColSelection */   null,
    /* ColGroup */       'Umbraco',
    /* ColLeft */        0,
    /* ReadOnly */       0)

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'Zusatzfelder'

DELETE FROM 
    TableColumn 
WHERE 
    TableName    = 'AUF_Dokumente'
AND ColName      = 'Z_Umbraco_Id'

IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'TableColumn') = 0 
BEGIN
    INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'TableColumn')
END

INSERT INTO 
    TableColumn
(   LaufNr,
    ImportNr,
    ErstelltAm,
    ErstelltVon,
    Geaendert,
    Exportiert,
    GeaendertAm,
    GeaendertVon,
    COLALIGNMENT,
    COLDEC,
    COLDISPLAYLENGTH,
    COLFIELDTYPE,
    COLFORMAT,
    COLLEFT,
    COLLENGTH,
    COLNAME,
    COLPOSITION,
    COLSEARCH,
    COLTITLE,
    COLTOP,
    COLTYPE,
    TABLENAME,
    GROUPNAME,
    GROUPLEFT,
    GROUPTOP,
    COLHIDE,
    COLHEIGHT,
    GETKEY,
    COLVALIDATE,
    TABLETITEL,
    COLLINK,
    COLREMARKS,
    SUCHFELD,
    TOOLTIPDEF) 
VALUES
(   /* LaufNr */        (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'TableColumn'),
    /* ImportNr */          0,    
    /* ErstelltAm */        { ts '2016-10-19 11:28:48'},    
    /* ErstelltVon */       '',    
    /* Geaendert  */        1,    
    /* Exportiert */        0,    
    /* GeaendertAm */       { ts '2016-10-19 11:28:48'},    
    /* GeaendertVon */      '',    
    /* COLALIGNMENT */      1,    
    /* COLDEC */            0,    
    /* COLDISPLAYLENGTH */  1500,    
    /* COLFIELDTYPE */      null,    
    /* COLFORMAT */         'NotVisible',    
    /* COLLEFT */           0,    
    /* COLLENGTH */         6,    
    /* COLNAME */           'Z_Umbraco_Id',    
    /* COLPOSITION */       0,    
    /* COLSEARCH */         0,    
    /* COLTITLE */          'Umbraco_Id',    
    /* COLTOP */            0,    
    /* COLTYPE */           'INT',    
    /* TABLENAME */         'AUF_Dokumente',    
    /* GROUPNAME */         null,    
    /* GROUPLEFT */         0,    
    /* GROUPTOP */          0,    
    /* COLHIDE */           1,    
    /* COLHEIGHT */         0,    
    /* GETKEY */            0,    
    /* COLVALIDATE */       null,    
    /* TABLETITEL */        'Dokumente Auftrag',    
    /* COLLINK */           null,    
    /* COLREMARKS */        'Zusatzfeld Umbraco_Id',    
    /* SUCHFELD */          null,    
    /* TOOLTIPDEF */        'True')

UPDATE 
    LaufNummern 
SET 
    LaufNr         = LaufNr + 1 
WHERE 
    Tabelle     = 'TableColumn'

IF 
((    SELECT 
        COUNT(*) 
    FROM 
        USE_Rechte  
    WHERE 
        Modul     = 'PXZUSATZ' 
    AND 
        Form     = 'AUF_Dokumente' 
    AND Menu     = 'OHNE') = 0)

BEGIN

    IF (SELECT COUNT(LaufNr) FROM LaufNummern WHERE Tabelle = 'USE_Rechte') = 0 
    BEGIN
        INSERT INTO LaufNummern (LaufNr, Tabelle) VALUES(0, 'USE_Rechte')
    END

    INSERT INTO 
        USE_Rechte
    (   LaufNr,
        ImportNr,
        ErstelltAm,
        ErstelltVon,
        Geaendert,
        Exportiert,
        GeaendertAm,
        GeaendertVon,
        Modul,
        Form,
        Menu,
        GruppeUSE,
        Recht) 
    VALUES
    (   /* LaufNr */    (   SELECT 
                                LaufNr + 1 
                            FROM 
                                LaufNummern 
                            WHERE 
                                Tabelle = 'USE_Rechte'),
        /* ImportNr */      0,   
        /* ErstelltAm */    { ts '2015-10-06 21:06:37'},  
        /* ErstelltVon */   '',
        /* Geaendert */     1,
        /* Exportiert */    0,
        /* GeaendertAm */   { ts '2015-10-06 21:06:37'},
        /* GeaendertVon */  '', 
        /* Modul */         'PXZUSATZ',
        /* Form */          'ADR_Adressen', 
        /* Menu */          'OHNE',
        /* GruppeUSE */     'ADMIN',
        /* Recht */         'S')

    UPDATE 
        LaufNummern 
    SET 
        LaufNr         = LaufNr + 1 
    WHERE 
        Tabelle     = 'USE_Rechte'

END

