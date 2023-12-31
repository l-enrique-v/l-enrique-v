USE [AssignRef]
GO
/****** Object:  StoredProcedure [dbo].[Resources_DeleteById]    Script Date: 5/12/2023 5:43:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--==============================================================
-- Author:		Luis Enrique Valle
-- Create date: 5/5/2023
-- Description:Delete Resource: By updating IsActive to 0
--			    
--Params:	[dbo].[Resources_DeleteById]
--		@Id int, 
--		@UserId int
--			   
-- Code Reviewer: 

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
--
--==============================================================
CREATE PROC [dbo].[Resources_DeleteById] @Id int, @UserId int
AS

/*
Declare @Id int = 14
Declare @UserId int = 50

Execute dbo.Resources_DeleteById @Id, @UserId


*/
BEGIN
  DECLARE @DateModified datetime2(7) = GETUTCDATE();
  DECLARE @IsActive bit = 0;

  UPDATE [dbo].[Resources]
  SET [IsActive] = @IsActive,
      [ModifiedBy] = @UserId,
      [DateModified] = @DateModified
  WHERE Id = @Id


END
GO
