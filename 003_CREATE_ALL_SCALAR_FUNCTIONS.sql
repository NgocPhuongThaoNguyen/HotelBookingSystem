USE [HotelReservierung]
GO
/****** Object:  UserDefinedFunction [dbo].[sf_Check_Anzahl_Zimmer]    Script Date: 23.03.2023 15:20:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE   FUNCTION [dbo].[sf_Check_Anzahl_Zimmer]
(
	-- Add the parameters for the function here
	@Anz_Pers int,
	@Anz_Zim int,
	@ZimmerTypID int
)
RETURNS BIT
AS
BEGIN
	-- Add the T-SQL statements to compute the return value here
	DECLARE @Check BIT;
	DECLARE @Anz_Pers_Zim int;
	SET @Anz_Pers_Zim = (
		SELECT AnzahlPerson
		FROM [dbo].[tb_ZimmerTyp]
		WHERE [dbo].[tb_ZimmerTyp].[ZimmerTypID]= @ZimmerTypID
	)
	SET @Check= (
		CASE
		WHEN @Anz_Pers_Zim*@Anz_Zim >= @Anz_Pers THEN 1
		ELSE 0
		END
	)
	RETURN @Check
END
GO
/****** Object:  UserDefinedFunction [dbo].[sf_Check_Zimmer_frei]    Script Date: 23.03.2023 15:20:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Alexander,,Kramer>
-- Create date: <21.03.2023,,>
-- Description:	<Description,,>
-- =============================================
CREATE   FUNCTION [dbo].[sf_Check_Zimmer_frei]
(
	@check_in datetime,
	@check_out datetime,
	@Anzahl_Zimmer int,
	@TypName NVARCHAR(50)
)
RETURNS BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

    -- Insert statements for procedure here	
	
	DECLARE @freieZimmer int;
	SET @freieZimmer = (
		SELECT COUNT(ZimmerID)
		FROM [dbo].[tf_All_free_rooms_ofType_von_bis_days](
			@check_in,
			@check_out,
			TRIM(@TypName)
		)
	)
	DECLARE @ValidRequest bit;
	SET @ValidRequest= (
	CASE
		WHEN @freieZimmer >= @Anzahl_Zimmer THEN 1
		ELSE 0
	END
	)

	--RETURN @ValidRequest
	RETURN @ValidRequest
END
GO
/****** Object:  UserDefinedFunction [dbo].[sf_date_overlap]    Script Date: 23.03.2023 15:20:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE   FUNCTION [dbo].[sf_date_overlap]
(
	-- Add the parameters for the function here
	@check_in1 date,
	@check_out1 date,
	@check_in2 date,
	@check_out2 date
)
RETURNS Bit
AS
BEGIN
	-- Add the T-SQL statements to compute the return value here
	DECLARE @overlap Bit;
	SET @overlap= (
		CASE
			WHEN @check_out2 <= @check_in1 THEN 0
			WHEN @check_in2 >= @check_out1 THEN 0			
			ELSE 1
		END
	)
	RETURN @overlap
END
GO
/****** Object:  UserDefinedFunction [dbo].[sf_GetAge]    Script Date: 23.03.2023 15:20:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Thao Nguyen
-- Create date: 22.03.2023
-- Description:	diese Funktion berechnet Alter
-- =============================================
CREATE   FUNCTION [dbo].[sf_GetAge] 
(
	@GebDat date
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Age int;
	DECLARE @Heute date;
	SET @Heute = GETDATE();
		
	IF (MONTH(@GebDat) > MONTH(@Heute)) -- Geburtsmonat erst später
		SET @Age = DATEDIFF(YEAR, @GebDat, @Heute) - 1 -- ist noch nich so alt
	ELSE IF (MONTH(@GebDat) = MONTH(@Heute) AND DAY(@GebDat) > DAY(@Heute))
		SET @Age = DATEDIFF(YEAR, @GebDat, @Heute) - 1 -- ist noch nich so alt
	ELSE SET @Age = DATEDIFF(YEAR, @GebDat, @Heute);

	-- Return the result of the function
	RETURN @Age;

END
GO
/****** Object:  UserDefinedFunction [dbo].[sf_IstKundenExistiert]    Script Date: 23.03.2023 15:20:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <21.03.2023>
-- Description:	<Check Kunden Exsiert im tb_Kunden>
-- =============================================
CREATE    FUNCTION [dbo].[sf_IstKundenExistiert] 
(
	-- Add the parameters for the function here
	@Vorname NVARCHAR(50),
	@Nachname NVARCHAR(50),
	@AusweisID NVARCHAR(50),
	--@Gender bit,
	--@Ort	NVARCHAR(50),
	--@PLZ	CHAR(5),
	--@Land	NVARCHAR(50),
	--@Strasse	NVARCHAR(50),
	--@Hausnr		NVARCHAR(50),
	--@Telefone	NVARCHAR(50),
	--@Email	NVARCHAR(50),
	@GebDat	DATE
	--@Kommentar nvarchar(MAX)
)
RETURNS bit
AS
BEGIN
	DECLARE @Ergebnis bit;
	SET @Ergebnis =  (select COUNT(*)
		from tb_Kunden
		where (tb_Kunden.Vorname = @Vorname) AND (tb_Kunden.Nachname = @Nachname) AND (tb_Kunden.AusweisID = @AusweisID) AND (tb_Kunden.GebDat = @GebDat))
	
	-- Return the result of the function
	RETURN @Ergebnis;

END
GO
/****** Object:  UserDefinedFunction [dbo].[sf_Kosten_Bestellung_Reservierung]    Script Date: 23.03.2023 15:20:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE   FUNCTION [dbo].[sf_Kosten_Bestellung_Reservierung]
(
	-- Add the parameters for the function here
	@ReservierenID int
)
RETURNS money
AS
BEGIN
	-- Add the T-SQL statements to compute the return value here
	DECLARE @Kosten money;
	SET @Kosten= (
		SELECT 
			SUM(-1*[dbo].[tb_Artikel].[Kosten]*[dbo].[tb_Artikel_Bestellung].[Menge]) as 'Kosten'
			FROM 
				[dbo].[tb_Reservierung]
			INNER JOIN [dbo].[tb_Bestellung]
			ON [dbo].[tb_Reservierung].[ReservierenID]= [dbo].[tb_Bestellung].[ReservierenID] AND
				[dbo].[tb_Reservierung].[ReservierenID]=@ReservierenID
			INNER JOIN [dbo].[tb_Artikel_Bestellung]
			ON [dbo].[tb_Bestellung].[BestellungID] =  [dbo].[tb_Artikel_Bestellung].[BestellungID]
			INNER JOIN [dbo].[tb_Artikel]
			ON [dbo].[tb_Artikel_Bestellung].[ArtikelID]= [dbo].[tb_Artikel].[ArtikelID]
		GROUP BY [dbo].[tb_Reservierung].[ReservierenID]
	)
	IF @Kosten is NULL
		SET @Kosten =0;
	RETURN @Kosten
END
GO
/****** Object:  UserDefinedFunction [dbo].[sf_Kosten_Reservierung]    Script Date: 23.03.2023 15:20:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE   FUNCTION [dbo].[sf_Kosten_Reservierung]
(
	-- Add the parameters for the function here
	@ReservierenID int
)
RETURNS money
AS
BEGIN
	

	-- Add the T-SQL statements to compute the return value here
	DECLARE @Kosten money;
	
	SET @Kosten= (SELECT 
			--[dbo].[tb_Reservierung].[ReservierenID],
			--MAX(datediff(DAY ,[dbo].[tb_Reservierung].[CheckIn], [dbo].[tb_Reservierung].[CheckOut])) as 'Tage',
			SUM(-1*[dbo].[tb_ZimmerTyp].[Kosten])*MAX(datediff(DAY ,[dbo].[tb_Reservierung].[CheckIn], [dbo].[tb_Reservierung].[CheckOut])) as 'Kosten'
			FROM 
				[dbo].[tb_Reservierung]
			INNER JOIN [dbo].[tb_Reservieren_Zimmer]
			ON [dbo].[tb_Reservierung].[ReservierenID]= [dbo].[tb_Reservieren_Zimmer].[ReservierenID] AND
			   [dbo].[tb_Reservierung].[ReservierenID]=@ReservierenID
		
			INNER JOIN [dbo].[tb_Zimmer]
			ON [dbo].[tb_Zimmer].[ZimmerID] =  [dbo].[tb_Reservieren_Zimmer].[ZimmerID]
			INNER JOIN [dbo].[tb_ZimmerTyp]
			ON [dbo].[tb_ZimmerTyp].[ZimmerTypID]= [dbo].[tb_Zimmer].[ZimmerTypID]
	GROUP BY [dbo].[tb_Reservierung].[ReservierenID])
	IF @Kosten is NULL
		SET @Kosten =0;
	RETURN @Kosten

END
GO
/****** Object:  UserDefinedFunction [dbo].[sf_reservierungs_status]    Script Date: 23.03.2023 15:20:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE   FUNCTION [dbo].[sf_reservierungs_status] 
(
	@check_in datetime,
	@check_out datetime
)
RETURNS nvarchar(20)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @status nvarchar(20)=
	(CASE
		WHEN CAST(GETDATE() AS DATE) BETWEEN CAST(@check_in AS DATE) AND CAST(@check_out AS DATE) THEN 'aktuell'
		WHEN CAST(GETDATE() AS DATE) < CAST(@check_in AS DATE)  THEN 'zukünftig'
		WHEN CAST(GETDATE() AS DATE) > CAST(@check_out AS DATE) THEN 'abgeschlossen'
	END
	);

	RETURN @status

END
GO
/****** Object:  UserDefinedFunction [dbo].[sf_Saldo_Reservierung]    Script Date: 23.03.2023 15:20:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE   FUNCTION [dbo].[sf_Saldo_Reservierung]
(
	-- Add the parameters for the function here
	@ReservierenID int
)
RETURNS money
AS
BEGIN
	-- Add the T-SQL statements to compute the return value here
	DECLARE @Saldo money;
	SET @Saldo= dbo.sf_Kosten_Reservierung(@ReservierenID) + 
				dbo.sf_Kosten_Bestellung_Reservierung(@ReservierenID) +
				[dbo].[sf_Zahlungen_Reservierung](@ReservierenID)
	RETURN @Saldo
END
GO
/****** Object:  UserDefinedFunction [dbo].[sf_Zahlungen_Reservierung]    Script Date: 23.03.2023 15:20:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE    FUNCTION [dbo].[sf_Zahlungen_Reservierung]
(
	-- Add the parameters for the function here
	@ReservierenID int
)
RETURNS money
AS
BEGIN
	-- Add the T-SQL statements to compute the return value here
	DECLARE @Zahlungen money;
	SET @Zahlungen= (SELECT 
			SUM([dbo].[tb_Zahlung].[Betrag]) AS 'Zahlungen'
			FROM 
				[dbo].[tb_Reservierung]
			INNER JOIN [dbo].[tb_Zahlung]
			ON [dbo].[tb_Reservierung].[ReservierenID]= [dbo].[tb_Zahlung].[ReservierenID] AND
			   [dbo].[tb_Reservierung].[ReservierenID]=@ReservierenID
		
	GROUP BY [dbo].[tb_Reservierung].[ReservierenID])
	IF @Zahlungen is NULL
		SET @Zahlungen =0;
	RETURN @Zahlungen
END
GO
/****** Object:  UserDefinedFunction [dbo].[sf_Zeitstempel]    Script Date: 23.03.2023 15:20:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <22.03.2023>
-- Description:	<Diese Funktion generiert so was: 20231003-105151150>
-- =============================================
CREATE   FUNCTION [dbo].[sf_Zeitstempel] 
(
	
)
RETURNS Char(18)
AS
BEGIN

	RETURN FORMAT(Getdate(),'yyyyMMdd-HHmm')

END
GO
