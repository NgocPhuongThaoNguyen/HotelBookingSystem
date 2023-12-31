USE [HotelReservierung]
GO
/****** Object:  View [dbo].[ab_bestellungen_pro_tag]    Script Date: 23.03.2023 15:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Bestellungen inklusive Details pro Tag für jede Reservierung zeigen

CREATE   VIEW [dbo].[ab_bestellungen_pro_tag]
AS
SELECT        TOP (100) PERCENT dbo.tb_Kunden.KundenNr, dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_Bestellung.ReservierenID, dbo.tb_Bestellung.Datum, dbo.tb_Artikel_Bestellung.BestellungID, dbo.tb_Artikel.Name, 
                         dbo.tb_Artikel_Bestellung.Menge, dbo.tb_Artikel.Kosten AS ArtikelKosten
FROM            dbo.tb_Reservierung INNER JOIN
                         dbo.tb_Bestellung ON dbo.tb_Reservierung.ReservierenID = dbo.tb_Bestellung.ReservierenID INNER JOIN
                         dbo.tb_Artikel_Bestellung ON dbo.tb_Bestellung.BestellungID = dbo.tb_Artikel_Bestellung.BestellungID INNER JOIN
                         dbo.tb_Artikel ON dbo.tb_Artikel_Bestellung.ArtikelID = dbo.tb_Artikel.ArtikelID INNER JOIN
                         dbo.tb_Kunden ON dbo.tb_Reservierung.KundenID = dbo.tb_Kunden.KundenID
GROUP BY dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_Bestellung.ReservierenID, dbo.tb_Bestellung.Datum, dbo.tb_Artikel_Bestellung.BestellungID, dbo.tb_Artikel_Bestellung.Menge, dbo.tb_Artikel.Name, 
                         dbo.tb_Artikel.Kosten, dbo.tb_Kunden.KundenNr
ORDER BY dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_Bestellung.Datum DESC
GO
/****** Object:  View [dbo].[ab_bilanz_kunde]    Script Date: 23.03.2023 15:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- hier wird ein Saldo (Differenz zwischen bezahlter un zu zahlender Summe) für jede Reservierung gezeigt

CREATE   VIEW [dbo].[ab_bilanz_kunde]
AS
SELECT        dbo.tb_Reservierung.ReservierenID, dbo.tb_Kunden.Vorname, dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Land, dbo.tb_Kunden.Ort, dbo.tb_Kunden.PLZ, dbo.tb_Reservierung.AnzahlPerson, dbo.tb_Reservierung.AnzahlZimmer, 
                         dbo.tb_Reservierung.CheckIn, dbo.tb_Reservierung.CheckOut, dbo.tb_Personal.Vorname AS MA_Vorname, dbo.tb_Personal.Nachname AS MA_Nachname, dbo.sf_Saldo_Reservierung(dbo.tb_Reservierung.ReservierenID) 
                         AS Saldo
FROM            dbo.tb_Kunden INNER JOIN
                         dbo.tb_Reservierung ON dbo.tb_Kunden.KundenID = dbo.tb_Reservierung.KundenID INNER JOIN
                         dbo.tb_Personal ON dbo.tb_Reservierung.PersonalID = dbo.tb_Personal.PersonalID
GO
/****** Object:  View [dbo].[ab_kunden_alter]    Script Date: 23.03.2023 15:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Kunden Alter zeigen

CREATE   VIEW [dbo].[ab_kunden_alter]
AS
SELECT DISTINCT TOP(100)  
	--dbo.tb_Reservierung.ReservierenID, 
	--dbo.tb_ZimmerTyp.TypName AS [Zimmer Typ], 
	dbo.tb_Kunden.KundenNr,
	dbo.tb_Kunden.Nachname, 
	dbo.tb_Kunden.Vorname, 
	dbo.tb_Kunden.Gender, 
	dbo.tb_Kunden.Land, 
	dbo.tb_Kunden.GebDat, 
	dbo.sf_GetAge(dbo.tb_Kunden.GebDat) AS [Alter]
FROM        
	dbo.tb_Kunden INNER JOIN
    dbo.tb_Reservierung ON dbo.tb_Kunden.KundenID = dbo.tb_Reservierung.KundenID 
ORDER BY  KundenNr 
GO
/****** Object:  View [dbo].[ab_kunden_anzahl_res_pro_ZimmerTyp]    Script Date: 23.03.2023 15:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[ab_kunden_anzahl_res_pro_ZimmerTyp]
AS
SELECT        TOP (100) PERCENT dbo.tb_Kunden.KundenNr, dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, COUNT(dbo.tb_Reservierung.ZimmerTypID) AS Anzahl_Res_ZimmerTyp, dbo.tb_ZimmerTyp.TypName
FROM            dbo.tb_Kunden INNER JOIN
                         dbo.tb_Reservierung ON dbo.tb_Kunden.KundenID = dbo.tb_Reservierung.KundenID INNER JOIN
                         dbo.tb_ZimmerTyp ON dbo.tb_Reservierung.ZimmerTypID = dbo.tb_ZimmerTyp.ZimmerTypID
GROUP BY dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_ZimmerTyp.TypName, dbo.tb_Kunden.KundenNr
ORDER BY dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname
GO
/****** Object:  View [dbo].[ab_kunden_anzahl_reservierungen]    Script Date: 23.03.2023 15:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Anzahl der Reservierungen pro Kunde anzeigen*/
CREATE   VIEW [dbo].[ab_kunden_anzahl_reservierungen]
AS
SELECT        TOP (100) PERCENT dbo.tb_Kunden.KundenNr, dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, COUNT(dbo.tb_Reservierung.ReservierenID) AS Anzahl_Res
FROM            dbo.tb_Kunden INNER JOIN
                         dbo.tb_Reservierung ON dbo.tb_Kunden.KundenID = dbo.tb_Reservierung.KundenID
