USE [HotelReservierung]
GO
/****** Object:  UserDefinedFunction [dbo].[tf_All_free_rooms_ofType_von_bis_days]    Script Date: 23.03.2023 15:21:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE     FUNCTION [dbo].[tf_All_free_rooms_ofType_von_bis_days]
(	
	@DatumVon datetime,
	@DatumBis datetime,	
	@Type NVARCHAR(50)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT DISTINCT--TOP (100) PERCENT 
	--  dbo.tb_Reservierung.ReservierenID
	--, dbo.tb_Kunden.Vorname
	--, dbo.tb_Kunden.Nachname
	--, dbo.tb_Reservierung.CheckIn
	--, dbo.tb_Reservierung.CheckOut
	--, dbo.tb_ZimmerTyp.TypName
	--, dbo.tb_Zimmer.ZimmerNr
		dbo.tb_Zimmer.ZimmerID AS ZimmerID
		FROM        dbo.tb_Kunden INNER JOIN
					dbo.tb_Reservierung ON dbo.tb_Kunden.KundenID = dbo.tb_Reservierung.KundenID INNER JOIN
					dbo.tb_Reservieren_Zimmer ON dbo.tb_Reservierung.ReservierenID = dbo.tb_Reservieren_Zimmer.ReservierenID RIGHT JOIN
					dbo.tb_Zimmer ON dbo.tb_Reservieren_Zimmer.ZimmerID = dbo.tb_Zimmer.ZimmerID INNER JOIN
					dbo.tb_ZimmerTyp ON dbo.tb_Zimmer.ZimmerTypID = dbo.tb_ZimmerTyp.ZimmerTypID LEFT JOIN
					dbo.tb_ZimmerTyp AS tb_ZimmerTyp_1 ON dbo.tb_Reservierung.ZimmerTypID = tb_ZimmerTyp_1.ZimmerTypID
		WHERE   ((dbo.tb_Reservierung.Datum IS NULL)
				--OR ((cast(dbo.tb_Reservierung.CheckIn AS DATE) NOT BETWEEN @DatumVon AND @DatumBis)
				--	AND (cast(dbo.tb_Reservierung.CheckOut AS DATE) NOT BETWEEN @DatumVon and @DatumBis)))
				OR ((dbo.tb_Reservierung.CheckIn NOT BETWEEN @DatumVon AND @DatumBis)
					AND (dbo.tb_Reservierung.CheckOut  NOT BETWEEN @DatumVon and @DatumBis)))
				AND (dbo.tb_Zimmer.IstVerfügbar <> 0) 
				AND (dbo.tb_ZimmerTyp.TypName = @Type)
		--ORDER BY dbo.tb_ZimmerTyp.TypName
)
GO
