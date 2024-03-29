CREATE DATABASE EateryDB
USE [EateryDB]
GO

SELECT @@SERVERNAME
/****** Object:  UserDefinedFunction [dbo].[fn_General_Split]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_General_Split]
(
	@list VARCHAR(MAX),
	@delimiter VARCHAR(5)
)
RETURNS @retVal TABLE (Id INT IDENTITY(1,1), Value VARCHAR(MAX))
AS
BEGIN
	WHILE (CHARINDEX(@delimiter, @list) > 0)
	BEGIN
		INSERT INTO @retVal (Value)
		SELECT Value = LTRIM(RTRIM(SUBSTRING(@list, 1, CHARINDEX(@delimiter, @list) - 1)))
		SET @list = SUBSTRING(@list, CHARINDEX(@delimiter, @list) + LEN(@delimiter), LEN(@list))
	END
	INSERT INTO @retVal (Value)
	SELECT Value = LTRIM(RTRIM(@list))
	RETURN 
END
GO
/****** Object:  Table [dbo].[msDish]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msDish](
	[DishID] [int] IDENTITY(1,1) NOT NULL,
	[DishTypeID] [int] NOT NULL,
	[DishName] [varchar](200) NOT NULL,
	[DishPrice] [int] NOT NULL,
	[AuditedActivity] [char](1) NOT NULL,
	[AuditedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DishID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[msDishType]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msDishType](
	[DishTypeID] [int] IDENTITY(1,1) NOT NULL,
	[DishTypeName] [varchar](100) NOT NULL,
	[AuditedActivity] [char](1) NOT NULL,
	[AuditedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DishTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[msDish]  WITH CHECK ADD FOREIGN KEY([DishTypeID])
REFERENCES [dbo].[msDishType] ([DishTypeID])
GO
/****** Object:  Table [dbo].[msRecipe]    Script Date: 24/06/2021 12:01:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msRecipe](
	[RecipeID] [int] IDENTITY(1,1) NOT NULL,
	[DishID] [int] NOT NULL,
	[RecipeName] [varchar](200) NOT NULL,
	[AuditedActivity] [char](1) NOT NULL,
	[AuditedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecipeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[msRecipe]  WITH CHECK ADD FOREIGN KEY([DishID])
REFERENCES [dbo].[msDish] ([DishID])
GO
/****** Object:  Table [dbo].[msRecipeDetail]    Script Date: 01/07/2021 12:01:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msRecipeDetail](
	[RecipeDetailID] [int] IDENTITY(1,1) NOT NULL,
	[RecipeID] [int] NOT NULL,
	[RecipeDetailIngredient] [varchar](200) NOT NULL,
	[RecipeDetailQuantity] [int] NOT NULL,
	[RecipeDetailUnit] [varchar](50) NOT NULL,
	[AuditedActivity] [char](1) NOT NULL,
	[AuditedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecipeDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[msRecipeDetail]  WITH CHECK ADD FOREIGN KEY([RecipeID])
REFERENCES [dbo].[msRecipe] ([RecipeID])
GO
/****** Object:  Table [dbo].[msRecipe]    Script Date: 24/06/2021 12:01:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msRecipe](
	[RecipeID] [int] IDENTITY(1,1) NOT NULL,
	[DishID] [int] NOT NULL,
	[RecipeName] [varchar](200) NOT NULL,
	[AuditedActivity] [char](1) NOT NULL,
	[AuditedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecipeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[msRecipe]  WITH CHECK ADD FOREIGN KEY([DishID])
REFERENCES [dbo].[msDish] ([DishID])
GO
/****** Object:  Table [dbo].[msRecipeDescription]    Script Date: 02/07/2021 12:01:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msRecipeDescription](
	[RecipeDescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[RecipeID] [int] NOT NULL,
	[RecipeDescriptionMessage] [varchar](MAX) NOT NULL,
	[AuditedActivity] [char](1) NOT NULL,
	[AuditedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecipeDescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[msRecipeDescription]  WITH CHECK ADD FOREIGN KEY([RecipeID])
REFERENCES [dbo].[msRecipe] ([RecipeID])
/****** Object:  StoredProcedure [dbo].[Dish_Delete]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Jonathan Ibrahim
 * Date: 10 Mar 2021
 * Purpose: Delete dish
 */
CREATE PROCEDURE [dbo].[Dish_Delete]
	@DishIDs VARCHAR(MAX)
