--UPDATE INVENTORY A
CREATE PROCEDURE UpdateInventoryA
  @ProId INT ,
  @BarCode VARCHAR(100),
  @PName VARCHAR(100) ,
  @Quantity INT
AS
BEGIN
    UPDATE [HALLA-IBRAHIM\SITEA].siteA.dbo.ProductsA
    SET Quantity = @Quantity ,BarCode= @BarCode , PName = @PName
	WHERE  ProIDA = @ProId;
END;
GO
UpdateInventory 1, '08210' , 'Tea', 60;
--------------------------------------------------------------------
GO
--UPDATE INVENTORY B
ALTER PROCEDURE UpdateInventoryB
  @ProId INT ,
  @BarCode VARCHAR(100),
  @PName VARCHAR(100) ,
  @Quantity INT
AS
BEGIN
    UPDATE [HALLA-IBRAHIM\SITEB].siteB.dbo.ProductsB
    SET Quantity = @Quantity ,BarCode= @BarCode , PName = @PName
	WHERE  ProIDB = @ProId;
END;
GO

UpdateInventoryB 1, '08210' , 'Tea' , 600; 
GO
-------------------------------------------------------------
--UPDATE INVENTORY AB
CREATE PROCEDURE UpdateInventoryAB
  @ProId INT ,
  @BarCode VARCHAR(100),
  @PName VARCHAR(100) ,
  @Quantity INT
AS
BEGIN
    UPDATE [HALLA-IBRAHIM\SITEA].siteA.dbo.ProductsA
    SET Quantity = @Quantity ,BarCode= @BarCode , PName = @PName
	WHERE  ProIDA = @ProId;
	
	UPDATE [HALLA-IBRAHIM\SITEB].siteB.dbo.ProductsB
    SET Quantity = @Quantity, BarCode= @BarCode , PName = @PName
	WHERE  ProIDB = @ProId;
END;
GO

UpdateInventoryAC 1,'08210' , 'Tea' , 65; 
GO
----------------------------------------------------
CREATE PROCEDURE AddInventoryA
    @ProductID INT,
	@ProductName VARCHAR(100),
	@BarCode VARCHAR(100),
    @Quantity INT
AS
BEGIN
    SET NOCOUNT ON;
      -- Insert data into GetA to trigger the trg_AddInventoryA trigger
    INSERT INTO [HALLA-IBRAHIM\siteA].siteA.dbo.ProductsA(ProIdA, PName, BarCode, Quantity)
    VALUES (@ProductID, @ProductName, @BarCode, @Quantity);

   
END;
GO

EXEC AddInventoryA @ProductID = 4,@ProductName = "SUGAR",@BarCode = "080321", @Quantity = 820;
GO
---------------------------------------------------------------------
CREATE PROCEDURE AddInventoryB
    @ProductID INT,
	@ProductName VARCHAR(100),
	@BarCode VARCHAR(100),
    @Quantity INT
AS
BEGIN
    SET NOCOUNT ON;
               -- Insert data into ProductsC to propagate to SiteC
    INSERT INTO [HALLA-IBRAHIM\SITEB].siteB.dbo.ProductsB(ProIdB, PName, BarCode,Quantity)
    VALUES ( @ProductID, @ProductName, @BarCode, @Quantity);
   
END;
GO

EXEC AddInventoryB @ProductID = 4,@ProductName = "egg",@BarCode = "05621", @Quantity = 820;
GO
----------------------------------------------------------------
 CREATE PROCEDURE AddInventoryAB
    @ProductID INT,
	@ProductName VARCHAR(100),
	@BarCode VARCHAR(100),
    @Quantity INT
AS
BEGIN
    SET NOCOUNT ON;
	--- insert into site A
	INSERT INTO [HALLA-IBRAHIM\SITEA].siteA.dbo.ProductsA(ProIdA, PName, BarCode,Quantity)
    VALUES ( @ProductID, @ProductName, @BarCode, @Quantity);
               -- Insert data into ProductsC to propagate to SiteC
    INSERT INTO [HALLA-IBRAHIM\SITEB].siteB.dbo.ProductsB(ProIdB, PName, BarCode,Quantity)
    VALUES ( @ProductID, @ProductName, @BarCode, @Quantity);
   
