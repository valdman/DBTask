
USE developersteam_valdman
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'dbo')      
     EXEC (N'CREATE SCHEMA dbo')                                   
 GO                                                               

USE developersteam_valdman
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'account'  AND sc.name=N'dbo'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'account'  AND sc.name=N'dbo'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [dbo].[account]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[dbo].[account]
(
   [AccountId] int IDENTITY(6, 1)  NOT NULL,
   [FirstName] nvarchar(45) DEFAULT NULL  NULL,
   [LastName] nvarchar(45) DEFAULT NULL  NULL,
   [Email] nvarchar(45)  NOT NULL
)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'developersteam_valdman.account',
        N'SCHEMA', N'dbo',
        N'TABLE', N'account'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE developersteam_valdman
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_account_AccountId'  AND sc.name=N'dbo'  AND type in (N'PK'))
ALTER TABLE [dbo].[account] DROP CONSTRAINT [PK_account_AccountId]
 GO



ALTER TABLE [dbo].[account]
 ADD CONSTRAINT [PK_account_AccountId]
 PRIMARY KEY 
   CLUSTERED ([AccountId] ASC)

GO


USE developersteam_valdman
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'account$Id_UNIQUE'  AND sc.name=N'dbo'  AND type in (N'UQ'))
ALTER TABLE [dbo].[account] DROP CONSTRAINT [account$Id_UNIQUE]
 GO



ALTER TABLE [dbo].[account]
 ADD CONSTRAINT [account$Id_UNIQUE]
 UNIQUE 
   NONCLUSTERED ([AccountId] ASC)

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'account$Email_UNIQUE'  AND sc.name=N'dbo'  AND type in (N'UQ'))
ALTER TABLE [dbo].[account] DROP CONSTRAINT [account$Email_UNIQUE]
 GO



ALTER TABLE [dbo].[account]
 ADD CONSTRAINT [account$Email_UNIQUE]
 UNIQUE 
   NONCLUSTERED ([Email] ASC)

GO

