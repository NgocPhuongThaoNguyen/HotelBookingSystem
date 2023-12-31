USE [HotelReservierung]
GO
/****** Object:  StoredProcedure [dbo].[sp_add_bestellung_fur_reservierungID]    Script Date: 23.03.2023 15:19:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[sp_add_bestellung_fur_reservierungID]
	@ReservierungID int,
	@Datum date,
	@Order NVARCHAR(50),     -- string of 1 or more combinations of artikelID und Menge, eg, zwei Bier = '6,2' 
							-- eg, zwei Bier und Bratwürst = '6,2,8,1' 
	@Kommentar NVARCHAR(50),
    --
	@Feedback nvarchar(MAX) OUTPUT,
	@Erfolg BIT OUTPUT
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY

		-- create temporary table to hold artikel und menge info
		CREATE TABLE #table_artikel_menge (
			column_list INT
		)
		INSERT INTO #table_artikel_menge (column_list)
		SELECT * FROM String_Split(@Order, ',');
		-- add column to easily select later!!
	     ALTER TABLE #table_artikel_menge ADD testcolumn int IDENTITY(1,1) not null;


		-- add new row in Bestellung:
		INSERT INTO [dbo].[tb_Bestellung]
			   (ReservierenID, Datum, Kommentar)
		VALUES (@ReservierungID, @Datum, @Kommentar);
	
		-- get latest Bestellung ID
					DECLARE @BestellungID INT = (
						SELECT TOP 1 BestellungID
						FROM tb_Bestellung
						ORDER BY BestellungID DESC
					)

		-- extract ArtikelID und Menge, and insert info		
		DECLARE @NumberOfRows INT = (
			SELECT COUNT(column_list)
			FROM #table_artikel_menge 
		)
		DECLARE @NumberOfArtikels INT
		SET @NumberOfArtikels = @NumberOfRows / 2

		-- loop uber jede artikel, und speicher info in tb_Artikel_Bestellung
		DECLARE @cnt INT = 1;
		WHILE @cnt < @NumberOfArtikels+1
			BEGIN
					-- get artikelID und MENGE  
					DECLARE @ArtikelID INT = (
						SELECT column_list FROM #table_artikel_menge
					    WHERE testcolumn = (@cnt*2)-1
					) 

					DECLARE @Menge INT = (
						SELECT column_list FROM #table_artikel_menge
						WHERE testcolumn = (@cnt*2)
					) 

					-- speicher info
					INSERT INTO [dbo].[tb_Artikel_Bestellung]
						([ArtikelID],[BestellungID],[Menge])
					VALUES (@ArtikelID, @BestellungID, @Menge);
	
			SET @cnt = @cnt + 1;
		END;
		
		SET @Erfolg = 1;
		SET @Feedback = 'Bestellung erfolgreich!';
	
	END TRY
	BEGIN CATCH	
		SET @Feedback = ERROR_MESSAGE() + CHAR(10)-- Zeilenumbruch
						+ 'Fehler Nr. ' + CONVERT(varchar, ERROR_NUMBER()) + CHAR(10)
						+ 'Prozedur: '  + ERROR_PROCEDURE() + CHAR(10)
						+ 'Zeile Nr.: ' + CONVERT(varchar,  ERROR_LINE());	
		SET @Erfolg = 0;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_AddKunden]    Script Date: 23.03.2023 15:19:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <21.03.2023>
-- Description:	<Add Kunden>
-- =============================================
CREATE    PROCEDURE [dbo].[sp_AddKunden]
	@Vorname NVARCHAR(50),
	@Nachname NVARCHAR(50),
	@AusweisID NVARCHAR(50),
	@Gender bit,
	@Ort	NVARCHAR(50),
	@PLZ	CHAR(5),
	@Land	NVARCHAR(50),
	@Strasse	NVARCHAR(50),
	@Hausnr		NVARCHAR(50),
	@Telefone	NVARCHAR(50),
	@Email	NVARCHAR(50),
	@GebDat	DATE,
	@Kommentar nvarchar(MAX),
	-----
	@Erfolg bit OUTPUT, -- geklappt oder nicht
	@Feedback VARCHAR(MAX) OUTPUT -- Fehlermeldungen etc.
AS
BEGIN	
	SET NOCOUNT ON;	
	DECLARE @CheckResult AS INT
	DECLARE @msg AS NVARCHAR(MAX)
	DECLARE @KundenNr int = (
		SELECT MAX(KundenNR) +1
		FROM [dbo].[tb_Kunden]
	) 

	IF @KundenNr is NULL
		SET @KundenNr = 1

	BEGIN TRY
		-- @ProjektID existiert und ist nicht abgeschlossen
		SET @CheckResult = [dbo].[sf_IstKundenExistiert](@Vorname, @Nachname, @AusweisID, @GebDat)
		
		IF @CheckResult = 0
			BEGIN
				INSERT INTO dbo.tb_Kunden 
				VALUES(@KundenNr, @Vorname, @Nachname, @AusweisID, @Gender, @Ort, @PLZ, @Land, @Strasse, @Hausnr, @Telefone, @Email, @GebDat, @Kommentar)			
				SET @Erfolg = 0;
				SET @Feedback = 'Kunde neu angelegt!';
			END
		
		IF @CheckResult = 1
			BEGIN
				set @msg = 'Kunden existiert, bitte KundenID suchen!';
				THROW 50001, @msg , 1;
			END
	END TRY 
	BEGIN CATCH
		SET @Erfolg = 1; -- nicht geklappt--
		SET @Feedback = ERROR_MESSAGE()
	END CATCH; 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Backup_HotelReservierung_mit_NeueOrdner]    Script Date: 23.03.2023 15:19:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <22.03.2023>
-- Description:	<BACKUP ALLDB HotelReservierung>
-- =============================================
CREATE    PROCEDURE [dbo].[sp_Backup_HotelReservierung_mit_NeueOrdner]
	 @path nvarchar(256),  -- path for backup files
	 ------------------
	 @Erfolg bit OUTPUT, -- geklappt oder nicht
	 @Feedback VARCHAR(MAX) OUTPUT -- Fehlermeldungen etc.
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
	DECLARE @dbname NVARCHAR(MAX); -- database name
	DECLARE @backupFile NVARCHAR(MAX); -- file name
	--DECLARE @fullDBBackupName NVARCHAR(MAX);
	------------------------------------------------------
	BEGIN TRY	
			
		DECLARE @t TABLE (FileExists int, FileIsDir int, ParentDirExists int);
		INSERT INTO @t EXEC master.dbo.xp_fileexist @path; -- Ordner prüfen
	
		IF (SELECT FileExists FROM @t) = 1 --Pfad ist Datei
		BEGIN 
			-- TODO: testen letzte position = '\'
			-- Abbrechen, Fehlermeldung
			PRINT 'Pfad ist eine Datei';
			THROW 50100, 'Pfad ist eine Datei', 1 -- TODO Fehlermeldung verbessern
		END	
		-- Ordner existiert nicht und ist keine Datei
		IF (SELECT FileIsDir FROM @t) = 0  AND (SELECT FileExists FROM @t) = 0 
		BEGIN		
			-- testen ob die Festplatte existiert
			DECLARE @driveTable TABLE (DRIVE char, MBfrei int);
			INSERT INTO @driveTable EXEC master.sys.xp_fixeddrives; 
			-- nur die Festplatten, ohne USB 

			DECLARE @Drive char = LEFT(@path, 1);
			IF @Drive NOT IN (SELECT DRIVE FROM @driveTable) 
			-- die Festplatte existiert nicht
			BEGIN
				DECLARE @msg nvarchar (50);
				SET @msg = 'Festplate '  + @Drive + ' existiert nicht';
				THROW 50101, @msg, 1; 
			END -- die Festplatte existiert nicht
		
			---- Ordner erstellen, wenn nicht existiert 	
			EXEC master.dbo.xp_create_subdir @path -- Ordner erstellen
    	END --  Ordner existiert nicht und ist keine Datei
		-- TODO: Zugriffsrechte überprüfen
		-- TODO: Freie Platz überprüfen
		SET @backupFile = @path + [dbo].[sf_Zeitstempel]() +'HotelReservierung-' +  '.bak';
   
		BACKUP DATABASE [HotelReservierung] TO DISK = @backupFile
		--SET @backupFile = @dbname + '-' +  [dbo].[sf_Zeitstempel]()  + '.bak'	
		-----------------------------------------------
		SET @Erfolg = 1;
		SET @Feedback = 'Alles OK!';
	END TRY
	BEGIN CATCH
		SET @Erfolg = 0; -- nicht geklappt--
		-- 	@Feedback text OUTPUT --Fehlermeldungen etc.
		SET @Feedback = 
			ERROR_MESSAGE() + ' Fehler Nr. ' + CONVERT(varchar, ERROR_NUMBER())
							+ ' Prozedur: '  + ERROR_PROCEDURE()
							+ ' Zeile Nr.: ' + CONVERT(varchar,  ERROR_LINE());
	END CATCH;  			
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Backup_HotelReservierung_mit_Zeitstempel_und_Param_OutputUndFehlermeldung]    Script Date: 23.03.2023 15:19:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <22.03.2023>
-- Description:	<Backup Hotel Reservierung mit Zeitstempel und Param_OutputUndFehlermeldung>
-- =============================================
CREATE    PROCEDURE [dbo].[sp_Backup_HotelReservierung_mit_Zeitstempel_und_Param_OutputUndFehlermeldung]
	@Pfad nvarchar(MAX),	-- Parameter 1,--@Pfad soll so aussehen: 'C:\SQL-Kurs\99-HotelReservierung\Backup' 
	@Feedback nvarchar(MAX) OUTPUT -- Parameter 2
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
	
		DECLARE @backupFile NVARCHAR(MAX); -- file name
		SET @backupFile = @Pfad + 
						  'HotelReservierung-' + [dbo].[sf_Zeitstempel]() + '.bak';
   
		BACKUP DATABASE [HotelReservierung] TO DISK = @backupFile;
		SET @Feedback = CHAR(10) + 'Alles OK!';
	END TRY
	BEGIN CATCH	
		
		SET @Feedback = ERROR_MESSAGE() + CHAR(10)-- Zeilenumbruch
						+ 'Fehler Nr. ' + CONVERT(varchar, ERROR_NUMBER()) + CHAR(10)
						+ 'Prozedur: '  + ERROR_PROCEDURE() + CHAR(10)
						+ 'Zeile Nr.: ' + CONVERT(varchar,  ERROR_LINE());	

	END CATCH
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_reservierung_bestandskunde]    Script Date: 23.03.2023 15:19:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[sp_reservierung_bestandskunde] 
	@KundenNr int,
	@CheckIn datetime,
	@CheckOut datetime,
	@AnzahlZimmer smallint,
	@AnzahlPerson smallint,
	@PersonalNr int,
	@TypName NVARCHAR(50),
	@Kommentar NVARCHAR(50),
	@Feedback nvarchar(MAX) OUTPUT,
	@Erfolg BIT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @CheckKunde BIT;
		DECLARE @CheckZimmer BIT;
		DECLARE @msg AS nvarchar(MAX);

		DECLARE @KundenID int = (
			SELECT KundenID
			FROM
				[dbo].[tb_Kunden]
			WHERE [dbo].[tb_Kunden].[KundenNr] = @KundenNr
		
		)  ; 

		DECLARE @ZimmerTypID int = (
			SELECT DISTINCT [ZimmerTypID]
			FROM [dbo].[tb_ZimmerTyp]
			WHERE [TypName] = @TypName
		)

		IF @KundenID is NULL --Kunde existiert nicht
			THROW 50001, 'Kunde existiert nicht, bitte neue Kunde_in anlegen!', 1;

		SET @CheckZimmer = [dbo].[sf_Check_Anzahl_Zimmer](
													@AnzahlPerson,
													@AnzahlZimmer,
													@ZimmerTypID
												);
		
		IF @CheckZimmer = 0 -- zu Viele Personen
			BEGIN
				SET @msg = 'Zuviele Personen für die Anzahl der Zimmer vom Typ ' + @TypName + '!';
				THROW 50002, @msg , 1;
			END

		SET @CheckZimmer = [dbo].[sf_Check_Zimmer_frei](
													@CheckIn,
													@CheckOut,
													@AnzahlZimmer,
													@TypName
												);
		
		IF @CheckZimmer = 0 -- nicht genug Zimmer frei
			BEGIN
				SET @msg = 'Nicht genug Zimmer vom Typ ' + @TypName + 'frei!';
				THROW 50003, @msg , 1;
			END
		--DECLARE @i int = 0
		--WHILE @i < 300 
		--BEGIN
		--	SET @i = @i + 1
		--	/* your code*/
		--END
		DECLARE @status NVARCHAR(20) = [dbo].[sf_reservierungs_status](
																	@CheckIn,
																	@CheckOut
																	)
		

		--DECLARE @KundenID int = (
		--	SELECT DISTINCT [KundenID]
		--	FROM [dbo].[tb_Kunden]
		--	WHERE [KundenID] = @KundenNr
		--)

		DECLARE @PersonalID int = (
			SELECT DISTINCT PersonalID
			FROM [dbo].[tb_Personal]
			WHERE [dbo].[tb_Personal].[PersonalNr] = @PersonalNr
		)

		INSERT INTO [dbo].[tb_Reservierung] 
			   (ZimmerTypID, KundenID, PersonalID,  Datum,  
			   Status, AnzahlPerson, AnzahlZimmer, CheckIn, CheckOut, Kommentar)
		VALUES (@ZimmerTypID, @KundenID, @PersonalID,  CURRENT_TIMESTAMP,  
			   @status, @AnzahlPerson, @AnzahlZimmer, @CheckIn, @CheckOut, @Kommentar);		
	
		SET @Erfolg = 1;
		
		SET @Feedback = 'Reservierung erfolgreich!';

	END TRY
	BEGIN CATCH	
		SET @Feedback = ERROR_MESSAGE() + CHAR(10)-- Zeilenumbruch
						+ 'Fehler Nr. ' + CONVERT(varchar, ERROR_NUMBER()) + CHAR(10)
						+ 'Prozedur: '  + ERROR_PROCEDURE() + CHAR(10)
						+ 'Zeile Nr.: ' + CONVERT(varchar,  ERROR_LINE());	
		SET @Erfolg = 0;
	END CATCH
	


END
GO
