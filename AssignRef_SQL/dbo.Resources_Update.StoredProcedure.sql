USE [AssignRef]
GO
/****** Object:  StoredProcedure [dbo].[Resources_Update]    Script Date: 5/18/2023 4:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--==============================================================
-- Author:    Luis Enrique Valle
-- Create date: 5/5/2023
-- Description:Updates Resources
--          
--Params:  [dbo].[Resources_Update]
--      @Id          int,
--  	@ConferenceId    int,
--   	@ResourceCategoryId int,
--    	@Name        nvarchar(200),
--    	@Description    nvarchar(1000),
--    	@CoverImageId    int,
--    	@Field        nvarchar(255),
--  	@LocationId      int,
--    	@UserId        int 
--
--         
-- Code Reviewer: 
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: Shane Rivas Martin
-- Note:
--
--==============================================================
CREATE PROC [dbo].[Resources_Update] @Id                 int,
									@ConferenceId		int,
									@ResourceCategoryId int,
									@Name				nvarchar(200),
									@Description		nvarchar(1000),
									@CoverImageId		nvarchar(255),
									@FileId				int,
									@UserId				int
AS
  /*
  
  
  Declare  @Id int = 2,
		@ConferenceId int = 7, 
		@ResourceCategoryId int = 3,
		@Name nvarchar(200) = 'NewTest',
		@Description nvarchar(1000) = 'UPDATE SUCCESSFUL',
		@CoverImageId int = 36,
		@FileId int = 36,
		@UserId int = 52



  
  EXECUTE dbo.Resources_Update
		 @Id
		,@ConferenceId
		,@ResourceCategoryId
		,@Name
		,@Description
		,@CoverImageId
		,@FileId
		,@UserId

  
  
  Select * from resources

  */
  BEGIN
      DECLARE @DateNow DATETIME2(7) = Getutcdate();

      UPDATE dbo.resources
      SET    [conferenceid] = @ConferenceId,
             [resourcecategoryid] = @ResourceCategoryId,
             [name] = @Name,
             [description] = @Description,
             [coverimageId] = @CoverImageId,
             [FileId] = @FileId,
             [modifiedby] = @UserId,
             [datemodified] = @DateNow
      WHERE  [id] = @Id
  END 
GO
