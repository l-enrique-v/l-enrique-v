USE [AssignRef]
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_Insert]    Script Date: 5/12/2023 5:43:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--==============================================================
-- Author:		Luis Enrique Valle
-- Create date: 5/5/2023
-- Description:Insert Resource Category
--			    
--Params:	[dbo].[ResourceCategories_Insert]
--				@Namve nvarchar(100) 
--              ,@Id int OUTPUT
--			   
-- Code Reviewer: Shane Rivas Martin

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
--
--==============================================================

CREATE PROC [dbo].[ResourceCategories_Insert]

    @Name             nvarchar(100),
    @Id               int OUTPUT
AS

    /*
---TestCode---

Declare @Name nvarchar(100) = 'Test 2 Inesert',
		@Id int

SELECT* From dbo.ResourceCategories
EXECUTE dbo.ResourceCategories_Insert 
		@Name,
		@Id 


SELECT* From dbo.ResourceCategories


*/
    BEGIN

    INSERT INTO dbo.ResourceCategories
            (
                [Name]
			)
           
        VALUES
            (
              @Name
            )
        SET @Id = SCOPE_IDENTITY()
    END
GO
