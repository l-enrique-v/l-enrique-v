USE [AssignRef]
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_SelectAll]    Script Date: 5/12/2023 5:43:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--==============================================================
-- Author:		Luis Enrique Valle
-- Create date: 5/5/2023
-- Description:Get All Resoure Categories
--			    
--Params:	[dbo].[ResourceCategories_SelectAll] 
--				
--
--			   
-- Code Reviewer: Shane Rivas Martin

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
--
--==============================================================
CREATE PROC [dbo].[ResourceCategories_SelectAll]
as
/*
execute dbo.ResourceCategories_SelectAll
*/
BEGIN
SELECT *
FROM dbo.ResourceCategories
END
GO