AS
BEGIN
	UPDATE msDish
	SET AuditedActivity = 'D',
		AuditedTime = GETDATE()
	WHERE DishID IN (SELECT value FROM fn_General_Split(@DishIDs, ','))
END
GO
/****** Object:  StoredProcedure [dbo].[Recipe_Delete]    Script Date: 23/06/2021 2:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Paulus Agung T.
 * Date: 23 June 2021
 * Purpose: Delete recipe
 */
CREATE PROCEDURE [dbo].[Recipe_Delete]
	@RecipeIDs VARCHAR(MAX)
AS
BEGIN
	UPDATE msRecipe
	SET AuditedActivity = 'D',
		AuditedTime = GETDATE()
	WHERE RecipeID IN (SELECT value FROM fn_General_Split(@RecipeIDs, ','))
END
GO
/****** Object:  StoredProcedure [dbo].[RecipeDetail_Delete]    Script Date: 01/07/2021 2:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Paulus Agung T.
 * Date: 1 July 2021
 * Purpose: Delete recipe detail
 */
CREATE PROCEDURE [dbo].[RecipeDetail_Delete]
	@RecipeDetailIDs VARCHAR(MAX)
AS
BEGIN
	UPDATE msRecipeDetail
	SET AuditedActivity = 'D',
		AuditedTime = GETDATE()
	WHERE RecipeDetailID IN (SELECT value FROM fn_General_Split(@RecipeDetailIDs, ','))
END
GO
/****** Object:  StoredProcedure [dbo].[Dish_Get]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Jonathan Ibrahim
 * Date: 10 Mar 2021
 * Purpose: Get semua dish
 */
CREATE PROCEDURE [dbo].[Dish_Get]
AS
BEGIN
	SELECT 
		DishID,
		DishTypeID,
		DishName, 
		DishPrice 
	FROM msDish WITH(NOLOCK)
	WHERE AuditedActivity <> 'D'
END
GO
/****** Object:  StoredProcedure [dbo].[Recipe_Get]    Script Date: 24/06/2021 13:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Paulus Agung T.
 * Date: 23 June 2021
 * Purpose: Get semua recipe dari Dish id tertentu
 */
CREATE PROCEDURE [dbo].[Recipe_Get]
	@DishId INT
AS
BEGIN
	SELECT 
		RecipeID,
		DishID,
		RecipeName
	FROM msRecipe WITH(NOLOCK)
	WHERE DishID = @DishId AND AuditedActivity <> 'D'
END
GO
/****** Object:  StoredProcedure [dbo].[RecipeDetail_Get]    Script Date: 01/07/2021 13:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Paulus Agung T.
 * Date: 1 July 2021
 * Purpose: Get semua recipe detail dari recipe id tertentu
 */
CREATE PROCEDURE [dbo].[RecipeDetail_Get]
	@RecipeId INT
AS
BEGIN
	SELECT 
		RecipeDetailID,
		RecipeID,
		RecipeDetailIngredient,
		RecipeDetailQuantity,
		RecipeDetailUnit
	FROM msRecipeDetail WITH(NOLOCK)
	WHERE RecipeID = @RecipeId AND AuditedActivity <> 'D'
END
GO
/****** Object:  StoredProcedure [dbo].[RecipeDescription_Get]    Script Date: 02/07/2021 13:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Paulus Agung T.
 * Date: 2 July 2021
 * Purpose: Get recipe description dari recipe id tertentu
 */
CREATE PROCEDURE [dbo].[RecipeDescription_Get]
	@RecipeId INT
AS
BEGIN
	SELECT 
		RecipeDescriptionID,
		RecipeID,
		RecipeDescriptionMessage
	FROM msRecipeDescription WITH(NOLOCK)
	WHERE RecipeID = @RecipeId AND AuditedActivity <> 'D'
END
GO
/****** Object:  StoredProcedure [dbo].[Dish_GetByID]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Jonathan Ibrahim
 * Date: 10 Mar 2021
 * Purpose: Get dish tertentu by Id
 */
CREATE PROCEDURE [dbo].[Dish_GetByID]
	@DishId INT
AS
BEGIN
	SELECT 
		DishID,
		DishTypeID,
		DishName, 
		DishPrice 
	FROM msDish WITH(NOLOCK)
	WHERE DishId = @DishId AND AuditedActivity <> 'D'
