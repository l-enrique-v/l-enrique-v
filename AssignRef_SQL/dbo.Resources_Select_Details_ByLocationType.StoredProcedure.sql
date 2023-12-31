USE [AssignRef]
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ByLocationType]    Script Date: 5/9/2023 1:02:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--==============================================================
-- Author:		Luis Enrique Valle
-- Create date: 5/5/2023
-- Description:Get Resources by LocationType: Paginated
--			    
--Params:	[dbo].[Resources_Select_Details_ByLocationType]
--				@PageIndex int 
--              ,@PageSize int
--				,@LocationType int
--			   
-- Code Reviewer: Shane Rivas Martin

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
--
--==============================================================
CREATE PROC [dbo].[Resources_Select_Details_ByLocationType]
			@PageIndex int 
            ,@PageSize int
			,@LocationType int

/*



Declare @LocationType int = 4, 
@PageIndex int = 0, 
@PageSize int = 5

Execute [dbo].[Resources_Select_Details_ByLocationType] 
@PageIndex, 
@PageSize,
@LocationType

*/
as

BEGIN
Declare @Offset int = @PageIndex * @PageSize

      SELECT r.[Id]
             ,r.[Name]
			 ,rc.[Id] as ResourceCategoryId
			 ,rc.[Name] as ResourceName
             ,r.[Description]
             ,r.[CoverImageUrl]
             ,r.[Field]
             ,l.[Id]         as [LocationId]
             ,lt.[Id]          as [LocationTypeId]
             ,lt.[Name]        as [LocationType]
             ,l.[LineOne]
             ,l.[LineTwo]
             ,l.[City]
			 ,s.[Id] as [StateId]
             ,s.[Name]       as [StateName]
			 ,s.[Code]       as [StateCode]
             ,l.[Zip]
             ,l.[Latitude]
             ,l.[Longitude]
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
        FROM [dbo].Locations as l
             inner join dbo.Resources as r
                     on r.LocationId = l.Id
             inner join dbo.LocationTypes as lt
                     on l.Id = lt.Id
             inner join dbo.States as s
                     on l.StateId = s.Id
             inner join dbo.Conferences as c
                     on r.ConferenceId = c.Id
             inner join dbo.ResourceCategories as rc
                     on r.ResourceCategoryId = rc.Id
             inner join dbo.Users as cu
                     on r.CreatedBy = cu.Id
             inner join dbo.Users as mu
                     on r.ModifiedBy = mu.Id
WHERE lt.Id = @LocationType
Order by r.Id
		  Offset @Offset Rows
		Fetch Next @PageSize Rows Only


END
GO