GROUP BY dbo.tb_Kunden.KundenNr, dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname
ORDER BY dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname DESC
GO
/****** Object:  View [dbo].[ab_reservierung_aktiv]    Script Date: 23.03.2023 15:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- alle derzeit aktive Reservierungen zeigen

CREATE   VIEW [dbo].[ab_reservierung_aktiv]
AS
SELECT DISTINCT 
                         TOP (100) PERCENT dbo.tb_Reservierung.Status, dbo.tb_Kunden.KundenNr, dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_Reservierung.AnzahlPerson, dbo.tb_Reservierung.AnzahlZimmer, 
                         dbo.tb_Reservierung.CheckIn, dbo.tb_Reservierung.CheckOut
FROM            dbo.tb_Reservierung INNER JOIN
                         dbo.tb_Kunden ON dbo.tb_Reservierung.KundenID = dbo.tb_Kunden.KundenID INNER JOIN
                         dbo.tb_ZimmerTyp ON dbo.tb_Reservierung.ZimmerTypID = dbo.tb_ZimmerTyp.ZimmerTypID INNER JOIN
                         dbo.tb_Zimmer ON dbo.tb_ZimmerTyp.ZimmerTypID = dbo.tb_Zimmer.ZimmerTypID
WHERE        (dbo.tb_Reservierung.Status = N'aktuell')
ORDER BY dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_Reservierung.AnzahlPerson DESC, dbo.tb_Reservierung.CheckIn DESC
GO
/****** Object:  View [dbo].[ab_reservierung_details]    Script Date: 23.03.2023 15:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- hiermit werden Details über jede Reservierung mitgeliefert: Name der Mitarbeiter, 
-- der diese Buchung genommen hat, Name der Kunde, alle Infos zur Buchung: Datum (Reservierung, Checkin, Checkout), Zimmernummern etc

CREATE   VIEW [dbo].[ab_reservierung_details]
AS
SELECT        dbo.tb_Reservierung.ReservierenID, dbo.tb_Personal.Nachname AS MA_NN, dbo.tb_Reservierung.Datum, dbo.tb_Kunden.Nachname AS Kunde_NN, dbo.tb_Reservierung.CheckIn, dbo.tb_Reservierung.CheckOut, 
                         dbo.tb_Reservierung.AnzahlPerson AS Anzahl_Gäste, dbo.tb_ZimmerTyp.TypName AS ZimmerTyp, dbo.tb_Zimmer.Detail, dbo.tb_Zimmer.ZimmerNr, dbo.tb_Zimmer.Kommentar
FROM            dbo.tb_Reservierung INNER JOIN
                         dbo.tb_Personal ON dbo.tb_Reservierung.PersonalID = dbo.tb_Personal.PersonalID INNER JOIN
                         dbo.tb_ZimmerTyp ON dbo.tb_Reservierung.ZimmerTypID = dbo.tb_ZimmerTyp.ZimmerTypID INNER JOIN
                         dbo.tb_Zimmer ON dbo.tb_ZimmerTyp.ZimmerTypID = dbo.tb_Zimmer.ZimmerTypID INNER JOIN
                         dbo.tb_Kunden ON dbo.tb_Reservierung.KundenID = dbo.tb_Kunden.KundenID
GO
/****** Object:  View [dbo].[ab_reservierungen_abgeschlossen]    Script Date: 23.03.2023 15:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Abgeschlossene Reservierungen zeigen

CREATE   VIEW [dbo].[ab_reservierungen_abgeschlossen]
AS
SELECT        TOP (100) PERCENT dbo.tb_Reservierung.ReservierenID, dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_Reservierung.CheckIn, dbo.tb_Reservierung.CheckOut, dbo.tb_Reservierung.AnzahlPerson, 
                         dbo.tb_Reservierung.AnzahlZimmer, dbo.tb_ZimmerTyp.TypName, dbo.tb_Reservierung.Status
FROM            dbo.tb_Reservierung INNER JOIN
                         dbo.tb_Kunden ON dbo.tb_Reservierung.KundenID = dbo.tb_Kunden.KundenID INNER JOIN
                         dbo.tb_ZimmerTyp ON dbo.tb_Reservierung.ZimmerTypID = dbo.tb_ZimmerTyp.ZimmerTypID
WHERE        (dbo.tb_Reservierung.Status = N'Abgeschlossen')
ORDER BY dbo.tb_Reservierung.CheckIn, dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname
GO
/****** Object:  View [dbo].[ab_reservierungen_allg_info]    Script Date: 23.03.2023 15:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Hiermit werden allgemeine Infos für Reservierungen gezeigt: Name der Mitarbeiter, 
-- Infos über den Kunde (Name, Adresse, Kontaktdaten), Reservierungsnummer, Anzahl der Zimmer 

CREATE   VIEW [dbo].[ab_reservierungen_allg_info]
AS
SELECT        TOP (100) PERCENT dbo.tb_Personal.PersonalID AS MA_ID, dbo.tb_Personal.Nachname AS MA_NN, dbo.tb_Reservierung.ReservierenID, dbo.tb_Reservierung.Datum AS reserviert_am, COUNT(dbo.tb_Zimmer.ZimmerID) 
                         AS Anzahl_Zimmer, dbo.tb_ZimmerTyp.TypName, dbo.tb_Kunden.KundenID, dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_Kunden.Ort, dbo.tb_Kunden.PLZ, dbo.tb_Kunden.Land, dbo.tb_Kunden.GebDat, 
                         dbo.tb_Kunden.Telefone
FROM            dbo.tb_Personal INNER JOIN
                         dbo.tb_Reservierung ON dbo.tb_Personal.PersonalID = dbo.tb_Reservierung.PersonalID INNER JOIN
                         dbo.tb_Kunden ON dbo.tb_Reservierung.KundenID = dbo.tb_Kunden.KundenID INNER JOIN
                         dbo.tb_Reservieren_Zimmer ON dbo.tb_Reservierung.ReservierenID = dbo.tb_Reservieren_Zimmer.ReservierenID INNER JOIN
                         dbo.tb_Zimmer ON dbo.tb_Reservieren_Zimmer.ZimmerID = dbo.tb_Zimmer.ZimmerID INNER JOIN
                         dbo.tb_ZimmerTyp ON dbo.tb_Reservierung.ZimmerTypID = dbo.tb_ZimmerTyp.ZimmerTypID
GROUP BY dbo.tb_Personal.PersonalID, dbo.tb_Personal.Nachname, dbo.tb_Reservierung.Datum, dbo.tb_Kunden.KundenID, dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_Reservierung.ReservierenID, 
                         dbo.tb_ZimmerTyp.TypName, dbo.tb_Kunden.Ort, dbo.tb_Kunden.PLZ, dbo.tb_Kunden.Land, dbo.tb_Kunden.GebDat, dbo.tb_Kunden.Telefone
ORDER BY reserviert_am, dbo.tb_Kunden.Nachname
GO
/****** Object:  View [dbo].[ab_summe_kosten_bestellung]    Script Date: 23.03.2023 15:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Summe von jeder Bestellung am bestimmten Datum für jede Reservierung zeigen

CREATE   VIEW [dbo].[ab_summe_kosten_bestellung]
AS
SELECT        TOP (100) PERCENT dbo.tb_Kunden.KundenNr, dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_Bestellung.ReservierenID, SUM(dbo.tb_Artikel_Bestellung.Menge * dbo.tb_Artikel.Kosten) AS SumKosten, 
                         dbo.tb_Bestellung.Datum
FROM            dbo.tb_Reservierung INNER JOIN
                         dbo.tb_Bestellung ON dbo.tb_Reservierung.ReservierenID = dbo.tb_Bestellung.ReservierenID INNER JOIN
                         dbo.tb_Artikel_Bestellung ON dbo.tb_Bestellung.BestellungID = dbo.tb_Artikel_Bestellung.BestellungID INNER JOIN
                         dbo.tb_Artikel ON dbo.tb_Artikel_Bestellung.ArtikelID = dbo.tb_Artikel.ArtikelID INNER JOIN
                         dbo.tb_Kunden ON dbo.tb_Reservierung.KundenID = dbo.tb_Kunden.KundenID
GROUP BY dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_Bestellung.ReservierenID, dbo.tb_Bestellung.Datum, dbo.tb_Kunden.KundenNr
ORDER BY dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_Bestellung.Datum DESC
GO
/****** Object:  View [dbo].[ab_zahlung_reservierung]    Script Date: 23.03.2023 15:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Datum der Zahlung und verbleibende Summe zeigen*/
CREATE VIEW [dbo].[ab_zahlung_reservierung]
AS
SELECT        TOP (100) PERCENT dbo.tb_Kunden.KundenNr, dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname, dbo.tb_Zahlung.Datum, dbo.tb_Reservierung.ReservierenID, dbo.tb_Reservierung.AnzahlZimmer, 
                         dbo.tb_ZimmerTyp.TypName, dbo.sf_Kosten_Bestellung_Reservierung(dbo.tb_Reservierung.ReservierenID) AS BestellungsKosten, dbo.sf_Kosten_Reservierung(dbo.tb_Reservierung.ReservierenID) AS ZimmerKosten, 
                         dbo.sf_Zahlungen_Reservierung(dbo.tb_Reservierung.ReservierenID) AS Zahlungen, dbo.sf_Saldo_Reservierung(dbo.tb_Reservierung.ReservierenID) AS Saldo
