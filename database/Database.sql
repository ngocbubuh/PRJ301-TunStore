USE [master]
GO
/****** Object:  Database [Assignment_PRJ301_UserManagement]    Script Date: 7/8/2023 9:37:07 PM ******/
CREATE DATABASE [Assignment_PRJ301_UserManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UserManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.NGOCBAO\MSSQL\DATA\UserManagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'UserManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.NGOCBAO\MSSQL\DATA\UserManagement_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Assignment_PRJ301_UserManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET RECOVERY FULL 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET  MULTI_USER 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Assignment_PRJ301_UserManagement', N'ON'
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET QUERY_STORE = ON
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Assignment_PRJ301_UserManagement]
GO
/****** Object:  Table [dbo].[tblOrderDetails]    Script Date: 7/8/2023 9:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetails](
	[orderDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[orderID] [int] NOT NULL,
	[productID] [nvarchar](50) NOT NULL,
	[price] [float] NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[orderDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrders]    Script Date: 7/8/2023 9:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrders](
	[orderID] [int] IDENTITY(1,1) NOT NULL,
	[orderCode] [varchar](50) NOT NULL,
	[userID] [nvarchar](50) NOT NULL,
	[date] [date] NOT NULL,
	[total] [float] NOT NULL,
	[payment_Method] [varchar](10) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProducts]    Script Date: 7/8/2023 9:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProducts](
	[productID] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[price] [float] NOT NULL,
	[quantity] [int] NOT NULL,
	[image] [nchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 7/8/2023 9:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[userID] [nvarchar](50) NOT NULL,
	[fullName] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[roleID] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[googleId] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblOrderDetails] ON 

INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (1, 1, N'P01', 10000, 2)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (2, 1, N'P06', 25000, 5)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (3, 1, N'P09', 30000, 3)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (4, 1, N'P08', 40000, 2)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (5, 2, N'P06', 25000, 1)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (6, 3, N'P01', 10000, 1)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (7, 3, N'P04', 17000, 4)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (8, 4, N'P03', 15000, 7)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (9, 4, N'P02', 12000, 3)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (10, 4, N'P07', 22000, 5)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (11, 4, N'P09', 30000, 4)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (12, 5, N'P01', 10000, 2)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (13, 5, N'P03', 15000, 1)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (14, 5, N'P02', 12000, 3)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (15, 5, N'P07', 22000, 2)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (16, 5, N'P08', 40000, 1)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (17, 6, N'P05', 20000, 2)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (18, 6, N'P04', 17000, 1)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (19, 6, N'P08', 40000, 1)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (20, 7, N'P05', 20000, 2)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (21, 7, N'P09', 30000, 1)
INSERT [dbo].[tblOrderDetails] ([orderDetailsID], [orderID], [productID], [price], [quantity]) VALUES (22, 7, N'P08', 40000, 1)
SET IDENTITY_INSERT [dbo].[tblOrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[tblOrders] ON 

INSERT [dbo].[tblOrders] ([orderID], [orderCode], [userID], [date], [total], [payment_Method], [status]) VALUES (1, N'39969264', N'1005hanhphuc', CAST(N'2023-05-07' AS Date), 315000, N'VNPAY', 1)
INSERT [dbo].[tblOrders] ([orderID], [orderCode], [userID], [date], [total], [payment_Method], [status]) VALUES (2, N'97995008', N'1005hanhphuc', CAST(N'2023-05-07' AS Date), 25000, N'COD', 1)
INSERT [dbo].[tblOrders] ([orderID], [orderCode], [userID], [date], [total], [payment_Method], [status]) VALUES (3, N'46528642', N'1005hanhphuc', CAST(N'2023-05-07' AS Date), 78000, N'COD', 1)
INSERT [dbo].[tblOrders] ([orderID], [orderCode], [userID], [date], [total], [payment_Method], [status]) VALUES (4, N'99953204', N'1005hanhphuc', CAST(N'2023-06-07' AS Date), 371000, N'VNPAY', 1)
INSERT [dbo].[tblOrders] ([orderID], [orderCode], [userID], [date], [total], [payment_Method], [status]) VALUES (5, N'83317580', N'1005hanhphuc', CAST(N'2023-06-07' AS Date), 155000, N'COD', 1)
INSERT [dbo].[tblOrders] ([orderID], [orderCode], [userID], [date], [total], [payment_Method], [status]) VALUES (6, N'02413511', N'1005hanhphuc', CAST(N'2023-07-07' AS Date), 97000, N'VNPAY', 1)
INSERT [dbo].[tblOrders] ([orderID], [orderCode], [userID], [date], [total], [payment_Method], [status]) VALUES (7, N'24771928', N'lmhtjhdusdia', CAST(N'2023-07-07' AS Date), 110000, N'COD', 1)
SET IDENTITY_INSERT [dbo].[tblOrders] OFF
GO
INSERT [dbo].[tblProducts] ([productID], [name], [price], [quantity], [image]) VALUES (N'P01', N'Sun Flower', 10000, 95, N'SunFL.jpg                                         ')
INSERT [dbo].[tblProducts] ([productID], [name], [price], [quantity], [image]) VALUES (N'P02', N'Rose Flower', 12000, 94, N'RoseFL.jpg                                        ')
INSERT [dbo].[tblProducts] ([productID], [name], [price], [quantity], [image]) VALUES (N'P03', N'Daisy Flower', 15000, 92, N'DaisyFL.jpg                                       ')
INSERT [dbo].[tblProducts] ([productID], [name], [price], [quantity], [image]) VALUES (N'P04', N'Tulip Flower', 17000, 95, N'TulipFL.jpg                                       ')
INSERT [dbo].[tblProducts] ([productID], [name], [price], [quantity], [image]) VALUES (N'P05', N'Lavender Flower', 20000, 96, N'LavenderFL.jpg                                    ')
INSERT [dbo].[tblProducts] ([productID], [name], [price], [quantity], [image]) VALUES (N'P06', N'Dandelion Flower', 25000, 94, N'DandelionFL.jpg                                   ')
INSERT [dbo].[tblProducts] ([productID], [name], [price], [quantity], [image]) VALUES (N'P07', N'ButterCup Flower', 22000, 93, N'ButterCupFL.jpg                                   ')
INSERT [dbo].[tblProducts] ([productID], [name], [price], [quantity], [image]) VALUES (N'P08', N'Blood Lily Flower', 40000, 95, N'BloodLilyFL.jpg                                   ')
INSERT [dbo].[tblProducts] ([productID], [name], [price], [quantity], [image]) VALUES (N'P09', N'Lady of the Night', 30000, 92, N'LOTNFL.jpg                                        ')
GO
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [email], [googleId]) VALUES (N'1005hanhphuc', N'Pham Ngoc Bao', N'123iausgfkjzxbfieryqoqwlkkzdfn883401', N'AD', N'1005hanhphuc@gmail.com', N'102883124713935558529')
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [email], [googleId]) VALUES (N'admin', N'Toi la Ngoc Bao Cutee', N'1', N'AD', NULL, NULL)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [email], [googleId]) VALUES (N'baopnse171066', N'Pham Ngoc Bao (K17 HCM)', N'123iausgfkjzxbfieryqoqwlkkzdfn883401', N'US', N'baopnse171066@fpt.edu.vn', N'110371207102105369655')
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [email], [googleId]) VALUES (N'Hoadnt', N'Hoa Doan Cute', N'1', N'US', NULL, NULL)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [email], [googleId]) VALUES (N'lmhtjhdusdia', N'Vit Con Peroro', N'123iausgfkjzxbfieryqoqwlkkzdfn883401', N'US', N'lmhtjhdusdia@gmail.com', N'101628528253665215657')
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [email], [googleId]) VALUES (N'SE130363', N'Ngo Ha Tri Bao', N'1', N'AD', NULL, NULL)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [email], [googleId]) VALUES (N'SE140103', N'Phuoc Ha', N'1', N'US', NULL, NULL)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [email], [googleId]) VALUES (N'SE140119', N'Trai Nguyen', N'1', N'AD', NULL, NULL)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [email], [googleId]) VALUES (N'SE140130', N'Tam Tran', N'1', N'AD', NULL, NULL)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [email], [googleId]) VALUES (N'SE140201', N'PHAM HOANG TU', N'1', N'US', NULL, NULL)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [email], [googleId]) VALUES (N'SE140969', N'Nguyen Gia Tin', N'123', N'US', NULL, NULL)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [email], [googleId]) VALUES (N'SE150443', N'LE MINH KHOA', N'1', N'US', NULL, NULL)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tblOrder__23699D68FA9A0518]    Script Date: 7/8/2023 9:37:07 PM ******/
ALTER TABLE [dbo].[tblOrders] ADD UNIQUE NONCLUSTERED 
(
	[orderCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblOrders] ADD  DEFAULT ('COD') FOR [payment_Method]
GO
ALTER TABLE [dbo].[tblOrderDetails]  WITH CHECK ADD FOREIGN KEY([orderID])
REFERENCES [dbo].[tblOrders] ([orderID])
GO
ALTER TABLE [dbo].[tblOrderDetails]  WITH CHECK ADD FOREIGN KEY([productID])
REFERENCES [dbo].[tblProducts] ([productID])
GO
ALTER TABLE [dbo].[tblOrders]  WITH CHECK ADD FOREIGN KEY([userID])
REFERENCES [dbo].[tblUsers] ([userID])
GO
USE [master]
GO
ALTER DATABASE [Assignment_PRJ301_UserManagement] SET  READ_WRITE 
GO