END
GO
/****** Object:  StoredProcedure [dbo].[Recipe_GetByID]    Script Date: 24/06/2021 01:53:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Paulus Agung T.
 * Date: 23 June 2021
 * Purpose: Get recipe tertentu by Id
 */
CREATE PROCEDURE [dbo].[Recipe_GetByID]
	@RecipeId INT
AS
BEGIN
	SELECT 
		RecipeID,
		DishID,
		RecipeName
	FROM msRecipe WITH(NOLOCK)
	WHERE RecipeId = @RecipeId AND AuditedActivity <> 'D'
END
GO
/****** Object:  StoredProcedure [dbo].[RecipeDetail_GetByID]    Script Date: 01/07/2021 01:53:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Paulus Agung T.
 * Date: 1 July 2021
 * Purpose: Get recipe detail tertentu by Id
 */
CREATE PROCEDURE [dbo].[RecipeDetail_GetByID]
	@RecipeDetailId INT
AS
BEGIN
	SELECT 
		RecipeDetailID,
		RecipeID,
		RecipeDetailIngredient,
		RecipeDetailQuantity,
		RecipeDetailUnit
	FROM msRecipeDetail WITH(NOLOCK)
	WHERE RecipeDetailID = @RecipeDetailId AND AuditedActivity <> 'D'
END
GO
/****** Object:  StoredProcedure [dbo].[Dish_InsertUpdate]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Jonathan Ibrahim
 * Date: 10 Mar 2021
 * Purpose: Insert atau update dish
 */
CREATE PROCEDURE [dbo].[Dish_InsertUpdate]
	@DishID INT OUTPUT,
	@DishTypeID INT,
	@DishName VARCHAR(100),
	@DishPrice INT
AS
BEGIN
	DECLARE @RetVal INT
	IF EXISTS (SELECT 1 FROM msDish WITH(NOLOCK) WHERE DishID = @DishID AND AuditedActivity <> 'D')
	BEGIN
		UPDATE msDish
		SET DishName = @DishName,
			DishTypeID = @DishTypeID,
			DishPrice = @DishPrice,
			AuditedActivity = 'U',
			AuditedTime = GETDATE()
		WHERE DishID = @DishID AND AuditedActivity <> 'D'
		SET @RetVal = @DishID
	END
	ELSE
	BEGIN
		INSERT INTO msDish 
		(DishName, DishTypeID, DishPrice, AuditedActivity, AuditedTime)
		VALUES
		(@DishName, @DishTypeID, @DishPrice, 'I', GETDATE())
		SET @RetVal = SCOPE_IDENTITY()
	END
	SELECT @DishId = @RetVal
END
GO
/****** Object:  StoredProcedure [dbo].[Recipe_InsertUpdate]  Script Date: 23/06/2021 1:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Paulus Agung T.
 * Date: 23 June 2021
 * Purpose: Insert atau update recipe
 */
CREATE PROCEDURE [dbo].[Recipe_InsertUpdate]
	@RecipeID INT OUTPUT,
	@DishID INT,
	@RecipeName VARCHAR(100)
AS
BEGIN
	DECLARE @RetVal INT
	IF EXISTS (SELECT 1 FROM msRecipe WITH(NOLOCK) WHERE RecipeID = @RecipeID AND AuditedActivity <> 'D')
	BEGIN
		UPDATE msRecipe
		SET RecipeName = @RecipeName,
			AuditedActivity = 'U',
			AuditedTime = GETDATE()
		WHERE RecipeID = @RecipeID AND AuditedActivity <> 'D'
		SET @RetVal = @RecipeID
	END
	ELSE
	BEGIN
		INSERT INTO msRecipe 
		(DishID, RecipeName, AuditedActivity, AuditedTime)
		VALUES
		(@DishID, @RecipeName, 'I', GETDATE())
		SET @RetVal = SCOPE_IDENTITY()
	END
	SELECT @RecipeId = @RetVal
END
GO
/****** Object:  StoredProcedure [dbo].[RecipeDetail_InsertUpdate]  Script Date: 01/07/2021 1:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Paulus Agung T.
 * Date: 1 July 2021
 * Purpose: Insert atau update recipe detail
 */
CREATE PROCEDURE [dbo].[RecipeDetail_InsertUpdate]
	@RecipeDetailID INT OUTPUT,
	@RecipeID INT,
	@RecipeDetailIngredient VARCHAR(200),
	@RecipeDetailQuantity INT,
	@RecipeDetailUnit VARCHAR(100)