FROM            dbo.tb_Kunden INNER JOIN
                         dbo.tb_Reservierung ON dbo.tb_Kunden.KundenID = dbo.tb_Reservierung.KundenID INNER JOIN
                         dbo.tb_ZimmerTyp ON dbo.tb_Reservierung.ZimmerTypID = dbo.tb_ZimmerTyp.ZimmerTypID INNER JOIN
                         dbo.tb_Reservieren_Zimmer ON dbo.tb_Reservierung.ReservierenID = dbo.tb_Reservieren_Zimmer.ReservierenID LEFT OUTER JOIN
                         dbo.tb_Zahlung ON dbo.tb_Reservierung.ReservierenID = dbo.tb_Zahlung.ReservierenID
ORDER BY dbo.tb_Kunden.Nachname, dbo.tb_Kunden.Vorname
GO
/****** Object:  View [dbo].[ab_zimmer_istverfuegbar]    Script Date: 23.03.2023 15:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- prüfen, ob das Zimmer verfügbar ist (d.h. bereit für Reservierung: nicht unter Renovierung etc)

CREATE   VIEW [dbo].[ab_zimmer_istverfuegbar]
AS
SELECT        TOP (100) PERCENT dbo.tb_Zimmer.ZimmerID, dbo.tb_Zimmer.ZimmerNr, dbo.tb_ZimmerTyp.TypName, dbo.tb_Zimmer.IstVerfügbar
FROM            dbo.tb_Zimmer INNER JOIN
                         dbo.tb_ZimmerTyp ON dbo.tb_Zimmer.ZimmerTypID = dbo.tb_ZimmerTyp.ZimmerTypID
WHERE        (dbo.tb_Zimmer.IstVerfügbar = 1)
ORDER BY dbo.tb_Zimmer.ZimmerNr
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[19] 2[29] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tb_Zahlung"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_Reservierung"
            Begin Extent = 
               Top = 116
               Left = 355
               Bottom = 246
               Right = 531
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_Kunden"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "tb_ZimmerTyp"
            Begin Extent = 
               Top = 129
               Left = 583
               Bottom = 259
               Right = 753
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_Reservieren_Zimmer"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 366
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5235
         Alias = 1710
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ab_zahlung_reservierung'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ab_zahlung_reservierung'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ab_zahlung_reservierung'
GO