END;
GO

EXEC AddInventoryAB @ProductID = 5,@ProductName = "coffee",@BarCode = "3211", @Quantity = 850;
GO
-------------------------------------------------------------------
CREATE PROCEDURE ViewInventoryA
AS
BEGIN
    SET NOCOUNT ON;

    -- Your SELECT statement to retrieve inventory information
    SELECT ProIdA, BarCode, Quantity, PName
    FROM  [HALLA-IBRAHIM\SITEA].siteA.dbo.ProductsA;

    -- Additional logic or filtering conditions can be added as needed
END;
GO
EXEC ViewInventoryA;
GO
-------------------------------------------------------------------
CREATE PROCEDURE ViewInventoryB
AS
BEGIN
    SET NOCOUNT ON;

    -- Your SELECT statement to retrieve inventory information
    SELECT ProIdB, BarCode, Quantity, PName
    FROM  [HALLA-IBRAHIM\SITEB].siteB.dbo.ProductsB;

    -- Additional logic or filtering conditions can be added as needed
END;
GO
EXEC ViewInventoryB;
GO

------------------------------------------
CREATE PROCEDURE ViewInventoryAC
AS
BEGIN
    SET NOCOUNT ON;
 -- Select inventory information for each product in SiteA
    SELECT 
        P.ProIdA,
        P.BarCode,
        P.PName,
        P.Quantity AS QuantityInSiteA,
        C.Quantity AS QuantityInSiteC
    FROM 
        [HALLA-IBRAHIM\SITEA].siteA.dbo.ProductsA p
    LEFT JOIN 
         [HALLA-IBRAHIM\SITEB].siteB.dbo.ProductsB C ON P.ProIdA = C.ProIdB;
END;
GO
EXEC ViewInventoryAC;
GO
-------------------------------------------
-- Create a stored procedure to add a new product to a specified site
CREATE PROCEDURE AddProductToSite
    @ProductId INT,
    @ProductName VARCHAR(100),
    @BarCode VARCHAR(100),
    @Quantity INT,
    @TargetSite NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @InsertStatement NVARCHAR(MAX);

    -- Formulate the dynamic SQL statement based on the target site
    SET @InsertStatement = 
        CASE 
            WHEN @TargetSite = 'SiteA' THEN
                'INSERT INTO [HALLA-IBRAHIM\SITEA].siteA.dbo.ProductsA(ProIdA, PName, BarCode, Quantity) VALUES (' 
            WHEN @TargetSite = 'SiteC' THEN
                'INSERT INTO [HALLA-IBRAHIM\SITEB].siteB.dbo.ProductsB (ProIdB, PName, BarCode, Quantity) VALUES (' 
        END +
        CAST(@ProductId AS NVARCHAR(50)) + ',' + 
        '''' + @ProductName + ''',''' + @BarCode + ''',' + CAST(@Quantity AS NVARCHAR(50)) + ')';

    -- Execute the dynamic SQL statement
    EXEC sp_executesql @InsertStatement;
END;


-- Add a new product with ID 4 to SiteB
EXEC AddProductToSite @TargetSite = 'SiteA', @ProductId = 6, @ProductName = 'Lemon', @BarCode = '00029', @Quantity = 620;
-------------------------------------------------
CREATE PROCEDURE DeleteProduct
  @ProId INT
AS
BEGIN
    DELETE FROM [HALLA-IBRAHIM\SITEA].siteA.dbo.ProductsA
    WHERE ProIDA = @ProId;
END;
GO
EXEC DeleteProduct 2;
--------------------------------------------------------
CREATE PROCEDURE DeleteProductB
  @ProId INT
AS
BEGIN
    DELETE FROM [HALLA-IBRAHIM\SITEB].siteB.dbo.ProductsB
    WHERE ProIDB= @ProId
END;
GO
EXEC DeleteProductB 1;