AS
BEGIN
	DECLARE @RetVal INT
	IF EXISTS (SELECT 1 FROM msRecipeDetail WITH(NOLOCK) WHERE RecipeDetailID = @RecipeDetailID AND AuditedActivity <> 'D')
	BEGIN
		UPDATE msRecipeDetail
		SET RecipeDetailIngredient = @RecipeDetailIngredient,
			RecipeDetailQuantity = @RecipeDetailQuantity,
			RecipeDetailUnit = @RecipeDetailUnit,
			AuditedActivity = 'U',
			AuditedTime = GETDATE()
		WHERE RecipeDetailID = @RecipeDetailID AND AuditedActivity <> 'D'
		SET @RetVal = @RecipeDetailID
	END
	ELSE
	BEGIN
		INSERT INTO msRecipeDetail 
		(RecipeID, RecipeDetailIngredient, RecipeDetailQuantity, RecipeDetailUnit, AuditedActivity, AuditedTime)
		VALUES
		(@RecipeID, @RecipeDetailIngredient, @RecipeDetailQuantity, @RecipeDetailUnit, 'I', GETDATE())
		SET @RetVal = SCOPE_IDENTITY()
	END
	SELECT @RecipeDetailID = @RetVal
END
GO
/****** Object:  StoredProcedure [dbo].[RecipeDescription_InsertUpdate]  Script Date: 01/07/2021 1:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Paulus Agung T.
 * Date: 2 July 2021
 * Purpose: Insert atau update recipe description
 */
CREATE PROCEDURE [dbo].[RecipeDescription_InsertUpdate]
	@RecipeDescriptionID INT OUTPUT,
	@RecipeID INT,
	@RecipeDescriptionMessage VARCHAR(MAX)
AS
BEGIN
	DECLARE @RetVal INT
	IF EXISTS (SELECT 1 FROM msRecipeDescription WITH(NOLOCK) WHERE RecipeDescriptionID = @RecipeDescriptionID AND AuditedActivity <> 'D')
	BEGIN
		UPDATE msRecipeDescription
		SET RecipeDescriptionMessage = @RecipeDescriptionMessage,
			AuditedActivity = 'U',
			AuditedTime = GETDATE()
		WHERE RecipeDescriptionID = @RecipeDescriptionID AND AuditedActivity <> 'D'
		SET @RetVal = @RecipeDescriptionID
	END
	ELSE
	BEGIN
		INSERT INTO msRecipeDescription 
		(RecipeID, RecipeDescriptionMessage, AuditedActivity, AuditedTime)
		VALUES
		(@RecipeID, @RecipeDescriptionMessage, 'I', GETDATE())
		SET @RetVal = SCOPE_IDENTITY()
	END
	SELECT @RecipeDescriptionMessage = @RetVal
END
GO
/****** Object:  StoredProcedure [dbo].[DishType_Get]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Jonathan Ibrahim
 * Date: 10 Mar 2021
 * Purpose: Get semua dish type
 */
CREATE PROCEDURE [dbo].[DishType_Get]
AS
BEGIN
	SELECT DishTypeID, DishTypeName FROM msDishType WITH(NOLOCK) 
	WHERE AuditedActivity <> 'D'
END
GO
/****** Object:  StoredProcedure [dbo].[DishType_GetByID]    Script Date: 20/05/2021 7:23:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * Created by: Jonathan Ibrahim
 * Date: 10 Mar 2021
 * Purpose: Get dish type by ID
 */
CREATE PROCEDURE [dbo].[DishType_GetByID]
	@DishTypeID INT
AS
BEGIN
	SELECT DishTypeID, DishTypeName
	FROM msDishType WITH(NOLOCK)
	WHERE DishTypeID = @DishTypeID AND AuditedActivity <> 'D'
END
GO
-- SEEDING msDishType
INSERT INTO msDishType (DishTypeName,AuditedActivity,AuditedTime)
VALUES ('Rumahan','I',GETDATE()), ('Restoran','I',GETDATE()), ('Pinggiran','I',GETDATE())

--Checking Table
SELECT * FROM dbo.msDish
SELECT * FROM dbo.msDishType
SELECT * FROM dbo.msRecipe
SELECT * FROM dbo.msRecipeDetail
SELECT * FROM dbo.msRecipeDescription