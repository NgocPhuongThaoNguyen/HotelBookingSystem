USE [master]
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [##MS_PolicyEventProcessingLogin##]    Script Date: 23.03.2023 15:58:07 ******/
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=N'x+OH4gYR76sff+c36oYUXoGRt96x6AG6ZzT/Mq61YKI=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [##MS_PolicyEventProcessingLogin##] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [##MS_PolicyTsqlExecutionLogin##]    Script Date: 23.03.2023 15:58:07 ******/
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=N'SgT5W9C2Ooh548lu7wv9uEhptOp8LWhfIirCDeRFoHA=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [##MS_PolicyTsqlExecutionLogin##] DISABLE
GO
/****** Object:  Login [DESKTOP-J0U7NNS\peua018]    Script Date: 23.03.2023 15:58:07 ******/
CREATE LOGIN [DESKTOP-J0U7NNS\peua018] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[Deutsch]
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [FirmaUser]    Script Date: 23.03.2023 15:58:07 ******/
CREATE LOGIN [FirmaUser] WITH PASSWORD=N'J+ZjVAyp1CjFeIxV3UyBgscdkguKKZu5k+VoEQnt0Fk=', DEFAULT_DATABASE=[FirmaUebung], DEFAULT_LANGUAGE=[Deutsch], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
ALTER LOGIN [FirmaUser] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [HotelUser]    Script Date: 23.03.2023 15:58:07 ******/
CREATE LOGIN [HotelUser] WITH PASSWORD=N'1/aLfWA6wgJKsrltyg2ch0T9EcZYuRgoZEYgJoWLLDc=', DEFAULT_DATABASE=[HotelReservierung], DEFAULT_LANGUAGE=[Deutsch], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER LOGIN [HotelUser] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [HotelUser1]    Script Date: 23.03.2023 15:58:07 ******/
CREATE LOGIN [HotelUser1] WITH PASSWORD=N'QhOz8Pt0QpzXvcoR39+1GUNNZkrIM1pV/kKEZLKVRYs=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[Deutsch], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER LOGIN [HotelUser1] DISABLE
GO
/****** Object:  Login [NT Service\MSSQL$MSSQLSERVER01]    Script Date: 23.03.2023 15:58:07 ******/
CREATE LOGIN [NT Service\MSSQL$MSSQLSERVER01] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[Deutsch]
GO
/****** Object:  Login [NT SERVICE\SQLAgent$MSSQLSERVER01]    Script Date: 23.03.2023 15:58:07 ******/
CREATE LOGIN [NT SERVICE\SQLAgent$MSSQLSERVER01] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[Deutsch]
GO
/****** Object:  Login [NT SERVICE\SQLTELEMETRY$MSSQLSERVER01]    Script Date: 23.03.2023 15:58:07 ******/
CREATE LOGIN [NT SERVICE\SQLTELEMETRY$MSSQLSERVER01] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[Deutsch]
GO
/****** Object:  Login [NT SERVICE\SQLWriter]    Script Date: 23.03.2023 15:58:07 ******/
CREATE LOGIN [NT SERVICE\SQLWriter] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[Deutsch]
GO
/****** Object:  Login [NT SERVICE\Winmgmt]    Script Date: 23.03.2023 15:58:07 ******/
CREATE LOGIN [NT SERVICE\Winmgmt] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[Deutsch]
GO
/****** Object:  Login [NT-AUTORITÄT\SYSTEM]    Script Date: 23.03.2023 15:58:07 ******/
CREATE LOGIN [NT-AUTORITÄT\SYSTEM] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[Deutsch]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [DESKTOP-J0U7NNS\peua018]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT Service\MSSQL$MSSQLSERVER01]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\SQLAgent$MSSQLSERVER01]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\SQLWriter]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\Winmgmt]
GO
USE [HotelReservierung]
GO
/****** Object:  Table [dbo].[KundenLog]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KundenLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Mode] [char](1) NOT NULL,
	[EditOn] [datetime] NOT NULL,
	[EditUser] [nvarchar](100) NOT NULL,
	[KundenID] [int] NOT NULL,
	[KundenVorname] [nvarchar](50) NOT NULL,
	[KundenNachname] [nvarchar](50) NOT NULL,
	[KundenAusweisID] [nvarchar](50) NOT NULL,
	[KundenGender] [bit] NOT NULL,
	[Land] [nvarchar](50) NULL,
	[Telefone_Alte] [nvarchar](50) NULL,
	[KundenTelefone] [nvarchar](50) NOT NULL,
	[KundenEmail] [nvarchar](50) NOT NULL,
	[KundenGebDat] [date] NOT NULL,
 CONSTRAINT [PK__KundenLo__3214EC27E250B056] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[KundenLog] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[ReservierungLog]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservierungLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Mode] [char](1) NOT NULL,
	[EditOn] [datetime] NOT NULL,
	[EditUser] [nvarchar](100) NOT NULL,
	[ReservierenID] [int] NOT NULL,
	[ZimmerTypID] [int] NOT NULL,
	[KundenID] [int] NOT NULL,
	[PersonalID] [int] NOT NULL,
	[ReDatum] [date] NOT NULL,
	[ReStatus] [nvarchar](50) NOT NULL,
	[ReBezahlungStatus_Alte] [bit] NULL,
	[ReBezahlungStatus] [bit] NULL,
	[AnzahlPerson_Alte] [smallint] NULL,
	[ReAnzahlPerson] [smallint] NOT NULL,
	[ReAnzahlZimmer] [smallint] NOT NULL,
	[ReCheckIn] [datetime] NOT NULL,
	[ReCheckOut] [datetime] NOT NULL,
 CONSTRAINT [PK__Reservie__3214EC27030CA234] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[ReservierungLog] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[tb_Artikel]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Artikel](
	[ArtikelID] [int] IDENTITY(1,1) NOT NULL,
	[ArtikelTyp] [nchar](10) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Detail] [nvarchar](50) NULL,
	[Kosten] [money] NOT NULL,
	[Kommentar] [text] NULL,
 CONSTRAINT [PK_tb_Artikel] PRIMARY KEY CLUSTERED 
(
	[ArtikelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tb_Artikel] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[tb_Artikel_Bestellung]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Artikel_Bestellung](
	[ArtikelID] [int] NOT NULL,
	[BestellungID] [int] NOT NULL,
	[Menge] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tb_Artikel_Bestellung] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[tb_Bestellung]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Bestellung](
	[BestellungID] [int] IDENTITY(1,1) NOT NULL,
	[ReservierenID] [int] NOT NULL,
	[Datum] [date] NOT NULL,
	[Kommentar] [text] NULL,
 CONSTRAINT [PK_tb_Bestellung] PRIMARY KEY CLUSTERED 
(
	[BestellungID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tb_Bestellung] TO  SCHEMA OWNER 
GO
GRANT SELECT ON [dbo].[tb_Bestellung] TO [HotelBenutzer] AS [dbo]
GO
GRANT UPDATE ON [dbo].[tb_Bestellung] TO [HotelBenutzer] AS [dbo]
GO
/****** Object:  Table [dbo].[tb_Kunden]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Kunden](
	[KundenID] [int] IDENTITY(1,1) NOT NULL,
	[KundenNr] [int] NOT NULL,
	[Vorname] [nvarchar](50) NOT NULL,
	[Nachname] [nvarchar](50) NOT NULL,
	[AusweisID] [varchar](50) NOT NULL,
	[Gender] [bit] NOT NULL,
	[Ort] [nvarchar](50) NULL,
	[PLZ] [char](5) NULL,
	[Land] [nvarchar](50) NULL,
	[Strasse] [nvarchar](50) NULL,
	[Hausnr] [nvarchar](10) NULL,
	[Telefone] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[GebDat] [date] NULL,
	[Kommentar] [text] NULL,
 CONSTRAINT [PK_tb_Kunden] PRIMARY KEY CLUSTERED 
(
	[KundenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tb_Kunden] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[tb_Personal]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Personal](
	[PersonalID] [int] IDENTITY(1,1) NOT NULL,
	[PersonalNr] [int] NOT NULL,
	[PositionID] [int] NOT NULL,
	[Vorname] [nvarchar](50) NOT NULL,
	[Nachname] [nvarchar](50) NOT NULL,
	[Ort] [nvarchar](50) NULL,
	[PLZ] [char](5) NULL,
	[Land] [nvarchar](50) NULL,
	[Strasse] [nvarchar](50) NULL,
	[Hausnr] [nvarchar](10) NULL,
	[Telefone] [nvarchar](50) NULL,
	[Kommentar] [text] NULL,
 CONSTRAINT [PK_tb_Personal] PRIMARY KEY CLUSTERED 
(
	[PersonalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tb_Personal] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[tb_Position]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Position](
	[PositionID] [int] IDENTITY(1,1) NOT NULL,
	[Position] [nvarchar](50) NOT NULL,
	[Kommentar] [text] NULL,
 CONSTRAINT [PK_tb_Position] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tb_Position] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[tb_Reservieren_Zimmer]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Reservieren_Zimmer](
	[ReservierenID] [int] NOT NULL,
	[ZimmerID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tb_Reservieren_Zimmer] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[tb_Reservierung]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Reservierung](
	[ReservierenID] [int] IDENTITY(1,1) NOT NULL,
	[ZimmerTypID] [int] NOT NULL,
	[KundenID] [int] NOT NULL,
	[PersonalID] [int] NOT NULL,
	[Datum] [date] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[BezahlungStatus] [bit] NULL,
	[AnzahlPerson] [smallint] NOT NULL,
	[AnzahlZimmer] [smallint] NOT NULL,
	[CheckIn] [datetime] NULL,
	[CheckOut] [datetime] NULL,
	[Kommentar] [text] NULL,
 CONSTRAINT [PK_tb_Reservierung] PRIMARY KEY CLUSTERED 
(
	[ReservierenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tb_Reservierung] TO  SCHEMA OWNER 
GO
GRANT SELECT ON [dbo].[tb_Reservierung] TO [HotelBenutzer] AS [dbo]
GO
GRANT UPDATE ON [dbo].[tb_Reservierung] ([AnzahlPerson]) TO [HotelBenutzer] AS [dbo]
GO
/****** Object:  Table [dbo].[tb_Zahlung]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Zahlung](
	[ZahlungID] [int] IDENTITY(1,1) NOT NULL,
	[ReservierenID] [int] NOT NULL,
	[Datum] [date] NOT NULL,
	[Betrag] [money] NOT NULL,
	[Kommentar] [text] NULL,
 CONSTRAINT [PK_tb_Zahlung] PRIMARY KEY CLUSTERED 
(
	[ZahlungID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tb_Zahlung] TO  SCHEMA OWNER 
GO
GRANT SELECT ON [dbo].[tb_Zahlung] TO [HotelBenutzer] AS [dbo]
GO
GRANT UPDATE ON [dbo].[tb_Zahlung] ([Betrag]) TO [HotelBenutzer] AS [dbo]
GO
/****** Object:  Table [dbo].[tb_Zimmer]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Zimmer](
	[ZimmerID] [int] IDENTITY(1,1) NOT NULL,
	[ZimmerTypID] [int] NOT NULL,
	[ZimmerNr] [char](10) NOT NULL,
	[Detail] [nvarchar](50) NOT NULL,
	[IstVerfügbar] [bit] NOT NULL,
	[Kommentar] [text] NULL,
 CONSTRAINT [PK_tb_Zimmer] PRIMARY KEY CLUSTERED 
(
	[ZimmerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tb_Zimmer] TO  SCHEMA OWNER 
GO
GRANT SELECT ON [dbo].[tb_Zimmer] TO [HotelBenutzer] AS [dbo]
GO
GRANT UPDATE ON [dbo].[tb_Zimmer] TO [HotelBenutzer] AS [dbo]
GO
/****** Object:  Table [dbo].[tb_ZimmerTyp]    Script Date: 23.03.2023 15:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ZimmerTyp](
	[ZimmerTypID] [int] IDENTITY(1,1) NOT NULL,
	[TypName] [nvarchar](50) NOT NULL,
	[Kosten] [float] NOT NULL,
	[AnzahlPerson] [smallint] NOT NULL,
	[Kommentar] [text] NULL,
 CONSTRAINT [PK_tb_ZimmerTyp] PRIMARY KEY CLUSTERED 
(
	[ZimmerTypID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[tb_ZimmerTyp] TO  SCHEMA OWNER 
GO
GRANT TAKE OWNERSHIP ON [dbo].[tb_ZimmerTyp] TO [HotelBenutzer] AS [dbo]
GO
GRANT UPDATE ON [dbo].[tb_ZimmerTyp] TO [HotelBenutzer] AS [dbo]
GO
SET IDENTITY_INSERT [dbo].[ReservierungLog] ON 

INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (152, N'I', CAST(N'2023-03-23T14:30:47.547' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 144, 1, 1, 1, CAST(N'2023-03-23' AS Date), N'aktuell', NULL, NULL, NULL, 1, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-24T00:00:00.000' AS DateTime))
INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (153, N'I', CAST(N'2023-03-23T14:30:47.557' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 145, 1, 2, 2, CAST(N'2023-03-23' AS Date), N'aktuell', NULL, NULL, NULL, 1, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime))
INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (154, N'I', CAST(N'2023-03-23T14:30:47.560' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 146, 2, 3, 3, CAST(N'2023-03-23' AS Date), N'aktuell', NULL, NULL, NULL, 1, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime))
INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (155, N'I', CAST(N'2023-03-23T14:30:47.560' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 147, 3, 4, 3, CAST(N'2023-03-23' AS Date), N'aktuell', NULL, NULL, NULL, 3, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime))
INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (156, N'I', CAST(N'2023-03-23T14:30:47.563' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 148, 3, 5, 4, CAST(N'2023-03-23' AS Date), N'aktuell', NULL, NULL, NULL, 4, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime))
INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (157, N'I', CAST(N'2023-03-23T14:30:47.567' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 149, 2, 7, 5, CAST(N'2023-03-23' AS Date), N'zukünftig', NULL, NULL, NULL, 2, 1, CAST(N'2023-03-25T00:00:00.000' AS DateTime), CAST(N'2023-03-28T00:00:00.000' AS DateTime))
INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (158, N'I', CAST(N'2023-03-23T14:30:47.567' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 150, 1, 1, 1, CAST(N'2023-03-23' AS Date), N'zukünftig', NULL, NULL, NULL, 1, 1, CAST(N'2023-03-25T00:00:00.000' AS DateTime), CAST(N'2023-03-28T00:00:00.000' AS DateTime))
INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (159, N'I', CAST(N'2023-03-23T14:30:47.570' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 151, 3, 1, 7, CAST(N'2023-03-23' AS Date), N'abgeschlossen', NULL, NULL, NULL, 5, 2, CAST(N'2022-03-30T00:00:00.000' AS DateTime), CAST(N'2022-04-28T00:00:00.000' AS DateTime))
INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (160, N'U', CAST(N'2023-03-23T14:34:05.897' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 144, 1, 1, 1, CAST(N'2023-03-23' AS Date), N'aktuell', NULL, 1, NULL, 1, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-24T00:00:00.000' AS DateTime))
INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (161, N'U', CAST(N'2023-03-23T15:13:27.887' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 144, 1, 1, 1, CAST(N'2023-03-23' AS Date), N'aktuell', 1, 1, NULL, 1, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-24T00:00:00.000' AS DateTime))
INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (162, N'U', CAST(N'2023-03-23T15:13:27.890' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 145, 1, 2, 2, CAST(N'2023-03-23' AS Date), N'aktuell', NULL, 1, NULL, 1, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime))
INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (163, N'U', CAST(N'2023-03-23T15:13:27.890' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 146, 2, 3, 3, CAST(N'2023-03-23' AS Date), N'aktuell', NULL, 1, NULL, 1, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime))
INSERT [dbo].[ReservierungLog] ([ID], [Mode], [EditOn], [EditUser], [ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [ReDatum], [ReStatus], [ReBezahlungStatus_Alte], [ReBezahlungStatus], [AnzahlPerson_Alte], [ReAnzahlPerson], [ReAnzahlZimmer], [ReCheckIn], [ReCheckOut]) VALUES (164, N'U', CAST(N'2023-03-23T15:13:27.890' AS DateTime), N'DESKTOP-J0U7NNS\peua018', 147, 3, 4, 3, CAST(N'2023-03-23' AS Date), N'aktuell', NULL, 1, NULL, 3, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[ReservierungLog] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_Artikel] ON 

INSERT [dbo].[tb_Artikel] ([ArtikelID], [ArtikelTyp], [Name], [Detail], [Kosten], [Kommentar]) VALUES (3, N'Snack     ', N'Pringle Chips', N'Potatoes Chips', 5.0000, NULL)
INSERT [dbo].[tb_Artikel] ([ArtikelID], [ArtikelTyp], [Name], [Detail], [Kosten], [Kommentar]) VALUES (4, N'Snack     ', N'Gumibärchen', N'Gumi', 3.0000, NULL)
INSERT [dbo].[tb_Artikel] ([ArtikelID], [ArtikelTyp], [Name], [Detail], [Kosten], [Kommentar]) VALUES (5, N'Getränk   ', N'Still Wasser', N'Wasser', 3.0000, NULL)
INSERT [dbo].[tb_Artikel] ([ArtikelID], [ArtikelTyp], [Name], [Detail], [Kosten], [Kommentar]) VALUES (6, N'Getränk   ', N'Beer', N'Weis Beer', 5.0000, NULL)
INSERT [dbo].[tb_Artikel] ([ArtikelID], [ArtikelTyp], [Name], [Detail], [Kosten], [Kommentar]) VALUES (7, N'Essen     ', N'Bratwürst', N'Rotwürst', 7.0000, NULL)
INSERT [dbo].[tb_Artikel] ([ArtikelID], [ArtikelTyp], [Name], [Detail], [Kosten], [Kommentar]) VALUES (8, N'Essen     ', N'Curry Würst', N'Curry Würst', 8.0000, NULL)
INSERT [dbo].[tb_Artikel] ([ArtikelID], [ArtikelTyp], [Name], [Detail], [Kosten], [Kommentar]) VALUES (9, N'Essen     ', N'Bolognese Spaghetti', N'Tomatoes Spagehtti', 12.0000, NULL)
INSERT [dbo].[tb_Artikel] ([ArtikelID], [ArtikelTyp], [Name], [Detail], [Kosten], [Kommentar]) VALUES (10, N'Getränk   ', N'Cola', NULL, 3.0000, NULL)
INSERT [dbo].[tb_Artikel] ([ArtikelID], [ArtikelTyp], [Name], [Detail], [Kosten], [Kommentar]) VALUES (11, N'Getränk   ', N'Cafe', NULL, 4.0000, NULL)
INSERT [dbo].[tb_Artikel] ([ArtikelID], [ArtikelTyp], [Name], [Detail], [Kosten], [Kommentar]) VALUES (13, N'Getränk   ', N'Latte Machiato', N'0,5 ml', 6.0000, NULL)
SET IDENTITY_INSERT [dbo].[tb_Artikel] OFF
GO
INSERT [dbo].[tb_Artikel_Bestellung] ([ArtikelID], [BestellungID], [Menge]) VALUES (6, 16, 2)
INSERT [dbo].[tb_Artikel_Bestellung] ([ArtikelID], [BestellungID], [Menge]) VALUES (8, 16, 1)
INSERT [dbo].[tb_Artikel_Bestellung] ([ArtikelID], [BestellungID], [Menge]) VALUES (10, 16, 1)
INSERT [dbo].[tb_Artikel_Bestellung] ([ArtikelID], [BestellungID], [Menge]) VALUES (9, 17, 1)
INSERT [dbo].[tb_Artikel_Bestellung] ([ArtikelID], [BestellungID], [Menge]) VALUES (11, 17, 1)
GO
SET IDENTITY_INSERT [dbo].[tb_Bestellung] ON 

INSERT [dbo].[tb_Bestellung] ([BestellungID], [ReservierenID], [Datum], [Kommentar]) VALUES (16, 144, CAST(N'2023-03-23' AS Date), N' ')
INSERT [dbo].[tb_Bestellung] ([BestellungID], [ReservierenID], [Datum], [Kommentar]) VALUES (17, 145, CAST(N'2023-03-23' AS Date), N' ')
SET IDENTITY_INSERT [dbo].[tb_Bestellung] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_Kunden] ON 

INSERT [dbo].[tb_Kunden] ([KundenID], [KundenNr], [Vorname], [Nachname], [AusweisID], [Gender], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Email], [GebDat], [Kommentar]) VALUES (1, 1, N'Falk', N'Semler', N'T22000129', 0, N'Neu-Ulm', N'89231', N'Deutschland', N'Pfuhlwiese', N'4', N'01717247378', N'falk-semler@funmail.none', CAST(N'1977-01-21' AS Date), NULL)
INSERT [dbo].[tb_Kunden] ([KundenID], [KundenNr], [Vorname], [Nachname], [AusweisID], [Gender], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Email], [GebDat], [Kommentar]) VALUES (2, 2, N'Edith', N'Speiser', N'LVH093451', 1, N'Buxtehude', N'21614', N'Deutschland', N'Letmannsdyck', N'70', N'01787326971', N'edith.speiser@inter-mail.none', CAST(N'1956-07-04' AS Date), NULL)
INSERT [dbo].[tb_Kunden] ([KundenID], [KundenNr], [Vorname], [Nachname], [AusweisID], [Gender], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Email], [GebDat], [Kommentar]) VALUES (3, 3, N'Ira', N'Räsener', N'XX0923nH1', 1, N'Frestedt', N'25727', N'Deutschland', N'Im Größen Garten', N'113', N'176456987', N'ira-2017@company.none', CAST(N'1994-09-21' AS Date), NULL)
INSERT [dbo].[tb_Kunden] ([KundenID], [KundenNr], [Vorname], [Nachname], [AusweisID], [Gender], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Email], [GebDat], [Kommentar]) VALUES (4, 4, N'Erika', N'Mustermann', N'T34987289', 1, N'London', NULL, N'England', NULL, NULL, N'01784569877', N'erika.mustermann@happy.none', CAST(N'1964-08-12' AS Date), NULL)
INSERT [dbo].[tb_Kunden] ([KundenID], [KundenNr], [Vorname], [Nachname], [AusweisID], [Gender], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Email], [GebDat], [Kommentar]) VALUES (5, 5, N'Christ', N'Beyer', N'HP9235960', 0, N'Michigan', NULL, N'US', NULL, NULL, N'01593450982', N'chris.beyer@telcom.none', CAST(N'1982-09-30' AS Date), NULL)
INSERT [dbo].[tb_Kunden] ([KundenID], [KundenNr], [Vorname], [Nachname], [AusweisID], [Gender], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Email], [GebDat], [Kommentar]) VALUES (7, 7, N'Tanja', N'Beyer', N'IU1298408', 1, NULL, NULL, N'Australia', NULL, NULL, N'176456999', N'tanja.beyer@telecom.none', CAST(N'1982-12-23' AS Date), NULL)
INSERT [dbo].[tb_Kunden] ([KundenID], [KundenNr], [Vorname], [Nachname], [AusweisID], [Gender], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Email], [GebDat], [Kommentar]) VALUES (16, 8, N'Peter2', N'Neumann3', N'IE09C8499', 0, N'', N'     ', N'Philipine', N'', N'', N'17643095378', N'petar.neum24n@telecom.none', CAST(N'1982-12-02' AS Date), N'')
SET IDENTITY_INSERT [dbo].[tb_Kunden] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_Personal] ON 

INSERT [dbo].[tb_Personal] ([PersonalID], [PersonalNr], [PositionID], [Vorname], [Nachname], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Kommentar]) VALUES (1, 1, 1, N'Juli', N'Lehne', N'Greimerath', N'54214', N'Deutschland', N'Alte Kirchestrasse', N'70', N'01717247378', NULL)
INSERT [dbo].[tb_Personal] ([PersonalID], [PersonalNr], [PositionID], [Vorname], [Nachname], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Kommentar]) VALUES (2, 2, 1, N'Sven', N'Panis', N'Kaiserlautern', NULL, N'Deutschland', N'Broicherstrasse', N'16b', N'01687039419', NULL)
INSERT [dbo].[tb_Personal] ([PersonalID], [PersonalNr], [PositionID], [Vorname], [Nachname], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Kommentar]) VALUES (3, 3, 1, N'Alex', N'Kramer', N'Hamburg', NULL, N'Deutschland', N'Hamburgerstrasse', N'5', N'01763982769', NULL)
INSERT [dbo].[tb_Personal] ([PersonalID], [PersonalNr], [PositionID], [Vorname], [Nachname], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Kommentar]) VALUES (4, 4, 1, N'Kathrin', N'Regel', N'Hannover', NULL, N'Deutschland', N'Hannoverstrasse ', N'8', N'01569829858', NULL)
INSERT [dbo].[tb_Personal] ([PersonalID], [PersonalNr], [PositionID], [Vorname], [Nachname], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Kommentar]) VALUES (5, 5, 1, N'Olga', N'Subach', N'Aachen', NULL, N'Deutschland', N'Aachener strasse ', N'9', N'01762397967', NULL)
INSERT [dbo].[tb_Personal] ([PersonalID], [PersonalNr], [PositionID], [Vorname], [Nachname], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Kommentar]) VALUES (6, 6, 1, N'Thao', N'Nguyen', N'München', N'81476', N'Deutschland', N'Münchener strasse', N'10', N'01763989509', NULL)
INSERT [dbo].[tb_Personal] ([PersonalID], [PersonalNr], [PositionID], [Vorname], [Nachname], [Ort], [PLZ], [Land], [Strasse], [Hausnr], [Telefone], [Kommentar]) VALUES (7, 7, 2, N'Dietbald', N'Borg', N'Engden', N'48465', N'Deutschland', N'Klosterstrasse', N'75a', N'01615982714', NULL)
SET IDENTITY_INSERT [dbo].[tb_Personal] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_Position] ON 

INSERT [dbo].[tb_Position] ([PositionID], [Position], [Kommentar]) VALUES (1, N'Rezeptionist', NULL)
INSERT [dbo].[tb_Position] ([PositionID], [Position], [Kommentar]) VALUES (2, N'Manager', NULL)
INSERT [dbo].[tb_Position] ([PositionID], [Position], [Kommentar]) VALUES (3, N'Zimmermädchen', NULL)
INSERT [dbo].[tb_Position] ([PositionID], [Position], [Kommentar]) VALUES (4, N'IT', NULL)
INSERT [dbo].[tb_Position] ([PositionID], [Position], [Kommentar]) VALUES (5, N'Verkauf', NULL)
INSERT [dbo].[tb_Position] ([PositionID], [Position], [Kommentar]) VALUES (6, N'Marketing', NULL)
SET IDENTITY_INSERT [dbo].[tb_Position] OFF
GO
INSERT [dbo].[tb_Reservieren_Zimmer] ([ReservierenID], [ZimmerID]) VALUES (144, 1)
INSERT [dbo].[tb_Reservieren_Zimmer] ([ReservierenID], [ZimmerID]) VALUES (145, 2)
INSERT [dbo].[tb_Reservieren_Zimmer] ([ReservierenID], [ZimmerID]) VALUES (146, 4)
INSERT [dbo].[tb_Reservieren_Zimmer] ([ReservierenID], [ZimmerID]) VALUES (147, 7)
INSERT [dbo].[tb_Reservieren_Zimmer] ([ReservierenID], [ZimmerID]) VALUES (148, 8)
INSERT [dbo].[tb_Reservieren_Zimmer] ([ReservierenID], [ZimmerID]) VALUES (149, 5)
INSERT [dbo].[tb_Reservieren_Zimmer] ([ReservierenID], [ZimmerID]) VALUES (150, 1)
INSERT [dbo].[tb_Reservieren_Zimmer] ([ReservierenID], [ZimmerID]) VALUES (151, 7)
INSERT [dbo].[tb_Reservieren_Zimmer] ([ReservierenID], [ZimmerID]) VALUES (151, 8)
GO
SET IDENTITY_INSERT [dbo].[tb_Reservierung] ON 

INSERT [dbo].[tb_Reservierung] ([ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [Datum], [Status], [BezahlungStatus], [AnzahlPerson], [AnzahlZimmer], [CheckIn], [CheckOut], [Kommentar]) VALUES (144, 1, 1, 1, CAST(N'2023-03-23' AS Date), N'aktuell', 1, 1, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-24T00:00:00.000' AS DateTime), N'vegan')
INSERT [dbo].[tb_Reservierung] ([ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [Datum], [Status], [BezahlungStatus], [AnzahlPerson], [AnzahlZimmer], [CheckIn], [CheckOut], [Kommentar]) VALUES (145, 1, 2, 2, CAST(N'2023-03-23' AS Date), N'aktuell', 1, 1, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime), N'')
INSERT [dbo].[tb_Reservierung] ([ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [Datum], [Status], [BezahlungStatus], [AnzahlPerson], [AnzahlZimmer], [CheckIn], [CheckOut], [Kommentar]) VALUES (146, 2, 3, 3, CAST(N'2023-03-23' AS Date), N'aktuell', 1, 1, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime), N'')
INSERT [dbo].[tb_Reservierung] ([ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [Datum], [Status], [BezahlungStatus], [AnzahlPerson], [AnzahlZimmer], [CheckIn], [CheckOut], [Kommentar]) VALUES (147, 3, 4, 3, CAST(N'2023-03-23' AS Date), N'aktuell', 1, 3, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime), N'hund dabei')
INSERT [dbo].[tb_Reservierung] ([ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [Datum], [Status], [BezahlungStatus], [AnzahlPerson], [AnzahlZimmer], [CheckIn], [CheckOut], [Kommentar]) VALUES (148, 3, 5, 4, CAST(N'2023-03-23' AS Date), N'aktuell', NULL, 4, 1, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime), N'baby dabei')
INSERT [dbo].[tb_Reservierung] ([ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [Datum], [Status], [BezahlungStatus], [AnzahlPerson], [AnzahlZimmer], [CheckIn], [CheckOut], [Kommentar]) VALUES (149, 2, 7, 5, CAST(N'2023-03-23' AS Date), N'zukünftig', NULL, 2, 1, CAST(N'2023-03-25T00:00:00.000' AS DateTime), CAST(N'2023-03-28T00:00:00.000' AS DateTime), N'')
INSERT [dbo].[tb_Reservierung] ([ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [Datum], [Status], [BezahlungStatus], [AnzahlPerson], [AnzahlZimmer], [CheckIn], [CheckOut], [Kommentar]) VALUES (150, 1, 1, 1, CAST(N'2023-03-23' AS Date), N'zukünftig', NULL, 1, 1, CAST(N'2023-03-25T00:00:00.000' AS DateTime), CAST(N'2023-03-28T00:00:00.000' AS DateTime), N'')
INSERT [dbo].[tb_Reservierung] ([ReservierenID], [ZimmerTypID], [KundenID], [PersonalID], [Datum], [Status], [BezahlungStatus], [AnzahlPerson], [AnzahlZimmer], [CheckIn], [CheckOut], [Kommentar]) VALUES (151, 3, 1, 7, CAST(N'2023-03-23' AS Date), N'abgeschlossen', NULL, 5, 2, CAST(N'2022-03-30T00:00:00.000' AS DateTime), CAST(N'2022-04-28T00:00:00.000' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[tb_Reservierung] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_Zahlung] ON 

INSERT [dbo].[tb_Zahlung] ([ZahlungID], [ReservierenID], [Datum], [Betrag], [Kommentar]) VALUES (5, 144, CAST(N'2023-03-23' AS Date), 150.0000, NULL)
INSERT [dbo].[tb_Zahlung] ([ZahlungID], [ReservierenID], [Datum], [Betrag], [Kommentar]) VALUES (6, 144, CAST(N'2023-03-22' AS Date), 150.0000, N'Anzahlung')
INSERT [dbo].[tb_Zahlung] ([ZahlungID], [ReservierenID], [Datum], [Betrag], [Kommentar]) VALUES (7, 145, CAST(N'2023-03-22' AS Date), 400.0000, N'Anzahlung')
INSERT [dbo].[tb_Zahlung] ([ZahlungID], [ReservierenID], [Datum], [Betrag], [Kommentar]) VALUES (8, 146, CAST(N'2023-03-22' AS Date), 1000.0000, N'Anzahlung')
INSERT [dbo].[tb_Zahlung] ([ZahlungID], [ReservierenID], [Datum], [Betrag], [Kommentar]) VALUES (9, 147, CAST(N'2023-03-22' AS Date), 300.0000, N'Anzahlung')
SET IDENTITY_INSERT [dbo].[tb_Zahlung] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_Zimmer] ON 

INSERT [dbo].[tb_Zimmer] ([ZimmerID], [ZimmerTypID], [ZimmerNr], [Detail], [IstVerfügbar], [Kommentar]) VALUES (1, 1, N'110       ', N'Standard Einzelnzimmer', 1, NULL)
INSERT [dbo].[tb_Zimmer] ([ZimmerID], [ZimmerTypID], [ZimmerNr], [Detail], [IstVerfügbar], [Kommentar]) VALUES (2, 1, N'111       ', N'Standard Einzelnzimmer', 1, NULL)
INSERT [dbo].[tb_Zimmer] ([ZimmerID], [ZimmerTypID], [ZimmerNr], [Detail], [IstVerfügbar], [Kommentar]) VALUES (3, 1, N'112       ', N'Standard', 0, NULL)
INSERT [dbo].[tb_Zimmer] ([ZimmerID], [ZimmerTypID], [ZimmerNr], [Detail], [IstVerfügbar], [Kommentar]) VALUES (4, 2, N'210       ', N'Doppel', 1, NULL)
INSERT [dbo].[tb_Zimmer] ([ZimmerID], [ZimmerTypID], [ZimmerNr], [Detail], [IstVerfügbar], [Kommentar]) VALUES (5, 2, N'212       ', N'Doppel', 1, NULL)
INSERT [dbo].[tb_Zimmer] ([ZimmerID], [ZimmerTypID], [ZimmerNr], [Detail], [IstVerfügbar], [Kommentar]) VALUES (6, 2, N'215       ', N'Doppel', 0, NULL)
INSERT [dbo].[tb_Zimmer] ([ZimmerID], [ZimmerTypID], [ZimmerNr], [Detail], [IstVerfügbar], [Kommentar]) VALUES (7, 3, N'310       ', N'Familienzimmer', 1, NULL)
INSERT [dbo].[tb_Zimmer] ([ZimmerID], [ZimmerTypID], [ZimmerNr], [Detail], [IstVerfügbar], [Kommentar]) VALUES (8, 3, N'311       ', N'Familienzimmer', 1, NULL)
SET IDENTITY_INSERT [dbo].[tb_Zimmer] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_ZimmerTyp] ON 

INSERT [dbo].[tb_ZimmerTyp] ([ZimmerTypID], [TypName], [Kosten], [AnzahlPerson], [Kommentar]) VALUES (1, N'Einzel', 79, 1, NULL)
INSERT [dbo].[tb_ZimmerTyp] ([ZimmerTypID], [TypName], [Kosten], [AnzahlPerson], [Kommentar]) VALUES (2, N'Doppel', 99, 2, NULL)
INSERT [dbo].[tb_ZimmerTyp] ([ZimmerTypID], [TypName], [Kosten], [AnzahlPerson], [Kommentar]) VALUES (3, N'Familien', 129, 4, NULL)
SET IDENTITY_INSERT [dbo].[tb_ZimmerTyp] OFF
GO
/****** Object:  Index [IX_tb_Artikel_Bestellung]    Script Date: 23.03.2023 15:58:08 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Artikel_Bestellung] ON [dbo].[tb_Artikel_Bestellung]
(
	[ArtikelID] ASC,
	[BestellungID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Nachname_Vorname]    Script Date: 23.03.2023 15:58:08 ******/
