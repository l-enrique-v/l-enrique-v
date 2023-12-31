USE [AssignRef]
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_By_ResourceType]    Script Date: 5/18/2023 4:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--==============================================================
-- Author:		Luis Enrique Valle
-- Create date: 5/5/2023
-- Description Select All Resources by the ResourceType
--			    
--Params:	[dbo].[Resource_Select_By_ResourceType]
--				@PageIndex int 
--              ,@PageSize int
--				,@CategoryId in
--			   
-- Code Reviewer: Shane Rivas Martin

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
--
--==============================================================
CREATE PROC [dbo].[Resources_Select_By_ResourceType]
			@PageIndex int,
			@PageSize int,
			@CategoryId int

/*


Declare @ResourceCategoryId int = 1,
@PageIndex int = 0,
@PageSize int = 5
Execute Resources_Select_By_ResourceType @PageIndex, @PageSize, @ResourceCategoryId


*/
as

BEGIN
  	Declare @Offset int = @PageIndex * @PageSize

      SELECT r.[Id]
             ,r.[Name]
			 ,rc.[Id] as ResourceCategoryId
			 ,rc.[Name] as ResourceName
             ,r.[Description]
             ,f.Id as [CoverImageId]
			 ,f.[Name] as [CoverImageName]
			 ,f.[Url] as [CoveImageUrl]
			 ,ft.[Id] as [CoverImageFileTypeId]
			 ,ft.[Name] as [CoverImageFileType]
			 ,f.[Id] as [FileId]
			 ,f.[Name] as [FileName]
			 ,f.[Url] as [FileUrl]
			 ,ft.[Id] as [FileTypeId]
			 ,ft.[Name] as [FileType]
             ,c.[Id]         as ConferenceId
             ,c.[Name]       as ConferenceName
             ,c.[Code]       as ConferenceCode
             ,c.[Logo]       as ConferenceLogo
             ,r.[IsActive]
             ,cu.[Id]        as CreatingAuthorId
             ,cu.[FirstName] as CreatingAuthorFirstName
             ,cu.[LastName]  as CreatingAuthorLastName
			 ,cu.[Mi] as CreatingAuthorMI
             ,cu.[AvatarUrl] as CreatingAuthorAvatar
             ,mu.[Id]        as ModifyingAuthorId
             ,mu.[FirstName] as ModifyingAuthorFirstName
             ,mu.[LastName]  as ModifyingAuthorLastName
			 ,mu.[Mi] as ModifyingAuthorMI
             ,mu.[AvatarUrl] as ModifyingAuthorAvatar
             ,r.[DateCreated]
             ,r.[DateModified]
			 ,TotalCount = COUNT(1) OVER()

        FROM [dbo].[resources] AS r
			INNER JOIN dbo.Files as f
					ON r.fileId = f.id
			inner Join dbo.FileTypes as ft
					on f.FileTypeId = ft.id
             INNER JOIN dbo.conferences AS c
                     ON r.conferenceid = c.id
             INNER JOIN dbo.resourcecategories AS rc
                     ON r.resourcecategoryid = rc.id
             INNER JOIN dbo.users AS cu
                     ON r.createdby = cu.id
             INNER JOIN dbo.users AS mu
                     ON r.modifiedby = mu.id
WHERE r.ResourceCategoryId = @CategoryId
		  Order by r.Id
		  Offset @Offset Rows
		Fetch Next @PageSize Rows Only


END
GO
