/*

Cleaning Data in SQL Queries

*/


Select *
From SQLTUTORIAL..housingdata

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format
--DATE - format YYYY-MM-DD
--DATETIME - format: YYYY-MM-DD HH:MI:SS
--SMALLDATETIME - format: YYYY-MM-DD HH:MI:SS
--TIMESTAMP - format: a unique number

Select saleDate, CONVERT(Date,SaleDate)
From SQLTUTORIAL.dbo.housingdata

Select saleDate
From SQLTUTORIAL.dbo.housingdata


Update housingdata
SET SaleDate = CONVERT(Date,SaleDate)

-- If it doesn't Update properly

ALTER TABLE housingdata
Add SaleDateConverted Date;

Update housingdata
SET SaleDateConverted = CONVERT(Date,SaleDate)

Select SaleDateConverted
From SQLTUTORIAL.dbo.housingdata
 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
From SQLTUTORIAL..housingdata
Where PropertyAddress is null
order by ParcelID

Select PropertyAddress
From SQLTUTORIAL..housingdata
--Where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, 
ISNULL(a.PropertyAddress,b.PropertyAddress)
From SQLTUTORIAL.dbo.housingdata a
JOIN SQLTUTORIAL.dbo.housingdata b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is not null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From SQLTUTORIAL.dbo.housingdata a
JOIN SQLTUTORIAL.dbo.housingdata b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null




--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)
-- Assuming your table is named 'your_table' and has a column 'full_name'

-- Add new columns for first and last names
--ALTER TABLE your_table
--ADD first_name NVARCHAR(MAX),
--    last_name NVARCHAR(MAX);

---- Update the new columns based on the 'full_name' column
--UPDATE your_table
--SET
--    first_name = SUBSTRING(full_name, 1, CHARINDEX(' ', full_name) - 1),
--    last_name = SUBSTRING(full_name, CHARINDEX(' ', full_name) + 1, LEN(full_name))
--WHERE CHARINDEX(' ', full_name) > 0;







Select PropertyAddress
From SQLTUTORIAL.dbo.housingdata
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , 
LEN(PropertyAddress)) as AddressTown

From SQLTUTORIAL.dbo.housingdata


ALTER TABLE housingdata
Add PropertySplitAddress Nvarchar(255);

Update housingdata
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, 
CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE housingdata
Add PropertySplitCity Nvarchar(255);

Update housingdata
SET PropertySplitCity = SUBSTRING(PropertyAddress, 
CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))




select PropertyAddress,SUBSTRING(PropertyAddress,-1, CHARINDEX(' ',PropertyAddress)) As Address
from SQLTUTORIAL.dbo.housingdata



Select OwnerAddress,PropertySplitAddress,PropertySplitCity,PropertyTown
From SQLTUTORIAL.dbo.housingdata

Select OwnerAddress
From SQLTUTORIAL.dbo.housingdata

Select OwnerAddress,
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From SQLTUTORIAL.dbo.housingdata

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From SQLTUTORIAL.dbo.housingdata



ALTER TABLE housingdata
Add OwnerSplitAddress Nvarchar(255);

Update housingdata
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE housingdata
Add OwnerSplitCity Nvarchar(255);

Update housingdata
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE housingdata
Add OwnerSplitState Nvarchar(255);

Update housingdata
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From SQLTUTORIAL.dbo.housingdata

Select OwnerName
From SQLTUTORIAL.dbo.housingdata

Select OwnerName,
PARSENAME(REPLACE(OwnerName, '.', '.') , 2)
From SQLTUTORIAL.dbo.housingdata




--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From SQLTUTORIAL.dbo.housingdata
Group by SoldAsVacant
order by 2




Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From SQLTUTORIAL.dbo.housingdata


Update housingdata
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END






-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From SQLTUTORIAL.dbo.housingdata
order by ParcelID



WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From SQLTUTORIAL.dbo.housingdata
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From SQLTUTORIAL.dbo.housingdata
--order by ParcelID
)
Delete
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress


Select *
From SQLTUTORIAL.dbo.housingdata
order by ParcelID




---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From SQLTUTORIAL.dbo.housingdata


ALTER TABLE SQLTUTORIAL.dbo.housingdata
DROP COLUMN OwnerAddress, PropertyAddress, SaleDate















-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--- Importing Data using OPENROWSET and BULK INSERT	

--  More advanced and looks cooler, but have to configure server appropriately to do correctly
--  Wanted to provide this in case you wanted to try it


--sp_configure 'show advanced options', 1;
--RECONFIGURE;
--GO
--sp_configure 'Ad Hoc Distributed Queries', 1;
--RECONFIGURE;
--GO


--USE PortfolioProject 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1 

--GO 


---- Using BULK INSERT

--USE PortfolioProject;
--GO
--BULK INSERT nashvilleHousing FROM 'C:\Temp\SQL Server Management Studio\Nashville Housing Data for Data Cleaning Project.csv'
--   WITH (
--      FIELDTERMINATOR = ',',
--      ROWTERMINATOR = '\n'
--);
--GO


---- Using OPENROWSET
--USE PortfolioProject;
--GO
--SELECT * INTO nashvilleHousing
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
--    'Excel 12.0; Database=C:\Users\alexf\OneDrive\Documents\SQL Server Management Studio\Nashville Housing Data for Data Cleaning Project.csv', [Sheet1$]);
--GO