CREATE NONCLUSTERED INDEX [IX_Nachname_Vorname] ON [dbo].[tb_Kunden]
(
	[Nachname] ASC,
	[Vorname] ASC,
	[GebDat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tb_Kunden_Ausweis]    Script Date: 23.03.2023 15:58:08 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Kunden_Ausweis] ON [dbo].[tb_Kunden]
(
	[AusweisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tb_Kunden_Email]    Script Date: 23.03.2023 15:58:08 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Kunden_Email] ON [dbo].[tb_Kunden]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tb_Kunden_KundenNr]    Script Date: 23.03.2023 15:58:08 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Kunden_KundenNr] ON [dbo].[tb_Kunden]
(
	[KundenNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tb_Kunden_Telefone]    Script Date: 23.03.2023 15:58:08 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Kunden_Telefone] ON [dbo].[tb_Kunden]
(
	[Telefone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tb_Personal_Personal_Nr]    Script Date: 23.03.2023 15:58:08 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Personal_Personal_Nr] ON [dbo].[tb_Personal]
(
	[PersonalNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tb_Reservieren_Zimmer]    Script Date: 23.03.2023 15:58:08 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Reservieren_Zimmer] ON [dbo].[tb_Reservieren_Zimmer]
(
	[ReservierenID] ASC,
	[ZimmerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tb_ZimmerNr]    Script Date: 23.03.2023 15:58:08 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_ZimmerNr] ON [dbo].[tb_Zimmer]
