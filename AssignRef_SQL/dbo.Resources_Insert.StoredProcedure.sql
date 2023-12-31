USE [AssignRef]
GO
/****** Object:  StoredProcedure [dbo].[Resources_Insert]    Script Date: 5/18/2023 4:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--==============================================================
-- Author:		Luis Enrique Valle
-- Create date: 5/5/2023
-- Description:Insert Resource
--			    
--Params:	 [dbo].[Resources_Insert]
--		@ConferenceId	  int,
--		@ResourceCategoryId int,
--		@Name             nvarchar(200),
--		@Description      nvarchar(1000),
--		@CoverImageId    int,
--		@FileId          int,
--		@LocationId		  int,
--		@UserId           int,
--		@Id               int OUTPUT
--			   
-- Code Reviewer: Shane Rivas Martin

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
--
--==============================================================
CREATE PROC [dbo].[Resources_Insert]
		@ConferenceId	  int,
		@ResourceCategoryId int,
		@Name             nvarchar(200),
		@Description      nvarchar(1000),
		@CoverImageId    int,
		@FileId          int,
		@UserId           int,
		@Id               int OUTPUT
AS

    /*
---TestCode---
Select* from locations

Declare	@ConferenceId int = 7, 
		@ResourceCategoryId int = 1,
		@Name nvarchar(200) = 'NewTest',
		@Description nvarchar(1000) = 'testDescription',
		@CoverImageId int = 36,
		@FileId int = 36,
		@UserId int = 52,
		@Id int 

EXECUTE dbo.Resources_Insert 
		@ConferenceId
		,@ResourceCategoryId
		,@Name
		,@Description
		,@CoverImageId
		,@FileId
		,@UserId
		,@Id

Select * 
		From dbo.Resources


*/
   BEGIN
    DECLARE @IsActive bit = 1;

    INSERT INTO dbo.Resources
            (
                [ConferenceId],
                [ResourceCategoryId],
                [Name],
                [Description],
                [CoverImageId],
                [FileId],
                [IsActive],
                [CreatedBy],
                [ModifiedBy]
            )
        VALUES
            (
                @ConferenceId,
                @ResourceCategoryId,
                @Name,
                @Description,
                @CoverImageId,
                @FileId,
                @IsActive,
                @UserId,
                @UserId
            )
        SET @Id = SCOPE_IDENTITY()
 END
GO
