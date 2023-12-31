USE [AssignRef]
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_SelectByCategory]    Script Date: 5/12/2023 5:43:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--==============================================================
-- Author:		Luis Enrique Valle
-- Create date: 5/5/2023
-- Description:Get ResourceCategory by Id
--			    
--Params:	[dbo].[ResourceCategories_SelectByCategory]
--			@Id int	
--
--			   
-- Code Reviewer: Shane Rivas Martin

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
--
--==============================================================

--TEST CODE-


CREATE PROC [dbo].[ResourceCategories_SelectByCategory]
@Id int 

as

BEGIN
SELECT *
From ResourceCategories
Where Id= @Id
END
GO