(
	[ZimmerNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[KundenLog] ADD  CONSTRAINT [DF__KundenLog__EditO__7849DB76]  DEFAULT (getdate()) FOR [EditOn]
GO
ALTER TABLE [dbo].[KundenLog] ADD  CONSTRAINT [DF__KundenLog__EditU__793DFFAF]  DEFAULT (original_login()) FOR [EditUser]
GO
ALTER TABLE [dbo].[ReservierungLog] ADD  CONSTRAINT [DF__Reservier__EditO__7E02B4CC]  DEFAULT (getdate()) FOR [EditOn]
GO
ALTER TABLE [dbo].[ReservierungLog] ADD  CONSTRAINT [DF__Reservier__EditU__7EF6D905]  DEFAULT (original_login()) FOR [EditUser]
GO
ALTER TABLE [dbo].[tb_Artikel_Bestellung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Artikel_Bestellung_tb_Artikel] FOREIGN KEY([ArtikelID])
REFERENCES [dbo].[tb_Artikel] ([ArtikelID])
GO
ALTER TABLE [dbo].[tb_Artikel_Bestellung] CHECK CONSTRAINT [FK_tb_Artikel_Bestellung_tb_Artikel]
GO
ALTER TABLE [dbo].[tb_Artikel_Bestellung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Artikel_Bestellung_tb_Bestellung] FOREIGN KEY([BestellungID])
REFERENCES [dbo].[tb_Bestellung] ([BestellungID])
GO
ALTER TABLE [dbo].[tb_Artikel_Bestellung] CHECK CONSTRAINT [FK_tb_Artikel_Bestellung_tb_Bestellung]
GO
ALTER TABLE [dbo].[tb_Bestellung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Bestellung_tb_Reservierung] FOREIGN KEY([ReservierenID])
REFERENCES [dbo].[tb_Reservierung] ([ReservierenID])
GO
ALTER TABLE [dbo].[tb_Bestellung] CHECK CONSTRAINT [FK_tb_Bestellung_tb_Reservierung]
GO
ALTER TABLE [dbo].[tb_Personal]  WITH CHECK ADD  CONSTRAINT [FK_tb_Personal_tb_Position] FOREIGN KEY([PositionID])
REFERENCES [dbo].[tb_Position] ([PositionID])
GO
ALTER TABLE [dbo].[tb_Personal] CHECK CONSTRAINT [FK_tb_Personal_tb_Position]
GO
ALTER TABLE [dbo].[tb_Reservieren_Zimmer]  WITH CHECK ADD  CONSTRAINT [FK_tb_Reservieren_Zimmer_tb_Reservierung] FOREIGN KEY([ReservierenID])
REFERENCES [dbo].[tb_Reservierung] ([ReservierenID])
GO
ALTER TABLE [dbo].[tb_Reservieren_Zimmer] CHECK CONSTRAINT [FK_tb_Reservieren_Zimmer_tb_Reservierung]
GO
ALTER TABLE [dbo].[tb_Reservieren_Zimmer]  WITH CHECK ADD  CONSTRAINT [FK_tb_Reservieren_Zimmer_tb_Zimmer] FOREIGN KEY([ZimmerID])
REFERENCES [dbo].[tb_Zimmer] ([ZimmerID])
GO
ALTER TABLE [dbo].[tb_Reservieren_Zimmer] CHECK CONSTRAINT [FK_tb_Reservieren_Zimmer_tb_Zimmer]
GO
ALTER TABLE [dbo].[tb_Reservierung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Reservierung_tb_Kunden] FOREIGN KEY([KundenID])
REFERENCES [dbo].[tb_Kunden] ([KundenID])
GO
ALTER TABLE [dbo].[tb_Reservierung] CHECK CONSTRAINT [FK_tb_Reservierung_tb_Kunden]
GO
ALTER TABLE [dbo].[tb_Reservierung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Reservierung_tb_Personal] FOREIGN KEY([PersonalID])
REFERENCES [dbo].[tb_Personal] ([PersonalID])
GO
ALTER TABLE [dbo].[tb_Reservierung] CHECK CONSTRAINT [FK_tb_Reservierung_tb_Personal]
GO
ALTER TABLE [dbo].[tb_Reservierung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Reservierung_tb_ZimmerTyp] FOREIGN KEY([ZimmerTypID])
REFERENCES [dbo].[tb_ZimmerTyp] ([ZimmerTypID])
GO
ALTER TABLE [dbo].[tb_Reservierung] CHECK CONSTRAINT [FK_tb_Reservierung_tb_ZimmerTyp]
GO
ALTER TABLE [dbo].[tb_Zahlung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Zahlung_tb_Reservierung] FOREIGN KEY([ReservierenID])
REFERENCES [dbo].[tb_Reservierung] ([ReservierenID])
GO
ALTER TABLE [dbo].[tb_Zahlung] CHECK CONSTRAINT [FK_tb_Zahlung_tb_Reservierung]
GO
ALTER TABLE [dbo].[tb_Zimmer]  WITH CHECK ADD  CONSTRAINT [FK_tb_Zimmer_tb_ZimmerTyp] FOREIGN KEY([ZimmerTypID])
REFERENCES [dbo].[tb_ZimmerTyp] ([ZimmerTypID])
GO
ALTER TABLE [dbo].[tb_Zimmer] CHECK CONSTRAINT [FK_tb_Zimmer_tb_ZimmerTyp]
GO
ALTER TABLE [dbo].[tb_Artikel]  WITH CHECK ADD  CONSTRAINT [CK_tb_Artikel_Kosten] CHECK  (([Kosten]>(0)))
GO
ALTER TABLE [dbo].[tb_Artikel] CHECK CONSTRAINT [CK_tb_Artikel_Kosten]
GO
ALTER TABLE [dbo].[tb_Artikel_Bestellung]  WITH CHECK ADD  CONSTRAINT [CK_tb_Artikel_Bestellung_MinMenge] CHECK  (([Menge]>(0)))
GO
ALTER TABLE [dbo].[tb_Artikel_Bestellung] CHECK CONSTRAINT [CK_tb_Artikel_Bestellung_MinMenge]
GO
ALTER TABLE [dbo].[tb_Kunden]  WITH CHECK ADD  CONSTRAINT [CK_tb_Kunden_GebDat] CHECK  (([GebDat]<=getdate()))
GO
ALTER TABLE [dbo].[tb_Kunden] CHECK CONSTRAINT [CK_tb_Kunden_GebDat]
GO
ALTER TABLE [dbo].[tb_Reservierung]  WITH CHECK ADD  CONSTRAINT [CK_tb_Reservierung_CheckOut] CHECK  (([CheckOut]>=[CheckIn]))
GO
ALTER TABLE [dbo].[tb_Reservierung] CHECK CONSTRAINT [CK_tb_Reservierung_CheckOut]
GO
ALTER TABLE [dbo].[tb_Reservierung]  WITH CHECK ADD  CONSTRAINT [CK_tb_Reservierung_MinPerson] CHECK  (([AnzahlPerson]>=(1)))
GO
ALTER TABLE [dbo].[tb_Reservierung] CHECK CONSTRAINT [CK_tb_Reservierung_MinPerson]
GO
ALTER TABLE [dbo].[tb_Reservierung]  WITH CHECK ADD  CONSTRAINT [CK_tb_Reservierung_MinZimmer] CHECK  (([AnzahlZimmer]>=(1)))
GO
ALTER TABLE [dbo].[tb_Reservierung] CHECK CONSTRAINT [CK_tb_Reservierung_MinZimmer]
GO
ALTER TABLE [dbo].[tb_Zahlung]  WITH CHECK ADD  CONSTRAINT [CK_tb_Zahlung_Betrag] CHECK  (([Betrag]>(0)))
GO
ALTER TABLE [dbo].[tb_Zahlung] CHECK CONSTRAINT [CK_tb_Zahlung_Betrag]
GO
ALTER TABLE [dbo].[tb_ZimmerTyp]  WITH CHECK ADD  CONSTRAINT [CK_tb_ZimmerTyp_Kosten] CHECK  (([Kosten]>(0)))
GO
ALTER TABLE [dbo].[tb_ZimmerTyp] CHECK CONSTRAINT [CK_tb_ZimmerTyp_Kosten]
GO
ALTER TABLE [dbo].[tb_ZimmerTyp]  WITH CHECK ADD  CONSTRAINT [CK_tb_ZimmerTyp_MinPerson] CHECK  (([AnzahlPerson]>=(1)))
GO
ALTER TABLE [dbo].[tb_ZimmerTyp] CHECK CONSTRAINT [CK_tb_ZimmerTyp_MinPerson]
GO
/****** Object:  Trigger [dbo].[tr_KundenDELETE]    Script Date: 23.03.2023 15:58:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <20.03.2023>
-- Description:	<Kunden DELETE>
-- =============================================
CREATE   TRIGGER [dbo].[tr_KundenDELETE]
   ON  [dbo].[tb_Kunden]
   FOR DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO dbo.KundenLog
			(Mode, KundenID, KundenNr, KundenVorname, KundenNachname, KundenAusweisID, KundenGender, Land, KundenTelefone, KundenEmail, KundenGebDat)
	SELECT   'D',  KundenID, KundenNr, Vorname, Nachname, AusweisID, Gender, Land, Telefone, Email, GebDat 
	FROM deleted;
END
GO
ALTER TABLE [dbo].[tb_Kunden] ENABLE TRIGGER [tr_KundenDELETE]
GO
/****** Object:  Trigger [dbo].[tr_KundenINSERT]    Script Date: 23.03.2023 15:58:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <20.03.2023>
-- Description:	<Trigger tb_Kunden INSERT>
-- =============================================
CREATE   TRIGGER [dbo].[tr_KundenINSERT]
   ON   [dbo].[tb_Kunden]
   FOR INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO dbo.KundenLog
			(Mode, KundenID, KundenVorname, KundenNachname, KundenAusweisID, KundenGender, Land, KundenTelefone, KundenEmail, KundenGebDat)
	SELECT   'I',  KundenID, Vorname, Nachname, AusweisID, Gender, Land, Telefone, Email, GebDat 
	FROM inserted;
END
GO
ALTER TABLE [dbo].[tb_Kunden] ENABLE TRIGGER [tr_KundenINSERT]
GO
/****** Object:  Trigger [dbo].[tr_KundenUPDATE]    Script Date: 23.03.2023 15:58:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <20.03.2023>
-- Description:	<Kunden UPDATE>
-- =============================================
CREATE   TRIGGER [dbo].[tr_KundenUPDATE]
   ON  [dbo].[tb_Kunden]
   FOR UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO dbo.KundenLog
			(Mode, KundenID, KundenVorname, KundenNachname, KundenAusweisID, KundenGender, Land, Telefone_Alte, KundenTelefone, KundenEmail, KundenGebDat)
	SELECT   'U',  KundenID, Vorname, Nachname, AusweisID, Gender, Land, 
	(select Telefone from deleted), (select Telefone from inserted), Email, GebDat 
	FROM deleted;
END
GO
ALTER TABLE [dbo].[tb_Kunden] ENABLE TRIGGER [tr_KundenUPDATE]
GO
/****** Object:  Trigger [dbo].[tr_add_zimmer_reservierung]    Script Date: 23.03.2023 15:58:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   TRIGGER [dbo].[tr_add_zimmer_reservierung] 
   ON  [dbo].[tb_Reservierung]
   FOR INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @ZimmerTypID smallint = (SELECT ZimmerTypID FROM inserted)
	DECLARE @AnzahlZimmer smallint = (SELECT AnzahlZimmer FROM inserted)
	DECLARE @CheckIn datetime = (SELECT CheckIn FROM inserted)
	DECLARE @CheckOut datetime = (SELECT CheckOut FROM inserted)
	DECLARE @ReservierenID int = (SELECT [ReservierenID] FROM inserted)
	DECLARE @ZimmerID int;

	DECLARE @TypName NVARCHAR(50) = (
	SELECT [TypName]
	FROM [dbo].[tb_ZimmerTyp]
	WHERE [ZimmerTypID] = @ZimmerTypID
	)

	SELECT *
	INTO #tb_rooms
	FROM [dbo].[tf_All_free_rooms_ofType_von_bis_days] (
			@CheckIn,
			@CheckOut,
			@TypName
		)

	--BEGIN TRY
		DECLARE @msg AS nvarchar(MAX);

		DECLARE @freieZimmer int = (
			SELECT COUNT(ZimmerID)
			FROM #tb_rooms
		)
		IF @freieZimmer < @AnzahlZimmer -- nicht genug Zimmer frei
			BEGIN
				SET @msg = 'Nicht genug Zimmer ' + CAST(@freieZimmer AS VARCHAR) + ' vom Typ ' + @TypName + 'frei!\n Gewünscht: ' + CAST(@AnzahlZimmer AS VARCHAR);
				THROW 50005, @msg , 1;
			END
		

		DECLARE zimmer_cursor CURSOR FOR 
			SELECT ZimmerID 
			FROM #tb_rooms
			ORDER BY ZimmerID;
		OPEN zimmer_cursor;
			DECLARE @i int = 0
			FETCH NEXT FROM zimmer_cursor INTO @ZimmerID; -- go to record 1
			WHILE @@FETCH_STATUS = 0 AND @i < @AnzahlZimmer -- Die FETCH-Anweisung war erfolgreich....
			BEGIN
				SET @i = @i + 1
				INSERT INTO [dbo].[tb_Reservieren_Zimmer](ReservierenID, ZimmerID)
				VALUES(@ReservierenID, @ZimmerID)
				FETCH NEXT FROM zimmer_cursor INTO @ZimmerID; -- go to next record
		
			END 
		CLOSE zimmer_cursor;
	--END TRY
	--BEGIN CATCH
	--	SET @msg = ERROR_MESSAGE() + CHAR(10)-- Zeilenumbruch
	--					+ 'Fehler Nr. ' + CONVERT(varchar, ERROR_NUMBER()) + CHAR(10)
	--					+ 'Prozedur: '  + ERROR_PROCEDURE() + CHAR(10)
	--					+ 'Zeile Nr.: ' + CONVERT(varchar,  ERROR_LINE());	
	--END CATCH


END
GO
ALTER TABLE [dbo].[tb_Reservierung] ENABLE TRIGGER [tr_add_zimmer_reservierung]
GO
/****** Object:  Trigger [dbo].[tr_ReservierungDELETE]    Script Date: 23.03.2023 15:58:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <22.03.2023>
-- Description:	<Reservierung DELETE>
-- =============================================
CREATE   TRIGGER [dbo].[tr_ReservierungDELETE]
   ON  [dbo].[tb_Reservierung]
   FOR DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO dbo.ReservierungLog
			(Mode, ReservierenID, ZimmerTypID, KundenID, PersonalID, ReDatum, ReStatus,ReBezahlungStatus, ReAnzahlPerson, ReAnzahlZimmer, ReCheckIn, ReCheckOut)
	SELECT   'D',  ReservierenID, ZimmerTypID, KundenID, PersonalID, Datum, Status,BezahlungStatus, AnzahlPerson, AnzahlZimmer, CheckIn, CheckOut 
	FROM deleted;
END
GO
ALTER TABLE [dbo].[tb_Reservierung] ENABLE TRIGGER [tr_ReservierungDELETE]
GO
/****** Object:  Trigger [dbo].[tr_ReservierungINSERT]    Script Date: 23.03.2023 15:58:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <22.03.2023>
-- Description:	<INSERT Reservierung>
-- =============================================
CREATE   TRIGGER [dbo].[tr_ReservierungINSERT]
   ON  [dbo].[tb_Reservierung]
   FOR INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO dbo.ReservierungLog
			(Mode, ReservierenID, ZimmerTypID, KundenID, PersonalID, ReDatum, ReStatus,ReBezahlungStatus, ReAnzahlPerson, ReAnzahlZimmer, ReCheckIn, ReCheckOut)
	SELECT   'I',  ReservierenID, ZimmerTypID, KundenID, PersonalID, Datum, Status,BezahlungStatus, AnzahlPerson, AnzahlZimmer, CheckIn, CheckOut 
	FROM inserted;
END
GO
ALTER TABLE [dbo].[tb_Reservierung] ENABLE TRIGGER [tr_ReservierungINSERT]
GO
/****** Object:  Trigger [dbo].[tr_ReservierungUPDATE]    Script Date: 23.03.2023 15:58:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <22.03.2023>
-- Description:	<Reservierung UPDATE>
-- =============================================
CREATE TRIGGER [dbo].[tr_ReservierungUPDATE]
   ON  [dbo].[tb_Reservierung]
   FOR UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO dbo.ReservierungLog
			(Mode, ReservierenID, ZimmerTypID, KundenID, PersonalID, ReDatum, ReStatus,ReBezahlungStatus_Alte, ReBezahlungStatus, ReAnzahlPerson, ReAnzahlZimmer, ReCheckIn, ReCheckOut)
	SELECT   'U',  ReservierenID, ZimmerTypID, KundenID, PersonalID, Datum, Status,
	( select BezahlungStatus from deleted), (select BezahlungStatus from inserted),AnzahlPerson,	AnzahlZimmer, CheckIn, CheckOut 
	FROM deleted;
END
GO
ALTER TABLE [dbo].[tb_Reservierung] ENABLE TRIGGER [tr_ReservierungUPDATE]
GO
/****** Object:  Trigger [dbo].[tr_KundenBezahlt_DELETE]    Script Date: 23.03.2023 15:58:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <22.03.2023>
-- Description:	<Bezahlung Status UPDATE >
-- =============================================
CREATE   TRIGGER [dbo].[tr_KundenBezahlt_DELETE]
   ON   [dbo].[tb_Zahlung]
   FOR DELETE --, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Saldo AS MONEY
	DECLARE @ReservierenID AS INT


	SET @ReservierenID = (SELECT ReservierenID FROM deleted)
	SET @Saldo = [dbo].[sf_Saldo_Reservierung](@ReservierenID)

	IF @Saldo >= 0
		BEGIN
			UPDATE dbo.tb_Reservierung 
			SET BezahlungStatus = 1
			WHERE ReservierenID = @ReservierenID
		END
	ELSE
		BEGIN
			UPDATE dbo.tb_Reservierung 
			SET BezahlungStatus = 0
			WHERE ReservierenID = @ReservierenID	
		END

END
GO
ALTER TABLE [dbo].[tb_Zahlung] ENABLE TRIGGER [tr_KundenBezahlt_DELETE]
GO
/****** Object:  Trigger [dbo].[tr_KundenBezahlt_INSERT]    Script Date: 23.03.2023 15:58:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <22.03.2023>
-- Description:	<Bezahlung Status UPDATE >
-- =============================================
CREATE   TRIGGER [dbo].[tr_KundenBezahlt_INSERT]
   ON   [dbo].[tb_Zahlung]
   FOR INSERT--, DELETE, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Saldo AS MONEY
	DECLARE @ReservierenID AS INT


	SET @ReservierenID = (SELECT ReservierenID FROM inserted)
	SET @Saldo = [dbo].[sf_Saldo_Reservierung](@ReservierenID)

	IF @Saldo >= 0
		BEGIN
			UPDATE dbo.tb_Reservierung 
			SET BezahlungStatus = 1
			WHERE ReservierenID = @ReservierenID
		END
	ELSE
		BEGIN
			UPDATE dbo.tb_Reservierung 
			SET BezahlungStatus = 0
			WHERE ReservierenID = @ReservierenID	
		END

END
GO
ALTER TABLE [dbo].[tb_Zahlung] ENABLE TRIGGER [tr_KundenBezahlt_INSERT]
GO
/****** Object:  Trigger [dbo].[tr_KundenBezahlt_UPDATE]    Script Date: 23.03.2023 15:58:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Thao Nguyen>
-- Create date: <22.03.2023>
-- Description:	<Bezahlung Status UPDATE >
-- =============================================
CREATE   TRIGGER [dbo].[tr_KundenBezahlt_UPDATE]
   ON   [dbo].[tb_Zahlung]
   FOR UPDATE --, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Saldo AS MONEY
	DECLARE @ReservierenID AS INT


	SET @ReservierenID = (SELECT ReservierenID FROM inserted)
	SET @Saldo = [dbo].[sf_Saldo_Reservierung](@ReservierenID)

	IF @Saldo >= 0
		BEGIN
			UPDATE dbo.tb_Reservierung 
			SET BezahlungStatus = 1
			WHERE ReservierenID = @ReservierenID
		END
	ELSE
		BEGIN
			UPDATE dbo.tb_Reservierung 
			SET BezahlungStatus = 0
			WHERE ReservierenID = @ReservierenID	
		END

END
GO
ALTER TABLE [dbo].[tb_Zahlung] ENABLE TRIGGER [tr_KundenBezahlt_UPDATE]
GO
