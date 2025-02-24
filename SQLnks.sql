USE [db_nks]
GO
/****** Object:  StoredProcedure [dbo].[CalculateDistance]    Script Date: 7/23/2024 9:48:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CalculateDistance]
    @User_Lattitude FLOAT,
    @User_loggitude FLOAT,
    @Supplier_Lattitude FLOAT,
    @Supplier_Loggitude FLOAT
AS
BEGIN
    DECLARE @earthradius FLOAT;
    DECLARE @def_lattitude FLOAT;
    DECLARE @def_loggitude FLOAT;
    DECLARE @a FLOAT;
    DECLARE @c FLOAT;
    DECLARE @distance_km FLOAT;

    -- Earth's radius in kilometers
    SET @earthradius = 6371;

    -- Convert differences in coordinates to radians
    SET @def_lattitude = RADIANS(@Supplier_Lattitude - @User_Lattitude);
    SET @def_loggitude = RADIANS(@Supplier_Loggitude - @User_loggitude);

    -- Haversine formula
    SET @a = SIN(@def_lattitude / 2) * SIN(@def_lattitude / 2) +
             COS(RADIANS(@User_Lattitude)) * COS(RADIANS(@Supplier_Lattitude)) *
             SIN(@def_loggitude / 2) * SIN(@def_loggitude / 2);

    SET @c = 2 * ATN2(SQRT(@a), SQRT(1 - @a));

    -- Calculate the distance in kilometers
    SET @distance_km = @earthradius * @c;

    -- Return the calculated distance
    SELECT @distance_km AS DistanceInKilometers;
END;

