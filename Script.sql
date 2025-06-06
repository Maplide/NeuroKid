USE [master]
GO
/****** Object:  Database [neurokidDB]    Script Date: 22/05/2025 11:59:38 ******/
CREATE DATABASE [neurokidDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'neurokidDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\neurokidDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'neurokidDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\neurokidDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [neurokidDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [neurokidDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [neurokidDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [neurokidDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [neurokidDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [neurokidDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [neurokidDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [neurokidDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [neurokidDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [neurokidDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [neurokidDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [neurokidDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [neurokidDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [neurokidDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [neurokidDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [neurokidDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [neurokidDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [neurokidDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [neurokidDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [neurokidDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [neurokidDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [neurokidDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [neurokidDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [neurokidDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [neurokidDB] SET RECOVERY FULL 
GO
ALTER DATABASE [neurokidDB] SET  MULTI_USER 
GO
ALTER DATABASE [neurokidDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [neurokidDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [neurokidDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [neurokidDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [neurokidDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [neurokidDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'neurokidDB', N'ON'
GO
ALTER DATABASE [neurokidDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [neurokidDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [neurokidDB]
GO
/****** Object:  Table [dbo].[auth_group]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_group](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_group_permissions]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_group_permissions](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[group_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_permission]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_permission](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[content_type_id] [int] NOT NULL,
	[codename] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[password] [nvarchar](128) NOT NULL,
	[last_login] [datetimeoffset](7) NULL,
	[is_superuser] [bit] NOT NULL,
	[username] [nvarchar](150) NOT NULL,
	[first_name] [nvarchar](150) NOT NULL,
	[last_name] [nvarchar](150) NOT NULL,
	[email] [nvarchar](254) NOT NULL,
	[is_staff] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
	[date_joined] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user_groups]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user_groups](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[group_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user_user_permissions]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user_user_permissions](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_admin_log]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_admin_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[action_time] [datetimeoffset](7) NOT NULL,
	[object_id] [nvarchar](max) NULL,
	[object_repr] [nvarchar](200) NOT NULL,
	[action_flag] [smallint] NOT NULL,
	[change_message] [nvarchar](max) NOT NULL,
	[content_type_id] [int] NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_content_type]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_content_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[app_label] [nvarchar](100) NOT NULL,
	[model] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_migrations]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_migrations](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[app] [nvarchar](255) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[applied] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_session]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_session](
	[session_key] [nvarchar](40) NOT NULL,
	[session_data] [nvarchar](max) NOT NULL,
	[expire_date] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[session_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluaciones_especialista]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluaciones_especialista](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[dni] [nvarchar](15) NOT NULL,
	[rne] [nvarchar](30) NOT NULL,
	[telefono] [nvarchar](20) NOT NULL,
	[institucion] [nvarchar](100) NOT NULL,
	[perfil_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluaciones_evaluacion]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluaciones_evaluacion](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[fecha] [datetimeoffset](7) NOT NULL,
	[resultado] [nvarchar](max) NOT NULL,
	[nino_id] [bigint] NOT NULL,
	[observaciones] [nvarchar](max) NULL,
	[especialista_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluaciones_intentojuego]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluaciones_intentojuego](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[resultado] [int] NOT NULL,
	[fecha] [datetimeoffset](7) NOT NULL,
	[nino_id] [bigint] NOT NULL,
	[juego_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluaciones_intentojuegoinvitado]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluaciones_intentojuegoinvitado](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[invitado_id] [nvarchar](100) NOT NULL,
	[resultado] [int] NOT NULL,
	[fecha] [datetimeoffset](7) NOT NULL,
	[juego_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluaciones_juego]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluaciones_juego](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[descripcion] [nvarchar](max) NOT NULL,
	[tipo] [nvarchar](50) NOT NULL,
	[activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluaciones_logenvioreporte]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluaciones_logenvioreporte](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[fecha_envio] [datetimeoffset](7) NOT NULL,
	[metodo] [nvarchar](20) NOT NULL,
	[exito] [bit] NOT NULL,
	[mensaje] [nvarchar](max) NOT NULL,
	[especialista_id] [bigint] NOT NULL,
	[nino_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluaciones_nino]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluaciones_nino](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[fecha_nacimiento] [date] NOT NULL,
	[genero] [nvarchar](10) NOT NULL,
	[email] [nvarchar](254) NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluaciones_perfil]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluaciones_perfil](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[rol] [nvarchar](20) NOT NULL,
	[fecha_nacimiento] [date] NULL,
	[especialidad] [nvarchar](100) NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluaciones_resultado]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluaciones_resultado](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[puntuacion] [int] NOT NULL,
	[interpretacion] [nvarchar](max) NOT NULL,
	[fecha] [datetimeoffset](7) NOT NULL,
	[juego_id] [bigint] NOT NULL,
	[nino_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluaciones_resultadoia]    Script Date: 22/05/2025 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluaciones_resultadoia](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[prediccion] [nvarchar](100) NOT NULL,
	[probabilidad] [float] NOT NULL,
	[fecha] [datetimeoffset](7) NOT NULL,
	[juego_id] [bigint] NOT NULL,
	[nino_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[auth_permission] ON 

INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (1, N'Can add log entry', 1, N'add_logentry')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (2, N'Can change log entry', 1, N'change_logentry')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (3, N'Can delete log entry', 1, N'delete_logentry')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (4, N'Can view log entry', 1, N'view_logentry')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (5, N'Can add permission', 2, N'add_permission')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (6, N'Can change permission', 2, N'change_permission')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (7, N'Can delete permission', 2, N'delete_permission')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (8, N'Can view permission', 2, N'view_permission')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (9, N'Can add group', 3, N'add_group')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (10, N'Can change group', 3, N'change_group')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (11, N'Can delete group', 3, N'delete_group')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (12, N'Can view group', 3, N'view_group')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (13, N'Can add user', 4, N'add_user')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (14, N'Can change user', 4, N'change_user')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (15, N'Can delete user', 4, N'delete_user')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (16, N'Can view user', 4, N'view_user')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (17, N'Can add content type', 5, N'add_contenttype')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (18, N'Can change content type', 5, N'change_contenttype')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (19, N'Can delete content type', 5, N'delete_contenttype')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (20, N'Can view content type', 5, N'view_contenttype')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (21, N'Can add session', 6, N'add_session')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (22, N'Can change session', 6, N'change_session')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (23, N'Can delete session', 6, N'delete_session')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (24, N'Can view session', 6, N'view_session')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (25, N'Can add nino', 7, N'add_nino')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (26, N'Can change nino', 7, N'change_nino')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (27, N'Can delete nino', 7, N'delete_nino')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (28, N'Can view nino', 7, N'view_nino')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (29, N'Can add evaluacion', 8, N'add_evaluacion')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (30, N'Can change evaluacion', 8, N'change_evaluacion')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (31, N'Can delete evaluacion', 8, N'delete_evaluacion')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (32, N'Can view evaluacion', 8, N'view_evaluacion')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (33, N'Can add especialista', 9, N'add_especialista')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (34, N'Can change especialista', 9, N'change_especialista')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (35, N'Can delete especialista', 9, N'delete_especialista')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (36, N'Can view especialista', 9, N'view_especialista')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (37, N'Can add juego', 10, N'add_juego')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (38, N'Can change juego', 10, N'change_juego')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (39, N'Can delete juego', 10, N'delete_juego')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (40, N'Can view juego', 10, N'view_juego')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (41, N'Can add intento juego', 11, N'add_intentojuego')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (42, N'Can change intento juego', 11, N'change_intentojuego')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (43, N'Can delete intento juego', 11, N'delete_intentojuego')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (44, N'Can view intento juego', 11, N'view_intentojuego')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (45, N'Can add perfil', 12, N'add_perfil')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (46, N'Can change perfil', 12, N'change_perfil')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (47, N'Can delete perfil', 12, N'delete_perfil')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (48, N'Can view perfil', 12, N'view_perfil')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (49, N'Can add resultado', 13, N'add_resultado')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (50, N'Can change resultado', 13, N'change_resultado')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (51, N'Can delete resultado', 13, N'delete_resultado')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (52, N'Can view resultado', 13, N'view_resultado')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (53, N'Can add resultado ia', 14, N'add_resultadoia')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (54, N'Can change resultado ia', 14, N'change_resultadoia')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (55, N'Can delete resultado ia', 14, N'delete_resultadoia')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (56, N'Can view resultado ia', 14, N'view_resultadoia')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (57, N'Can add intento juego invitado', 15, N'add_intentojuegoinvitado')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (58, N'Can change intento juego invitado', 15, N'change_intentojuegoinvitado')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (59, N'Can delete intento juego invitado', 15, N'delete_intentojuegoinvitado')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (60, N'Can view intento juego invitado', 15, N'view_intentojuegoinvitado')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (61, N'Can add log envio reporte', 16, N'add_logenvioreporte')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (62, N'Can change log envio reporte', 16, N'change_logenvioreporte')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (63, N'Can delete log envio reporte', 16, N'delete_logenvioreporte')
INSERT [dbo].[auth_permission] ([id], [name], [content_type_id], [codename]) VALUES (64, N'Can view log envio reporte', 16, N'view_logenvioreporte')
SET IDENTITY_INSERT [dbo].[auth_permission] OFF
GO
SET IDENTITY_INSERT [dbo].[auth_user] ON 

INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (1, N'pbkdf2_sha256$720000$KKcKE21MlxTC05QTKhBtmA$fmKi4uFlblIjlwdk3WDYoPDjJhYvocWzpRq+KYeuJqo=', CAST(N'2025-04-19T05:20:34.5968120+00:00' AS DateTimeOffset), 0, N'Admin', N'', N'', N'', 0, 1, CAST(N'2025-04-19T05:20:01.2812240+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (2, N'pbkdf2_sha256$720000$scRE7xHBKj7rYNpmqj1o7D$ehpbYdrq92I3H4sL1PtSw3+00qn1sXtPcuUfTZzeQ6M=', CAST(N'2025-04-30T14:47:13.7616770+00:00' AS DateTimeOffset), 0, N'Especialista1', N'', N'', N'', 0, 1, CAST(N'2025-04-24T16:12:09.2649700+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (3, N'pbkdf2_sha256$720000$bjvIfjTJaVcdZbB4BfIDpA$AbpzZFfz+ecil0vRUuV7Hw2KWNbOBS1zVHYo9AafMSw=', CAST(N'2025-04-30T15:33:27.7991610+00:00' AS DateTimeOffset), 0, N'Niño1', N'', N'', N'', 0, 1, CAST(N'2025-04-24T16:13:09.8357510+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (105, N'pbkdf2_sha256$720000$FgkVBhbD1zijjxy50ucbIx$bo4MgcS0AD3d5N7TmIbGfR/WZ/IFxg0tYkc4twRn2Q0=', CAST(N'2025-04-30T15:57:04.5519860+00:00' AS DateTimeOffset), 0, N'Nino1', N'', N'', N'', 0, 1, CAST(N'2025-04-30T15:57:04.5238850+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (106, N'pbkdf2_sha256$720000$2RmMOMFl3IkpGOfSl7KXvK$/THXpefSORBwqZi5KPbFFanLttSZq6MMlqlmSI1FKAk=', CAST(N'2025-04-30T16:01:03.0907850+00:00' AS DateTimeOffset), 0, N'Nino2', N'', N'', N'', 0, 1, CAST(N'2025-04-30T16:01:03.0744250+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (107, N'pbkdf2_sha256$720000$qTdijy4R9qHkqbK1hZb57X$o/GHoL0S86D4PqgQNn+Bly21t+tKPOgnQ1bhHMIv9V0=', CAST(N'2025-04-30T16:06:58.5645460+00:00' AS DateTimeOffset), 0, N'Nino3', N'', N'', N'', 0, 1, CAST(N'2025-04-30T16:06:58.5413920+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (108, N'pbkdf2_sha256$720000$2s3XMOSKtExkK1GmRev62c$JYg5HJKNPss9uPi9WJ+o2ayr+leqaYhQVFj5ls2HKjA=', CAST(N'2025-04-30T16:14:06.8910720+00:00' AS DateTimeOffset), 0, N'Nino4', N'', N'', N'', 0, 1, CAST(N'2025-04-30T16:14:06.8735310+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (109, N'pbkdf2_sha256$720000$JKVzsTpuGF6JGiWFYjs76q$9WupTxg8+14+B4xyOUDENLMV119t3LV6inJXNjm2ytc=', CAST(N'2025-04-30T16:17:49.0859290+00:00' AS DateTimeOffset), 0, N'Nino5', N'', N'', N'', 0, 1, CAST(N'2025-04-30T16:17:49.0631860+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (110, N'pbkdf2_sha256$720000$oZ05BqQrEsP3kkPx1KETxe$l7KrL6VEhzzzETV+dbwBdh8PHa80YxC6KiMp8fYLrcs=', CAST(N'2025-05-20T02:44:03.6917880+00:00' AS DateTimeOffset), 0, N'Nino6', N'', N'', N'', 0, 1, CAST(N'2025-04-30T16:22:28.1546100+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (111, N'pbkdf2_sha256$720000$KCtX2ewHymiBVbQkxp1K0X$ZcfqOJS/puKFB7Vs491ohVikPw23qdzisPGcJ3GUQ5Y=', CAST(N'2025-05-15T17:24:47.4599130+00:00' AS DateTimeOffset), 0, N'Especialista2', N'', N'', N'', 0, 1, CAST(N'2025-04-30T19:46:18.7686140+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (212, N'', NULL, 0, N'nino_simulado_1', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.1824970+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (213, N'', NULL, 0, N'nino_simulado_2', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.2083380+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (214, N'', NULL, 0, N'nino_simulado_3', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.2204910+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (215, N'', NULL, 0, N'nino_simulado_4', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.2343960+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (216, N'', NULL, 0, N'nino_simulado_5', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.2478580+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (217, N'', NULL, 0, N'nino_simulado_6', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.2597580+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (218, N'', NULL, 0, N'nino_simulado_7', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.2723290+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (219, N'', NULL, 0, N'nino_simulado_8', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.2843930+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (220, N'', NULL, 0, N'nino_simulado_9', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.2961910+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (221, N'', NULL, 0, N'nino_simulado_10', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.3098110+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (222, N'', NULL, 0, N'nino_simulado_11', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.3253850+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (223, N'', NULL, 0, N'nino_simulado_12', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.3375450+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (224, N'', NULL, 0, N'nino_simulado_13', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.3494370+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (225, N'', NULL, 0, N'nino_simulado_14', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.3610400+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (226, N'', NULL, 0, N'nino_simulado_15', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.3734880+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (227, N'', NULL, 0, N'nino_simulado_16', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.3871490+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (228, N'', NULL, 0, N'nino_simulado_17', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.4000520+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (229, N'', NULL, 0, N'nino_simulado_18', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.4128480+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (230, N'', NULL, 0, N'nino_simulado_19', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.4263990+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (231, N'', NULL, 0, N'nino_simulado_20', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.4387290+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (232, N'', NULL, 0, N'nino_simulado_21', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.4515460+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (233, N'', NULL, 0, N'nino_simulado_22', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.4650010+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (234, N'', NULL, 0, N'nino_simulado_23', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.4821030+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (235, N'', NULL, 0, N'nino_simulado_24', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.5044190+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (236, N'', NULL, 0, N'nino_simulado_25', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.5229210+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (237, N'', NULL, 0, N'nino_simulado_26', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.5381420+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (238, N'', NULL, 0, N'nino_simulado_27', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.5525780+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (239, N'', NULL, 0, N'nino_simulado_28', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.5651000+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (240, N'', NULL, 0, N'nino_simulado_29', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.5777300+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (241, N'', NULL, 0, N'nino_simulado_30', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.5899410+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (242, N'', NULL, 0, N'nino_simulado_31', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.6035520+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (243, N'', NULL, 0, N'nino_simulado_32', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.6149850+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (244, N'', NULL, 0, N'nino_simulado_33', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.6269390+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (245, N'', NULL, 0, N'nino_simulado_34', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.6389380+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (246, N'', NULL, 0, N'nino_simulado_35', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.6511930+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (247, N'', NULL, 0, N'nino_simulado_36', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.6629600+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (248, N'', NULL, 0, N'nino_simulado_37', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.6740640+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (249, N'', NULL, 0, N'nino_simulado_38', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.6849870+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (250, N'', NULL, 0, N'nino_simulado_39', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.6960670+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (251, N'', NULL, 0, N'nino_simulado_40', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.7070640+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (252, N'', NULL, 0, N'nino_simulado_41', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.7184800+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (253, N'', NULL, 0, N'nino_simulado_42', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.7309390+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (254, N'', NULL, 0, N'nino_simulado_43', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.7435930+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (255, N'', NULL, 0, N'nino_simulado_44', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.7560060+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (256, N'', NULL, 0, N'nino_simulado_45', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.7675130+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (257, N'', NULL, 0, N'nino_simulado_46', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.7790640+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (258, N'', NULL, 0, N'nino_simulado_47', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.7913470+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (259, N'', NULL, 0, N'nino_simulado_48', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.8031490+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (260, N'', NULL, 0, N'nino_simulado_49', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.8152210+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (261, N'', NULL, 0, N'nino_simulado_50', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.8270760+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (262, N'', NULL, 0, N'nino_simulado_51', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.8388810+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (263, N'', NULL, 0, N'nino_simulado_52', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.8508160+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (264, N'', NULL, 0, N'nino_simulado_53', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.8623510+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (265, N'', NULL, 0, N'nino_simulado_54', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.8747610+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (266, N'', NULL, 0, N'nino_simulado_55', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.8873580+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (267, N'', NULL, 0, N'nino_simulado_56', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.8999650+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (268, N'', NULL, 0, N'nino_simulado_57', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.9115680+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (269, N'', NULL, 0, N'nino_simulado_58', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.9240330+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (270, N'', NULL, 0, N'nino_simulado_59', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.9358210+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (271, N'', NULL, 0, N'nino_simulado_60', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.9476270+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (272, N'', NULL, 0, N'nino_simulado_61', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.9588540+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (273, N'', NULL, 0, N'nino_simulado_62', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.9705460+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (274, N'', NULL, 0, N'nino_simulado_63', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.9843850+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (275, N'', NULL, 0, N'nino_simulado_64', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:19.9963380+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (276, N'', NULL, 0, N'nino_simulado_65', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.0084470+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (277, N'', NULL, 0, N'nino_simulado_66', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.0217630+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (278, N'', NULL, 0, N'nino_simulado_67', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.0333710+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (279, N'', NULL, 0, N'nino_simulado_68', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.0463250+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (280, N'', NULL, 0, N'nino_simulado_69', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.0572200+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (281, N'', NULL, 0, N'nino_simulado_70', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.0697850+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (282, N'', NULL, 0, N'nino_simulado_71', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.0827930+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (283, N'', NULL, 0, N'nino_simulado_72', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.0990870+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (284, N'', NULL, 0, N'nino_simulado_73', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.1139260+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (285, N'', NULL, 0, N'nino_simulado_74', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.1284810+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (286, N'', NULL, 0, N'nino_simulado_75', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.1400280+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (287, N'', NULL, 0, N'nino_simulado_76', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.1520870+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (288, N'', NULL, 0, N'nino_simulado_77', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.1657730+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (289, N'', NULL, 0, N'nino_simulado_78', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.1787650+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (290, N'', NULL, 0, N'nino_simulado_79', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.1914970+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (291, N'', NULL, 0, N'nino_simulado_80', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.2032260+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (292, N'', NULL, 0, N'nino_simulado_81', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.2147570+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (293, N'', NULL, 0, N'nino_simulado_82', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.2263420+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (294, N'', NULL, 0, N'nino_simulado_83', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.2375910+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (295, N'', NULL, 0, N'nino_simulado_84', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.2503750+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (296, N'', NULL, 0, N'nino_simulado_85', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.2628050+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (297, N'', NULL, 0, N'nino_simulado_86', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.2739120+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (298, N'', NULL, 0, N'nino_simulado_87', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.2858240+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (299, N'', NULL, 0, N'nino_simulado_88', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.2970350+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (300, N'', NULL, 0, N'nino_simulado_89', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.3095150+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (301, N'', NULL, 0, N'nino_simulado_90', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.3215780+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (302, N'', NULL, 0, N'nino_simulado_91', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.3335810+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (303, N'', NULL, 0, N'nino_simulado_92', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.3453310+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (304, N'', NULL, 0, N'nino_simulado_93', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.3570280+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (305, N'', NULL, 0, N'nino_simulado_94', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.3694720+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (306, N'', NULL, 0, N'nino_simulado_95', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.3810820+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (307, N'', NULL, 0, N'nino_simulado_96', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.3927070+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (308, N'', NULL, 0, N'nino_simulado_97', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.4049230+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (309, N'', NULL, 0, N'nino_simulado_98', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.4171790+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (310, N'', NULL, 0, N'nino_simulado_99', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.4299030+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (311, N'', NULL, 0, N'nino_simulado_100', N'', N'', N'', 0, 1, CAST(N'2025-04-30T20:45:20.4431810+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (312, N'pbkdf2_sha256$720000$0jREOcEKe2ZscIOBQfsDDs$HpExas6WwRqduFxTSGm3YMYv0tITWoYRY+cX/QyQJS0=', CAST(N'2025-05-06T17:39:39.0481440+00:00' AS DateTimeOffset), 0, N'Especialista3', N'', N'', N'', 0, 1, CAST(N'2025-05-06T17:34:14.1926330+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (313, N'pbkdf2_sha256$720000$4uZVpkptnOCQlh9d4RNOJ9$NenyhISNuCxYtWiP9gXA5Tss/yDM1IS3drP0aeGgFeM=', CAST(N'2025-05-20T02:24:05.7928050+00:00' AS DateTimeOffset), 0, N'Nino7', N'', N'', N'', 0, 1, CAST(N'2025-05-06T17:35:04.5617440+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (314, N'pbkdf2_sha256$720000$MtlkVK5aDnoHLr4n1kmAQ5$AsAb+8dMpjJQIz83Nm6HmgeNmiFIUCKPgV12bfK+ntA=', CAST(N'2025-05-22T16:24:15.9694140+00:00' AS DateTimeOffset), 0, N'Especialista8', N'', N'', N'', 0, 1, CAST(N'2025-05-06T17:43:51.5665410+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (315, N'pbkdf2_sha256$720000$i2lNCJaR6WF1omxWRczNBB$5HzegBSb5fKTfJq+0APQYsYIn7zlp4Hue+6Kqduy/RU=', CAST(N'2025-05-06T18:07:41.6960340+00:00' AS DateTimeOffset), 0, N'Especialista9', N'', N'', N'', 0, 1, CAST(N'2025-05-06T18:07:41.6618120+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (316, N'pbkdf2_sha256$720000$qScVpxqQ9ptlJ6ENZ4Fb1z$7ACml3B7w2cqcFSkgMeqx3QFNzQzBW8Uru9REky6f70=', CAST(N'2025-05-22T15:18:57.7686520+00:00' AS DateTimeOffset), 0, N'Nino8', N'', N'', N'', 0, 1, CAST(N'2025-05-06T18:19:08.6394150+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (317, N'pbkdf2_sha256$720000$OeY9Oo0RBIck4Uu7YCgPta$29bAu9ue1+7T0GaKQtiiw1yx8JFe2v/eehL00Ba2kQU=', CAST(N'2025-05-06T18:58:43.5604510+00:00' AS DateTimeOffset), 0, N'Niño10', N'', N'', N'', 0, 1, CAST(N'2025-05-06T18:58:43.5229640+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (318, N'pbkdf2_sha256$720000$ar1G5oLYHhc1l6wfETj8qH$HBKvxtRk5ZVF9zBYWc/WR+9kG+LvONFGah5F2cxIWk8=', CAST(N'2025-05-06T19:02:34.9479420+00:00' AS DateTimeOffset), 0, N'Especialista10', N'', N'', N'', 0, 1, CAST(N'2025-05-06T19:02:34.9171520+00:00' AS DateTimeOffset))
INSERT [dbo].[auth_user] ([id], [password], [last_login], [is_superuser], [username], [first_name], [last_name], [email], [is_staff], [is_active], [date_joined]) VALUES (319, N'pbkdf2_sha256$720000$1j5Fd3zuznzQCIbqWK6q22$bh0QZ3X3vb0EvXaNslOb/b9cEmmjMzqwwOO/HkOhuuI=', CAST(N'2025-05-22T16:18:37.4065050+00:00' AS DateTimeOffset), 0, N'Nino11', N'', N'', N'', 0, 1, CAST(N'2025-05-22T15:13:27.8751940+00:00' AS DateTimeOffset))
SET IDENTITY_INSERT [dbo].[auth_user] OFF
GO
SET IDENTITY_INSERT [dbo].[django_content_type] ON 

INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (1, N'admin', N'logentry')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (3, N'auth', N'group')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (2, N'auth', N'permission')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (4, N'auth', N'user')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (5, N'contenttypes', N'contenttype')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (9, N'evaluaciones', N'especialista')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (8, N'evaluaciones', N'evaluacion')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (11, N'evaluaciones', N'intentojuego')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (15, N'evaluaciones', N'intentojuegoinvitado')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (10, N'evaluaciones', N'juego')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (16, N'evaluaciones', N'logenvioreporte')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (7, N'evaluaciones', N'nino')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (12, N'evaluaciones', N'perfil')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (13, N'evaluaciones', N'resultado')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (14, N'evaluaciones', N'resultadoia')
INSERT [dbo].[django_content_type] ([id], [app_label], [model]) VALUES (6, N'sessions', N'session')
SET IDENTITY_INSERT [dbo].[django_content_type] OFF
GO
SET IDENTITY_INSERT [dbo].[django_migrations] ON 

INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (1, N'contenttypes', N'0001_initial', CAST(N'2025-04-02T22:01:13.2596650+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (2, N'auth', N'0001_initial', CAST(N'2025-04-02T22:01:13.3254730+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (3, N'admin', N'0001_initial', CAST(N'2025-04-02T22:01:13.3488220+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (4, N'admin', N'0002_logentry_remove_auto_add', CAST(N'2025-04-02T22:01:13.3560660+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (5, N'admin', N'0003_logentry_add_action_flag_choices', CAST(N'2025-04-02T22:01:13.3631290+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (6, N'contenttypes', N'0002_remove_content_type_name', CAST(N'2025-04-02T22:01:14.6283670+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (7, N'auth', N'0002_alter_permission_name_max_length', CAST(N'2025-04-02T22:01:14.6459490+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (8, N'auth', N'0003_alter_user_email_max_length', CAST(N'2025-04-02T22:01:14.6632240+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (9, N'auth', N'0004_alter_user_username_opts', CAST(N'2025-04-02T22:01:14.6751970+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (10, N'auth', N'0005_alter_user_last_login_null', CAST(N'2025-04-02T22:01:15.5085220+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (11, N'auth', N'0006_require_contenttypes_0002', CAST(N'2025-04-02T22:01:15.5129580+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (12, N'auth', N'0007_alter_validators_add_error_messages', CAST(N'2025-04-02T22:01:15.5216010+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (13, N'auth', N'0008_alter_user_username_max_length', CAST(N'2025-04-02T22:01:15.5742600+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (14, N'auth', N'0009_alter_user_last_name_max_length', CAST(N'2025-04-02T22:01:15.5826560+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (15, N'auth', N'0010_alter_group_name_max_length', CAST(N'2025-04-02T22:01:16.2669870+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (16, N'auth', N'0011_update_proxy_permissions', CAST(N'2025-04-02T22:01:16.2764560+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (17, N'auth', N'0012_alter_user_first_name_max_length', CAST(N'2025-04-02T22:01:16.2887440+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (18, N'evaluaciones', N'0001_initial', CAST(N'2025-04-02T22:01:16.3056040+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (19, N'sessions', N'0001_initial', CAST(N'2025-04-02T22:01:16.3156230+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (20, N'evaluaciones', N'0002_auto_20250402_1701', CAST(N'2025-04-09T03:05:53.9185400+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (21, N'evaluaciones', N'0003_especialista_juego_evaluacion_observaciones_and_more', CAST(N'2025-04-09T03:05:54.0289850+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (22, N'evaluaciones', N'0004_remove_nino_nombre_nino_user', CAST(N'2025-04-24T17:51:07.7604970+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (23, N'evaluaciones', N'0005_resultadoia', CAST(N'2025-04-26T20:58:25.4963520+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (24, N'evaluaciones', N'0006_intentojuegoinvitado', CAST(N'2025-05-15T16:11:23.4119260+00:00' AS DateTimeOffset))
INSERT [dbo].[django_migrations] ([id], [app], [name], [applied]) VALUES (25, N'evaluaciones', N'0007_logenvioreporte', CAST(N'2025-05-22T15:01:14.8107550+00:00' AS DateTimeOffset))
SET IDENTITY_INSERT [dbo].[django_migrations] OFF
GO
INSERT [dbo].[django_session] ([session_key], [session_data], [expire_date]) VALUES (N'ditsvwd30g880tlu562qy97f2qp1y1qi', N'.eJxVjDsOwjAQBe_iGln-iXgp6TmDtetd4wBypDipIu4OkVJA-2bmbSrhutS0dpnTyOqivDr9boT5KW0H_MB2n3Se2jKPpHdFH7Tr28Tyuh7u30HFXr81wmBKKNaSeCMGnYciIANH78hbCpw9R85iLLsACOcISGILSDYuOPX-APXiOFw:1u8mNf:In7nlGYbA1AJrKDEv1bKBfOLj7V1AyAkOypDx2gVRsA', CAST(N'2025-05-10T20:44:11.3553050+00:00' AS DateTimeOffset))
INSERT [dbo].[django_session] ([session_key], [session_data], [expire_date]) VALUES (N'fgyc0b1qm4xbwt5zor61bqrzrsn9cfc0', N'.eJxVjDsOwjAQBe_iGln-ZP2hpM8ZLNu7wQHkSHFSIe5OLKWAdmbee7MQ962EvdEaZmRXpqVjl1-aYn5S7Qofsd4Xnpe6rXPiPeGnbXxckF63s_07KLGVviZNkxQKpBPCSiclRBjAeERF4E32XidjD-YdHukwCQcZrQetLAGyzxcJsTdp:1uCNYo:ifREu6t1uQe8d8dwsDuTdudCReBhhsf172tV0KOwZzg', CAST(N'2025-05-20T19:02:34.9543750+00:00' AS DateTimeOffset))
INSERT [dbo].[django_session] ([session_key], [session_data], [expire_date]) VALUES (N'ia45aa69fdyam87mt07iw67dnxjl4qrm', N'e30:1uCMBZ:EgoebTXUcYu0XuGVCCN9a5uRmfHj7Qb1xrbja0p1kZw', CAST(N'2025-05-20T17:34:29.9465910+00:00' AS DateTimeOffset))
INSERT [dbo].[django_session] ([session_key], [session_data], [expire_date]) VALUES (N'idhm15mub0amp5r7clwzhj9bqco27i7p', N'e30:1uA9o0:3WkBEoEw3OA7uibFVUFXKHvBLmPigUUMitJprtzz85k', CAST(N'2025-05-14T15:57:04.5471320+00:00' AS DateTimeOffset))
INSERT [dbo].[django_session] ([session_key], [session_data], [expire_date]) VALUES (N'k653a5q81kln9hmqrm1v94t5ns4hvreb', N'.eJxVjDsOwjAQBe_iGln-iXgp6TmDtetd4wBypDipIu4OkVJA-2bmbSrhutS0dpnTyOqivDr9boT5KW0H_MB2n3Se2jKPpHdFH7Tr28Tyuh7u30HFXr81wmBKKNaSeCMGnYciIANH78hbCpw9R85iLLsACOcISGILSDYuOPX-APXiOFw:1u7zcM:qqzqLxzr43HSLA-IOZsAOhAT1EOxzC_G6llqdeCoQ3Q', CAST(N'2025-05-08T16:40:06.6093740+00:00' AS DateTimeOffset))
INSERT [dbo].[django_session] ([session_key], [session_data], [expire_date]) VALUES (N'm0333f9e41s1gjidf7xd2zo4rncjaooy', N'eyJtb2RvX2xpYnJlX2lkIjoiNTE3MDQ3OTIifQ:1uFhVK:0EMM7Gwj_MkYm6E4UYXw_eQFn7qYsALE7zOxgdeFnvo', CAST(N'2025-05-29T22:56:42.4010030+00:00' AS DateTimeOffset))
INSERT [dbo].[django_session] ([session_key], [session_data], [expire_date]) VALUES (N'ok44cfcs6cgd7plr6qrjp7rbjaz0ahou', N'.eJxVjMsOwiAUBf-FtSFAKQ-X7v0Gch9UqgaS0q6M_65NutDtmZnzEgm2taSt5yXNLM5CayVOvysCPXLdEd-h3pqkVtdlRrkr8qBdXhvn5-Vw_w4K9PKt1ahidmSRfJgmp00mMsZ5j-w5EDAY8H5ApfRIwZrBYIyDc4EjWopWvD8vbTgM:1uHCxX:pLfoh8T2_j_KdIDoLxqDBqfG2CAVDvyM7EqoUH061xQ', CAST(N'2025-06-03T02:44:03.7046680+00:00' AS DateTimeOffset))
INSERT [dbo].[django_session] ([session_key], [session_data], [expire_date]) VALUES (N'tov5i4dudgz3agd4dir3a0kshsw5ejrz', N'.eJxVjEEOwiAQRe_C2hCgQMCle89AZphBqoYmpV013t026UK3773_N5FgXWpaO89pJHEVWlx-GUJ-cTsEPaE9JpmntswjyiORp-3yPhG_b2f7d1Ch132NPrADZ0lxBDcU8tESIkBRg8WdodPaRU-oVChoMgZjiRlBG4dcxOcLCqI5Pw:1u60d0:IWGqCV7xpZZFzbu8UtsDoU1Ygr_nZMQ4AGLsmjiyag0', CAST(N'2025-05-03T05:20:34.6013260+00:00' AS DateTimeOffset))
INSERT [dbo].[django_session] ([session_key], [session_data], [expire_date]) VALUES (N'w8n42sznjnyecqd1okl9cb8npf2cdwof', N'.eJxVjEEOwiAQAP_C2RB3C2Tx6N03kAUWqRqalPZk_Lsh6UGvM5N5q8D7VsPeZQ1zVhc1gVGnXxo5PaUNlR_c7otOS9vWOeqR6MN2fVuyvK5H-zeo3OsYW3A2QSZKpZwhMTokQURiYco5mSLGghHwnnGK7Ip1HIsBJiTw6vMFMVw4Yw:1uI8iO:8uJi3TSl44zTgvWi8g54xGvgnGuZCEyLyaK0B86aEh8', CAST(N'2025-06-05T16:24:16.0385240+00:00' AS DateTimeOffset))
INSERT [dbo].[django_session] ([session_key], [session_data], [expire_date]) VALUES (N'wwgfg406wptrj1d6fm31ji1zwa1bo0z9', N'e30:1uCM8m:kX7daKugEH9ZarN1T7o7cJDsT3RmJ1o6Ec_3ik2V3RY', CAST(N'2025-05-20T17:31:36.5116480+00:00' AS DateTimeOffset))
GO
SET IDENTITY_INSERT [dbo].[evaluaciones_especialista] ON 

INSERT [dbo].[evaluaciones_especialista] ([id], [dni], [rne], [telefono], [institucion], [perfil_id]) VALUES (1, N'71438344', N'20250614-ESN-3891', N'987654321', N'Medica Superior', 10)
INSERT [dbo].[evaluaciones_especialista] ([id], [dni], [rne], [telefono], [institucion], [perfil_id]) VALUES (2, N'71438344', N'20250614-ESN-3891', N'987654321', N'Medica Superior', 11)
INSERT [dbo].[evaluaciones_especialista] ([id], [dni], [rne], [telefono], [institucion], [perfil_id]) VALUES (3, N'71438344', N'20250614-ESN-3891', N'987654321', N'Medica Superior', 13)
INSERT [dbo].[evaluaciones_especialista] ([id], [dni], [rne], [telefono], [institucion], [perfil_id]) VALUES (4, N'71438344', N'20250614-ESN-3891', N'987654321', N'Medica Superior', 14)
INSERT [dbo].[evaluaciones_especialista] ([id], [dni], [rne], [telefono], [institucion], [perfil_id]) VALUES (5, N'71438344', N'20250614-ESN-3891', N'987654321', N'Medica Superior', 17)
SET IDENTITY_INSERT [dbo].[evaluaciones_especialista] OFF
GO
SET IDENTITY_INSERT [dbo].[evaluaciones_intentojuego] ON 

INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (1, 7, CAST(N'2025-04-30T17:55:28.0386950+00:00' AS DateTimeOffset), 106, 1)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (2, 8, CAST(N'2025-04-30T18:03:50.4793300+00:00' AS DateTimeOffset), 106, 1)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (3, 10, CAST(N'2025-04-30T18:26:43.5502880+00:00' AS DateTimeOffset), 106, 3)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (4, 2, CAST(N'2025-04-30T19:36:40.1348250+00:00' AS DateTimeOffset), 106, 4)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (5, 8, CAST(N'2025-04-30T19:37:05.7733580+00:00' AS DateTimeOffset), 106, 2)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (6, 10, CAST(N'2025-05-01T00:15:26.3366240+00:00' AS DateTimeOffset), 106, 1)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (7, 4, CAST(N'2025-05-01T03:13:36.5352920+00:00' AS DateTimeOffset), 106, 2)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (8, 6, CAST(N'2025-05-01T03:15:39.9609200+00:00' AS DateTimeOffset), 106, 3)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (9, 11, CAST(N'2025-05-06T18:22:51.2454990+00:00' AS DateTimeOffset), 308, 1)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (10, 9, CAST(N'2025-05-06T18:23:08.3271820+00:00' AS DateTimeOffset), 308, 2)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (11, 9, CAST(N'2025-05-06T18:23:23.7769340+00:00' AS DateTimeOffset), 308, 3)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (12, 10, CAST(N'2025-05-06T18:24:05.8648670+00:00' AS DateTimeOffset), 308, 3)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (13, 10, CAST(N'2025-05-06T18:24:34.2626570+00:00' AS DateTimeOffset), 308, 3)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (14, 2, CAST(N'2025-05-06T18:24:53.3110540+00:00' AS DateTimeOffset), 308, 4)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (15, 7, CAST(N'2025-05-06T19:00:31.8442290+00:00' AS DateTimeOffset), 309, 1)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (16, 10, CAST(N'2025-05-06T19:01:06.6790990+00:00' AS DateTimeOffset), 309, 2)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (17, 9, CAST(N'2025-05-06T19:01:20.7005780+00:00' AS DateTimeOffset), 309, 3)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (18, 1, CAST(N'2025-05-06T19:01:33.7291400+00:00' AS DateTimeOffset), 309, 4)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (19, 8, CAST(N'2025-05-15T22:32:57.8352230+00:00' AS DateTimeOffset), 307, 1)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (20, 10, CAST(N'2025-05-15T22:33:12.9561050+00:00' AS DateTimeOffset), 307, 2)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (21, 10, CAST(N'2025-05-15T22:33:29.1395720+00:00' AS DateTimeOffset), 307, 3)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (22, 4, CAST(N'2025-05-15T22:33:50.6529970+00:00' AS DateTimeOffset), 307, 4)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (23, 10, CAST(N'2025-05-15T22:41:22.8306170+00:00' AS DateTimeOffset), 307, 2)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (24, 8, CAST(N'2025-05-15T22:47:45.8294000+00:00' AS DateTimeOffset), 307, 2)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (25, 7, CAST(N'2025-05-15T22:50:15.4712260+00:00' AS DateTimeOffset), 307, 1)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (26, 10, CAST(N'2025-05-15T22:51:35.6802920+00:00' AS DateTimeOffset), 307, 3)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (27, 1, CAST(N'2025-05-15T22:51:44.1411160+00:00' AS DateTimeOffset), 307, 4)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (28, 8, CAST(N'2025-05-22T15:14:23.1067820+00:00' AS DateTimeOffset), 310, 1)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (29, 10, CAST(N'2025-05-22T15:14:37.7610780+00:00' AS DateTimeOffset), 310, 2)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (30, 10, CAST(N'2025-05-22T15:14:49.1917970+00:00' AS DateTimeOffset), 310, 3)
INSERT [dbo].[evaluaciones_intentojuego] ([id], [resultado], [fecha], [nino_id], [juego_id]) VALUES (31, 3, CAST(N'2025-05-22T15:15:06.4738260+00:00' AS DateTimeOffset), 310, 4)
SET IDENTITY_INSERT [dbo].[evaluaciones_intentojuego] OFF
GO
SET IDENTITY_INSERT [dbo].[evaluaciones_intentojuegoinvitado] ON 

INSERT [dbo].[evaluaciones_intentojuegoinvitado] ([id], [invitado_id], [resultado], [fecha], [juego_id]) VALUES (1, N'6ad8bb92', 8, CAST(N'2025-05-15T16:28:27.1518610+00:00' AS DateTimeOffset), 1)
INSERT [dbo].[evaluaciones_intentojuegoinvitado] ([id], [invitado_id], [resultado], [fecha], [juego_id]) VALUES (2, N'6ad8bb92', 10, CAST(N'2025-05-15T16:32:10.8745400+00:00' AS DateTimeOffset), 2)
INSERT [dbo].[evaluaciones_intentojuegoinvitado] ([id], [invitado_id], [resultado], [fecha], [juego_id]) VALUES (3, N'6ad8bb92', 10, CAST(N'2025-05-15T16:32:23.7017330+00:00' AS DateTimeOffset), 3)
INSERT [dbo].[evaluaciones_intentojuegoinvitado] ([id], [invitado_id], [resultado], [fecha], [juego_id]) VALUES (4, N'6ad8bb92', 3, CAST(N'2025-05-15T16:32:46.1666390+00:00' AS DateTimeOffset), 4)
INSERT [dbo].[evaluaciones_intentojuegoinvitado] ([id], [invitado_id], [resultado], [fecha], [juego_id]) VALUES (5, N'51704792', 8, CAST(N'2025-05-15T22:57:01.6185380+00:00' AS DateTimeOffset), 1)
INSERT [dbo].[evaluaciones_intentojuegoinvitado] ([id], [invitado_id], [resultado], [fecha], [juego_id]) VALUES (6, N'51704792', 10, CAST(N'2025-05-15T22:57:34.7129410+00:00' AS DateTimeOffset), 2)
INSERT [dbo].[evaluaciones_intentojuegoinvitado] ([id], [invitado_id], [resultado], [fecha], [juego_id]) VALUES (7, N'19a7bfa5', 9, CAST(N'2025-05-22T16:17:27.2272120+00:00' AS DateTimeOffset), 1)
INSERT [dbo].[evaluaciones_intentojuegoinvitado] ([id], [invitado_id], [resultado], [fecha], [juego_id]) VALUES (8, N'19a7bfa5', 10, CAST(N'2025-05-22T16:17:46.9377960+00:00' AS DateTimeOffset), 2)
INSERT [dbo].[evaluaciones_intentojuegoinvitado] ([id], [invitado_id], [resultado], [fecha], [juego_id]) VALUES (9, N'19a7bfa5', 10, CAST(N'2025-05-22T16:17:57.6579800+00:00' AS DateTimeOffset), 3)
INSERT [dbo].[evaluaciones_intentojuegoinvitado] ([id], [invitado_id], [resultado], [fecha], [juego_id]) VALUES (10, N'19a7bfa5', 3, CAST(N'2025-05-22T16:18:17.8446080+00:00' AS DateTimeOffset), 4)
SET IDENTITY_INSERT [dbo].[evaluaciones_intentojuegoinvitado] OFF
GO
SET IDENTITY_INSERT [dbo].[evaluaciones_juego] ON 

INSERT [dbo].[evaluaciones_juego] ([id], [nombre], [descripcion], [tipo], [activo]) VALUES (1, N'EmoMatch', N'Juego de reconocimiento emocional', N'tea', 1)
INSERT [dbo].[evaluaciones_juego] ([id], [nombre], [descripcion], [tipo], [activo]) VALUES (2, N'Atención Turbo', N'Juego de reacción y atención', N'tdha', 1)
INSERT [dbo].[evaluaciones_juego] ([id], [nombre], [descripcion], [tipo], [activo]) VALUES (3, N'Mano Firme', N'Juego de precisión motora', N'discapacidad', 1)
INSERT [dbo].[evaluaciones_juego] ([id], [nombre], [descripcion], [tipo], [activo]) VALUES (4, N'Respira y Flota', N'Juego de relajación y control', N'estres', 1)
SET IDENTITY_INSERT [dbo].[evaluaciones_juego] OFF
GO
SET IDENTITY_INSERT [dbo].[evaluaciones_logenvioreporte] ON 

INSERT [dbo].[evaluaciones_logenvioreporte] ([id], [fecha_envio], [metodo], [exito], [mensaje], [especialista_id], [nino_id]) VALUES (1, CAST(N'2025-05-22T15:17:22.6814320+00:00' AS DateTimeOffset), N'email', 1, N'Enviado correctamente.', 3, 310)
INSERT [dbo].[evaluaciones_logenvioreporte] ([id], [fecha_envio], [metodo], [exito], [mensaje], [especialista_id], [nino_id]) VALUES (2, CAST(N'2025-05-22T16:25:02.1618500+00:00' AS DateTimeOffset), N'email', 1, N'Enviado correctamente.', 3, 310)
SET IDENTITY_INSERT [dbo].[evaluaciones_logenvioreporte] OFF
GO
SET IDENTITY_INSERT [dbo].[evaluaciones_nino] ON 

INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (106, CAST(N'2020-02-06' AS Date), N'M', N'Prueba6@prueba6.com', 110)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (207, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_1@neurokid.pe', 212)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (208, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_2@neurokid.pe', 213)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (209, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_3@neurokid.pe', 214)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (210, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_4@neurokid.pe', 215)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (211, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_5@neurokid.pe', 216)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (212, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_6@neurokid.pe', 217)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (213, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_7@neurokid.pe', 218)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (214, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_8@neurokid.pe', 219)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (215, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_9@neurokid.pe', 220)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (216, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_10@neurokid.pe', 221)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (217, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_11@neurokid.pe', 222)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (218, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_12@neurokid.pe', 223)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (219, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_13@neurokid.pe', 224)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (220, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_14@neurokid.pe', 225)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (221, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_15@neurokid.pe', 226)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (222, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_16@neurokid.pe', 227)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (223, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_17@neurokid.pe', 228)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (224, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_18@neurokid.pe', 229)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (225, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_19@neurokid.pe', 230)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (226, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_20@neurokid.pe', 231)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (227, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_21@neurokid.pe', 232)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (228, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_22@neurokid.pe', 233)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (229, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_23@neurokid.pe', 234)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (230, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_24@neurokid.pe', 235)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (231, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_25@neurokid.pe', 236)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (232, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_26@neurokid.pe', 237)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (233, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_27@neurokid.pe', 238)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (234, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_28@neurokid.pe', 239)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (235, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_29@neurokid.pe', 240)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (236, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_30@neurokid.pe', 241)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (237, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_31@neurokid.pe', 242)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (238, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_32@neurokid.pe', 243)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (239, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_33@neurokid.pe', 244)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (240, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_34@neurokid.pe', 245)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (241, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_35@neurokid.pe', 246)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (242, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_36@neurokid.pe', 247)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (243, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_37@neurokid.pe', 248)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (244, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_38@neurokid.pe', 249)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (245, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_39@neurokid.pe', 250)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (246, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_40@neurokid.pe', 251)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (247, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_41@neurokid.pe', 252)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (248, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_42@neurokid.pe', 253)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (249, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_43@neurokid.pe', 254)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (250, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_44@neurokid.pe', 255)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (251, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_45@neurokid.pe', 256)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (252, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_46@neurokid.pe', 257)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (253, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_47@neurokid.pe', 258)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (254, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_48@neurokid.pe', 259)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (255, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_49@neurokid.pe', 260)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (256, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_50@neurokid.pe', 261)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (257, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_51@neurokid.pe', 262)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (258, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_52@neurokid.pe', 263)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (259, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_53@neurokid.pe', 264)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (260, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_54@neurokid.pe', 265)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (261, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_55@neurokid.pe', 266)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (262, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_56@neurokid.pe', 267)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (263, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_57@neurokid.pe', 268)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (264, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_58@neurokid.pe', 269)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (265, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_59@neurokid.pe', 270)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (266, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_60@neurokid.pe', 271)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (267, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_61@neurokid.pe', 272)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (268, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_62@neurokid.pe', 273)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (269, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_63@neurokid.pe', 274)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (270, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_64@neurokid.pe', 275)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (271, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_65@neurokid.pe', 276)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (272, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_66@neurokid.pe', 277)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (273, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_67@neurokid.pe', 278)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (274, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_68@neurokid.pe', 279)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (275, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_69@neurokid.pe', 280)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (276, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_70@neurokid.pe', 281)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (277, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_71@neurokid.pe', 282)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (278, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_72@neurokid.pe', 283)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (279, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_73@neurokid.pe', 284)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (280, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_74@neurokid.pe', 285)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (281, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_75@neurokid.pe', 286)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (282, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_76@neurokid.pe', 287)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (283, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_77@neurokid.pe', 288)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (284, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_78@neurokid.pe', 289)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (285, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_79@neurokid.pe', 290)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (286, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_80@neurokid.pe', 291)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (287, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_81@neurokid.pe', 292)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (288, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_82@neurokid.pe', 293)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (289, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_83@neurokid.pe', 294)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (290, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_84@neurokid.pe', 295)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (291, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_85@neurokid.pe', 296)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (292, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_86@neurokid.pe', 297)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (293, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_87@neurokid.pe', 298)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (294, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_88@neurokid.pe', 299)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (295, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_89@neurokid.pe', 300)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (296, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_90@neurokid.pe', 301)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (297, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_91@neurokid.pe', 302)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (298, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_92@neurokid.pe', 303)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (299, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_93@neurokid.pe', 304)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (300, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_94@neurokid.pe', 305)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (301, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_95@neurokid.pe', 306)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (302, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_96@neurokid.pe', 307)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (303, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_97@neurokid.pe', 308)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (304, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_98@neurokid.pe', 309)
GO
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (305, CAST(N'2016-01-01' AS Date), N'F', N'nino_simulado_99@neurokid.pe', 310)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (306, CAST(N'2016-01-01' AS Date), N'M', N'nino_simulado_100@neurokid.pe', 311)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (307, CAST(N'2015-03-17' AS Date), N'M', N'nino7@prueba7.com', 313)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (308, CAST(N'2015-03-19' AS Date), N'F', N'P9@Prueba9.com', 316)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (309, CAST(N'2015-03-10' AS Date), N'M', N'P10@Prueba10.com', 317)
INSERT [dbo].[evaluaciones_nino] ([id], [fecha_nacimiento], [genero], [email], [user_id]) VALUES (310, CAST(N'2015-03-12' AS Date), N'M', N'alfredopicizqu1990@gmail.com', 319)
SET IDENTITY_INSERT [dbo].[evaluaciones_nino] OFF
GO
SET IDENTITY_INSERT [dbo].[evaluaciones_perfil] ON 

INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (1, N'invitado', NULL, NULL, 1)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (2, N'especialista', NULL, NULL, 2)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (3, N'nino', NULL, NULL, 3)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (4, N'nino', NULL, NULL, 105)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (5, N'nino', NULL, NULL, 106)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (6, N'nino', NULL, NULL, 107)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (7, N'nino', NULL, NULL, 108)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (8, N'nino', NULL, NULL, 109)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (9, N'nino', NULL, NULL, 110)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (10, N'especialista', NULL, NULL, 111)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (11, N'especialista', NULL, NULL, 312)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (12, N'nino', NULL, NULL, 313)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (13, N'especialista', NULL, NULL, 314)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (14, N'especialista', NULL, NULL, 315)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (15, N'nino', NULL, NULL, 316)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (16, N'nino', NULL, NULL, 317)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (17, N'especialista', NULL, NULL, 318)
INSERT [dbo].[evaluaciones_perfil] ([id], [rol], [fecha_nacimiento], [especialidad], [user_id]) VALUES (18, N'nino', NULL, NULL, 319)
SET IDENTITY_INSERT [dbo].[evaluaciones_perfil] OFF
GO
SET IDENTITY_INSERT [dbo].[evaluaciones_resultadoia] ON 

INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (401, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T17:55:28.0580760+00:00' AS DateTimeOffset), 1, 106)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (402, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T18:26:43.5701630+00:00' AS DateTimeOffset), 3, 106)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (403, N'TEA', 1, CAST(N'2025-04-30T19:36:40.1538160+00:00' AS DateTimeOffset), 4, 106)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (404, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T19:37:05.7796170+00:00' AS DateTimeOffset), 2, 106)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (805, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.1925010+00:00' AS DateTimeOffset), 1, 207)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (806, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.1972850+00:00' AS DateTimeOffset), 2, 207)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (807, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.2011630+00:00' AS DateTimeOffset), 3, 207)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (808, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.2051080+00:00' AS DateTimeOffset), 4, 207)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (809, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.2122210+00:00' AS DateTimeOffset), 1, 208)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (810, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.2146090+00:00' AS DateTimeOffset), 2, 208)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (811, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.2169740+00:00' AS DateTimeOffset), 3, 208)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (812, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.2192430+00:00' AS DateTimeOffset), 4, 208)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (813, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.2253270+00:00' AS DateTimeOffset), 1, 209)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (814, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.2276950+00:00' AS DateTimeOffset), 2, 209)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (815, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.2299340+00:00' AS DateTimeOffset), 3, 209)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (816, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.2328730+00:00' AS DateTimeOffset), 4, 209)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (817, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.2390690+00:00' AS DateTimeOffset), 1, 210)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (818, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.2416460+00:00' AS DateTimeOffset), 2, 210)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (819, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.2441340+00:00' AS DateTimeOffset), 3, 210)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (820, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.2466200+00:00' AS DateTimeOffset), 4, 210)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (821, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.2515000+00:00' AS DateTimeOffset), 1, 211)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (822, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.2538240+00:00' AS DateTimeOffset), 2, 211)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (823, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.2562460+00:00' AS DateTimeOffset), 3, 211)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (824, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.2585810+00:00' AS DateTimeOffset), 4, 211)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (825, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.2635010+00:00' AS DateTimeOffset), 1, 212)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (826, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.2659700+00:00' AS DateTimeOffset), 2, 212)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (827, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.2682940+00:00' AS DateTimeOffset), 3, 212)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (828, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.2710370+00:00' AS DateTimeOffset), 4, 212)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (829, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.2761400+00:00' AS DateTimeOffset), 1, 213)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (830, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.2784870+00:00' AS DateTimeOffset), 2, 213)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (831, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.2811070+00:00' AS DateTimeOffset), 3, 213)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (832, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.2834330+00:00' AS DateTimeOffset), 4, 213)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (833, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.2885100+00:00' AS DateTimeOffset), 1, 214)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (834, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.2907530+00:00' AS DateTimeOffset), 2, 214)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (835, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.2929490+00:00' AS DateTimeOffset), 3, 214)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (836, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.2952800+00:00' AS DateTimeOffset), 4, 214)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (837, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.3007290+00:00' AS DateTimeOffset), 1, 215)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (838, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.3035850+00:00' AS DateTimeOffset), 2, 215)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (839, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.3059550+00:00' AS DateTimeOffset), 3, 215)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (840, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.3087660+00:00' AS DateTimeOffset), 4, 215)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (841, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.3171310+00:00' AS DateTimeOffset), 1, 216)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (842, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:19.3192680+00:00' AS DateTimeOffset), 2, 216)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (843, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.3218140+00:00' AS DateTimeOffset), 3, 216)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (844, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.3240800+00:00' AS DateTimeOffset), 4, 216)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (845, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.3296410+00:00' AS DateTimeOffset), 1, 217)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (846, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.3318140+00:00' AS DateTimeOffset), 2, 217)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (847, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.3340530+00:00' AS DateTimeOffset), 3, 217)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (848, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.3365050+00:00' AS DateTimeOffset), 4, 217)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (849, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.3411240+00:00' AS DateTimeOffset), 1, 218)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (850, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.3435410+00:00' AS DateTimeOffset), 2, 218)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (851, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.3460310+00:00' AS DateTimeOffset), 3, 218)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (852, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.3484560+00:00' AS DateTimeOffset), 4, 218)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (853, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.3532250+00:00' AS DateTimeOffset), 1, 219)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (854, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.3554520+00:00' AS DateTimeOffset), 2, 219)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (855, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.3580610+00:00' AS DateTimeOffset), 3, 219)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (856, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.3601350+00:00' AS DateTimeOffset), 4, 219)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (857, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.3650870+00:00' AS DateTimeOffset), 1, 220)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (858, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.3675790+00:00' AS DateTimeOffset), 2, 220)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (859, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.3700440+00:00' AS DateTimeOffset), 3, 220)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (860, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.3722890+00:00' AS DateTimeOffset), 4, 220)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (861, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.3784170+00:00' AS DateTimeOffset), 1, 221)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (862, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.3812680+00:00' AS DateTimeOffset), 2, 221)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (863, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.3836910+00:00' AS DateTimeOffset), 3, 221)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (864, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.3859690+00:00' AS DateTimeOffset), 4, 221)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (865, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.3917040+00:00' AS DateTimeOffset), 1, 222)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (866, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.3941720+00:00' AS DateTimeOffset), 2, 222)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (867, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.3964400+00:00' AS DateTimeOffset), 3, 222)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (868, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.3989410+00:00' AS DateTimeOffset), 4, 222)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (869, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.4042920+00:00' AS DateTimeOffset), 1, 223)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (870, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.4069120+00:00' AS DateTimeOffset), 2, 223)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (871, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.4090940+00:00' AS DateTimeOffset), 3, 223)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (872, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.4115960+00:00' AS DateTimeOffset), 4, 223)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (873, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.4169700+00:00' AS DateTimeOffset), 1, 224)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (874, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.4198770+00:00' AS DateTimeOffset), 2, 224)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (875, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.4227820+00:00' AS DateTimeOffset), 3, 224)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (876, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.4254180+00:00' AS DateTimeOffset), 4, 224)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (877, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.4305100+00:00' AS DateTimeOffset), 1, 225)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (878, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.4329480+00:00' AS DateTimeOffset), 2, 225)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (879, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.4354010+00:00' AS DateTimeOffset), 3, 225)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (880, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.4376320+00:00' AS DateTimeOffset), 4, 225)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (881, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.4426720+00:00' AS DateTimeOffset), 1, 226)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (882, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.4449340+00:00' AS DateTimeOffset), 2, 226)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (883, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.4477950+00:00' AS DateTimeOffset), 3, 226)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (884, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.4503760+00:00' AS DateTimeOffset), 4, 226)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (885, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.4559150+00:00' AS DateTimeOffset), 1, 227)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (886, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.4584220+00:00' AS DateTimeOffset), 2, 227)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (887, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.4610770+00:00' AS DateTimeOffset), 3, 227)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (888, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.4635630+00:00' AS DateTimeOffset), 4, 227)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (889, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.4692260+00:00' AS DateTimeOffset), 1, 228)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (890, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.4716880+00:00' AS DateTimeOffset), 2, 228)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (891, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.4743910+00:00' AS DateTimeOffset), 3, 228)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (892, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.4793460+00:00' AS DateTimeOffset), 4, 228)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (893, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.4897880+00:00' AS DateTimeOffset), 1, 229)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (894, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.4949690+00:00' AS DateTimeOffset), 2, 229)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (895, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.4989220+00:00' AS DateTimeOffset), 3, 229)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (896, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.5026250+00:00' AS DateTimeOffset), 4, 229)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (897, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.5109790+00:00' AS DateTimeOffset), 1, 230)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (898, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.5145750+00:00' AS DateTimeOffset), 2, 230)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (899, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.5178720+00:00' AS DateTimeOffset), 3, 230)
GO
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (900, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.5209630+00:00' AS DateTimeOffset), 4, 230)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (901, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.5287400+00:00' AS DateTimeOffset), 1, 231)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (902, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.5318460+00:00' AS DateTimeOffset), 2, 231)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (903, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.5345350+00:00' AS DateTimeOffset), 3, 231)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (904, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.5369970+00:00' AS DateTimeOffset), 4, 231)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (905, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.5432050+00:00' AS DateTimeOffset), 1, 232)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (906, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.5458960+00:00' AS DateTimeOffset), 2, 232)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (907, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.5484860+00:00' AS DateTimeOffset), 3, 232)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (908, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.5513370+00:00' AS DateTimeOffset), 4, 232)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (909, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.5570480+00:00' AS DateTimeOffset), 1, 233)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (910, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.5593130+00:00' AS DateTimeOffset), 2, 233)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (911, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.5616580+00:00' AS DateTimeOffset), 3, 233)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (912, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.5640540+00:00' AS DateTimeOffset), 4, 233)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (913, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.5696490+00:00' AS DateTimeOffset), 1, 234)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (914, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.5723030+00:00' AS DateTimeOffset), 2, 234)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (915, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.5746780+00:00' AS DateTimeOffset), 3, 234)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (916, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.5768850+00:00' AS DateTimeOffset), 4, 234)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (917, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.5816050+00:00' AS DateTimeOffset), 1, 235)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (918, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.5840100+00:00' AS DateTimeOffset), 2, 235)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (919, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.5862290+00:00' AS DateTimeOffset), 3, 235)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (920, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.5887120+00:00' AS DateTimeOffset), 4, 235)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (921, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.5939530+00:00' AS DateTimeOffset), 1, 236)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (922, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.5966350+00:00' AS DateTimeOffset), 2, 236)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (923, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.6001680+00:00' AS DateTimeOffset), 3, 236)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (924, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.6024890+00:00' AS DateTimeOffset), 4, 236)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (925, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.6070720+00:00' AS DateTimeOffset), 1, 237)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (926, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.6092020+00:00' AS DateTimeOffset), 2, 237)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (927, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.6113020+00:00' AS DateTimeOffset), 3, 237)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (928, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.6139230+00:00' AS DateTimeOffset), 4, 237)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (929, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.6192780+00:00' AS DateTimeOffset), 1, 238)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (930, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:19.6215510+00:00' AS DateTimeOffset), 2, 238)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (931, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.6237210+00:00' AS DateTimeOffset), 3, 238)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (932, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.6257750+00:00' AS DateTimeOffset), 4, 238)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (933, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.6310450+00:00' AS DateTimeOffset), 1, 239)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (934, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:19.6335150+00:00' AS DateTimeOffset), 2, 239)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (935, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.6357970+00:00' AS DateTimeOffset), 3, 239)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (936, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.6379520+00:00' AS DateTimeOffset), 4, 239)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (937, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.6431080+00:00' AS DateTimeOffset), 1, 240)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (938, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.6456550+00:00' AS DateTimeOffset), 2, 240)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (939, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.6484460+00:00' AS DateTimeOffset), 3, 240)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (940, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.6503770+00:00' AS DateTimeOffset), 4, 240)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (941, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.6551110+00:00' AS DateTimeOffset), 1, 241)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (942, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.6578040+00:00' AS DateTimeOffset), 2, 241)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (943, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.6598640+00:00' AS DateTimeOffset), 3, 241)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (944, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.6621010+00:00' AS DateTimeOffset), 4, 241)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (945, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.6664740+00:00' AS DateTimeOffset), 1, 242)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (946, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.6689840+00:00' AS DateTimeOffset), 2, 242)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (947, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.6709420+00:00' AS DateTimeOffset), 3, 242)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (948, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.6732450+00:00' AS DateTimeOffset), 4, 242)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (949, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.6775270+00:00' AS DateTimeOffset), 1, 243)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (950, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.6798940+00:00' AS DateTimeOffset), 2, 243)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (951, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.6819140+00:00' AS DateTimeOffset), 3, 243)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (952, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.6840110+00:00' AS DateTimeOffset), 4, 243)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (953, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.6883140+00:00' AS DateTimeOffset), 1, 244)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (954, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.6906740+00:00' AS DateTimeOffset), 2, 244)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (955, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.6928830+00:00' AS DateTimeOffset), 3, 244)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (956, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.6951200+00:00' AS DateTimeOffset), 4, 244)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (957, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.6996560+00:00' AS DateTimeOffset), 1, 245)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (958, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.7018710+00:00' AS DateTimeOffset), 2, 245)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (959, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.7040920+00:00' AS DateTimeOffset), 3, 245)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (960, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.7062200+00:00' AS DateTimeOffset), 4, 245)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (961, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.7111450+00:00' AS DateTimeOffset), 1, 246)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (962, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.7133140+00:00' AS DateTimeOffset), 2, 246)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (963, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.7154540+00:00' AS DateTimeOffset), 3, 246)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (964, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.7174860+00:00' AS DateTimeOffset), 4, 246)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (965, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.7228220+00:00' AS DateTimeOffset), 1, 247)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (966, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.7256350+00:00' AS DateTimeOffset), 2, 247)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (967, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.7280270+00:00' AS DateTimeOffset), 3, 247)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (968, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.7301700+00:00' AS DateTimeOffset), 4, 247)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (969, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.7353540+00:00' AS DateTimeOffset), 1, 248)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (970, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.7378400+00:00' AS DateTimeOffset), 2, 248)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (971, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.7399920+00:00' AS DateTimeOffset), 3, 248)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (972, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.7423190+00:00' AS DateTimeOffset), 4, 248)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (973, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.7475980+00:00' AS DateTimeOffset), 1, 249)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (974, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.7498710+00:00' AS DateTimeOffset), 2, 249)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (975, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.7524250+00:00' AS DateTimeOffset), 3, 249)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (976, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.7548890+00:00' AS DateTimeOffset), 4, 249)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (977, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.7596950+00:00' AS DateTimeOffset), 1, 250)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (978, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.7619480+00:00' AS DateTimeOffset), 2, 250)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (979, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.7641090+00:00' AS DateTimeOffset), 3, 250)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (980, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.7665790+00:00' AS DateTimeOffset), 4, 250)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (981, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.7711000+00:00' AS DateTimeOffset), 1, 251)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (982, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.7735750+00:00' AS DateTimeOffset), 2, 251)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (983, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.7758560+00:00' AS DateTimeOffset), 3, 251)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (984, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.7779870+00:00' AS DateTimeOffset), 4, 251)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (985, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.7826930+00:00' AS DateTimeOffset), 1, 252)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (986, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.7849550+00:00' AS DateTimeOffset), 2, 252)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (987, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.7877720+00:00' AS DateTimeOffset), 3, 252)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (988, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.7901590+00:00' AS DateTimeOffset), 4, 252)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (989, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.7955830+00:00' AS DateTimeOffset), 1, 253)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (990, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:19.7977310+00:00' AS DateTimeOffset), 2, 253)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (991, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.7999710+00:00' AS DateTimeOffset), 3, 253)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (992, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.8020730+00:00' AS DateTimeOffset), 4, 253)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (993, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.8074370+00:00' AS DateTimeOffset), 1, 254)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (994, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.8095280+00:00' AS DateTimeOffset), 2, 254)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (995, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.8118020+00:00' AS DateTimeOffset), 3, 254)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (996, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.8141360+00:00' AS DateTimeOffset), 4, 254)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (997, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.8192310+00:00' AS DateTimeOffset), 1, 255)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (998, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.8219170+00:00' AS DateTimeOffset), 2, 255)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (999, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.8241320+00:00' AS DateTimeOffset), 3, 255)
GO
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1000, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.8262300+00:00' AS DateTimeOffset), 4, 255)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1001, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.8310270+00:00' AS DateTimeOffset), 1, 256)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1002, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:19.8333360+00:00' AS DateTimeOffset), 2, 256)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1003, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.8356490+00:00' AS DateTimeOffset), 3, 256)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1004, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.8377670+00:00' AS DateTimeOffset), 4, 256)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1005, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.8428340+00:00' AS DateTimeOffset), 1, 257)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1006, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:19.8449610+00:00' AS DateTimeOffset), 2, 257)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1007, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.8471280+00:00' AS DateTimeOffset), 3, 257)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1008, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.8499510+00:00' AS DateTimeOffset), 4, 257)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1009, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.8544050+00:00' AS DateTimeOffset), 1, 258)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1010, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.8568380+00:00' AS DateTimeOffset), 2, 258)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1011, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.8590330+00:00' AS DateTimeOffset), 3, 258)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1012, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.8612780+00:00' AS DateTimeOffset), 4, 258)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1013, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.8662380+00:00' AS DateTimeOffset), 1, 259)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1014, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.8686450+00:00' AS DateTimeOffset), 2, 259)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1015, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.8714330+00:00' AS DateTimeOffset), 3, 259)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1016, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.8737370+00:00' AS DateTimeOffset), 4, 259)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1017, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.8791540+00:00' AS DateTimeOffset), 1, 260)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1018, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.8814190+00:00' AS DateTimeOffset), 2, 260)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1019, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.8836370+00:00' AS DateTimeOffset), 3, 260)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1020, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.8863290+00:00' AS DateTimeOffset), 4, 260)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1021, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.8913040+00:00' AS DateTimeOffset), 1, 261)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1022, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.8935570+00:00' AS DateTimeOffset), 2, 261)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1023, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.8959200+00:00' AS DateTimeOffset), 3, 261)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1024, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.8988240+00:00' AS DateTimeOffset), 4, 261)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1025, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.9036160+00:00' AS DateTimeOffset), 1, 262)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1026, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.9059740+00:00' AS DateTimeOffset), 2, 262)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1027, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.9082730+00:00' AS DateTimeOffset), 3, 262)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1028, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.9104200+00:00' AS DateTimeOffset), 4, 262)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1029, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.9157720+00:00' AS DateTimeOffset), 1, 263)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1030, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.9183990+00:00' AS DateTimeOffset), 2, 263)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1031, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.9205070+00:00' AS DateTimeOffset), 3, 263)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1032, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.9230160+00:00' AS DateTimeOffset), 4, 263)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1033, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.9278460+00:00' AS DateTimeOffset), 1, 264)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1034, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.9302680+00:00' AS DateTimeOffset), 2, 264)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1035, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.9328990+00:00' AS DateTimeOffset), 3, 264)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1036, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.9349610+00:00' AS DateTimeOffset), 4, 264)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1037, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.9398210+00:00' AS DateTimeOffset), 1, 265)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1038, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.9418600+00:00' AS DateTimeOffset), 2, 265)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1039, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.9439650+00:00' AS DateTimeOffset), 3, 265)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1040, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.9465710+00:00' AS DateTimeOffset), 4, 265)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1041, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.9512330+00:00' AS DateTimeOffset), 1, 266)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1042, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.9537680+00:00' AS DateTimeOffset), 2, 266)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1043, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.9557700+00:00' AS DateTimeOffset), 3, 266)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1044, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.9579360+00:00' AS DateTimeOffset), 4, 266)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1045, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.9627390+00:00' AS DateTimeOffset), 1, 267)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1046, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:19.9650220+00:00' AS DateTimeOffset), 2, 267)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1047, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:19.9672950+00:00' AS DateTimeOffset), 3, 267)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1048, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.9696610+00:00' AS DateTimeOffset), 4, 267)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1049, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.9748750+00:00' AS DateTimeOffset), 1, 268)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1050, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:19.9780020+00:00' AS DateTimeOffset), 2, 268)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1051, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.9806100+00:00' AS DateTimeOffset), 3, 268)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1052, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.9831160+00:00' AS DateTimeOffset), 4, 268)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1053, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:19.9879510+00:00' AS DateTimeOffset), 1, 269)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1054, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:19.9903640+00:00' AS DateTimeOffset), 2, 269)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1055, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:19.9927080+00:00' AS DateTimeOffset), 3, 269)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1056, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:19.9954250+00:00' AS DateTimeOffset), 4, 269)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1057, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.0005310+00:00' AS DateTimeOffset), 1, 270)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1058, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.0032660+00:00' AS DateTimeOffset), 2, 270)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1059, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.0055170+00:00' AS DateTimeOffset), 3, 270)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1060, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.0076520+00:00' AS DateTimeOffset), 4, 270)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1061, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.0129820+00:00' AS DateTimeOffset), 1, 271)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1062, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.0154100+00:00' AS DateTimeOffset), 2, 271)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1063, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.0177590+00:00' AS DateTimeOffset), 3, 271)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1064, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.0202240+00:00' AS DateTimeOffset), 4, 271)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1065, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.0256730+00:00' AS DateTimeOffset), 1, 272)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1066, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.0278510+00:00' AS DateTimeOffset), 2, 272)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1067, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:20.0303880+00:00' AS DateTimeOffset), 3, 272)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1068, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.0325500+00:00' AS DateTimeOffset), 4, 272)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1069, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.0377670+00:00' AS DateTimeOffset), 1, 273)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1070, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.0404070+00:00' AS DateTimeOffset), 2, 273)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1071, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.0427670+00:00' AS DateTimeOffset), 3, 273)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1072, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.0452960+00:00' AS DateTimeOffset), 4, 273)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1073, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.0499920+00:00' AS DateTimeOffset), 1, 274)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1074, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:20.0522420+00:00' AS DateTimeOffset), 2, 274)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1075, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:20.0543290+00:00' AS DateTimeOffset), 3, 274)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1076, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.0563590+00:00' AS DateTimeOffset), 4, 274)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1077, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.0610490+00:00' AS DateTimeOffset), 1, 275)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1078, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.0633580+00:00' AS DateTimeOffset), 2, 275)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1079, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.0661310+00:00' AS DateTimeOffset), 3, 275)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1080, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.0687350+00:00' AS DateTimeOffset), 4, 275)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1081, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.0737020+00:00' AS DateTimeOffset), 1, 276)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1082, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.0760850+00:00' AS DateTimeOffset), 2, 276)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1083, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.0785690+00:00' AS DateTimeOffset), 3, 276)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1084, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.0810140+00:00' AS DateTimeOffset), 4, 276)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1085, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.0883540+00:00' AS DateTimeOffset), 1, 277)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1086, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.0912080+00:00' AS DateTimeOffset), 2, 277)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1087, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:20.0940780+00:00' AS DateTimeOffset), 3, 277)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1088, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.0974300+00:00' AS DateTimeOffset), 4, 277)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1089, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.1039350+00:00' AS DateTimeOffset), 1, 278)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1090, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.1068080+00:00' AS DateTimeOffset), 2, 278)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1091, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.1096610+00:00' AS DateTimeOffset), 3, 278)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1092, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.1123570+00:00' AS DateTimeOffset), 4, 278)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1093, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.1192000+00:00' AS DateTimeOffset), 1, 279)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1094, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.1221520+00:00' AS DateTimeOffset), 2, 279)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1095, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.1248490+00:00' AS DateTimeOffset), 3, 279)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1096, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.1273380+00:00' AS DateTimeOffset), 4, 279)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1097, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.1323260+00:00' AS DateTimeOffset), 1, 280)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1098, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.1346980+00:00' AS DateTimeOffset), 2, 280)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1099, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.1369810+00:00' AS DateTimeOffset), 3, 280)
GO
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1100, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.1391440+00:00' AS DateTimeOffset), 4, 280)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1101, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.1436930+00:00' AS DateTimeOffset), 1, 281)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1102, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.1459210+00:00' AS DateTimeOffset), 2, 281)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1103, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.1485150+00:00' AS DateTimeOffset), 3, 281)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1104, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.1507170+00:00' AS DateTimeOffset), 4, 281)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1105, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.1560590+00:00' AS DateTimeOffset), 1, 282)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1106, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.1590450+00:00' AS DateTimeOffset), 2, 282)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1107, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:20.1618480+00:00' AS DateTimeOffset), 3, 282)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1108, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.1647110+00:00' AS DateTimeOffset), 4, 282)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1109, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.1700760+00:00' AS DateTimeOffset), 1, 283)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1110, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.1724840+00:00' AS DateTimeOffset), 2, 283)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1111, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.1749410+00:00' AS DateTimeOffset), 3, 283)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1112, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.1772950+00:00' AS DateTimeOffset), 4, 283)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1113, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.1834440+00:00' AS DateTimeOffset), 1, 284)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1114, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.1856180+00:00' AS DateTimeOffset), 2, 284)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1115, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.1880520+00:00' AS DateTimeOffset), 3, 284)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1116, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.1905500+00:00' AS DateTimeOffset), 4, 284)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1117, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.1948740+00:00' AS DateTimeOffset), 1, 285)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1118, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.1972830+00:00' AS DateTimeOffset), 2, 285)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1119, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.1997400+00:00' AS DateTimeOffset), 3, 285)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1120, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.2022490+00:00' AS DateTimeOffset), 4, 285)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1121, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.2068090+00:00' AS DateTimeOffset), 1, 286)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1122, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:20.2091510+00:00' AS DateTimeOffset), 2, 286)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1123, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.2115110+00:00' AS DateTimeOffset), 3, 286)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1124, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.2138410+00:00' AS DateTimeOffset), 4, 286)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1125, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.2185660+00:00' AS DateTimeOffset), 1, 287)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1126, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.2208530+00:00' AS DateTimeOffset), 2, 287)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1127, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.2230700+00:00' AS DateTimeOffset), 3, 287)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1128, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.2253180+00:00' AS DateTimeOffset), 4, 287)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1129, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.2298770+00:00' AS DateTimeOffset), 1, 288)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1130, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.2321190+00:00' AS DateTimeOffset), 2, 288)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1131, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.2345770+00:00' AS DateTimeOffset), 3, 288)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1132, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.2366950+00:00' AS DateTimeOffset), 4, 288)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1133, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.2417260+00:00' AS DateTimeOffset), 1, 289)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1134, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:20.2439840+00:00' AS DateTimeOffset), 2, 289)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1135, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.2465570+00:00' AS DateTimeOffset), 3, 289)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1136, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.2491270+00:00' AS DateTimeOffset), 4, 289)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1137, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.2548770+00:00' AS DateTimeOffset), 1, 290)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1138, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.2571770+00:00' AS DateTimeOffset), 2, 290)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1139, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.2594220+00:00' AS DateTimeOffset), 3, 290)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1140, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.2617730+00:00' AS DateTimeOffset), 4, 290)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1141, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.2662390+00:00' AS DateTimeOffset), 1, 291)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1142, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.2685020+00:00' AS DateTimeOffset), 2, 291)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1143, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.2706870+00:00' AS DateTimeOffset), 3, 291)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1144, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.2730630+00:00' AS DateTimeOffset), 4, 291)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1145, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.2775660+00:00' AS DateTimeOffset), 1, 292)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1146, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.2799940+00:00' AS DateTimeOffset), 2, 292)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1147, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.2826990+00:00' AS DateTimeOffset), 3, 292)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1148, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.2851590+00:00' AS DateTimeOffset), 4, 292)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1149, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.2892860+00:00' AS DateTimeOffset), 1, 293)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1150, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:20.2916730+00:00' AS DateTimeOffset), 2, 293)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1151, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.2940100+00:00' AS DateTimeOffset), 3, 293)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1152, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.2963540+00:00' AS DateTimeOffset), 4, 293)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1153, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.3010720+00:00' AS DateTimeOffset), 1, 294)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1154, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.3035430+00:00' AS DateTimeOffset), 2, 294)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1155, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:20.3060640+00:00' AS DateTimeOffset), 3, 294)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1156, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.3087610+00:00' AS DateTimeOffset), 4, 294)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1157, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.3136040+00:00' AS DateTimeOffset), 1, 295)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1158, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.3159490+00:00' AS DateTimeOffset), 2, 295)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1159, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:20.3183630+00:00' AS DateTimeOffset), 3, 295)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1160, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.3206920+00:00' AS DateTimeOffset), 4, 295)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1161, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.3254940+00:00' AS DateTimeOffset), 1, 296)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1162, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.3276600+00:00' AS DateTimeOffset), 2, 296)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1163, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:20.3299090+00:00' AS DateTimeOffset), 3, 296)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1164, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.3326420+00:00' AS DateTimeOffset), 4, 296)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1165, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.3372620+00:00' AS DateTimeOffset), 1, 297)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1166, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.3396670+00:00' AS DateTimeOffset), 2, 297)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1167, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.3421520+00:00' AS DateTimeOffset), 3, 297)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1168, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.3443930+00:00' AS DateTimeOffset), 4, 297)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1169, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.3489060+00:00' AS DateTimeOffset), 1, 298)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1170, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-04-30T20:45:20.3514280+00:00' AS DateTimeOffset), 2, 298)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1171, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.3535630+00:00' AS DateTimeOffset), 3, 298)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1172, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.3560140+00:00' AS DateTimeOffset), 4, 298)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1173, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.3612490+00:00' AS DateTimeOffset), 1, 299)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1174, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.3635420+00:00' AS DateTimeOffset), 2, 299)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1175, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.3659040+00:00' AS DateTimeOffset), 3, 299)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1176, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.3683910+00:00' AS DateTimeOffset), 4, 299)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1177, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.3732730+00:00' AS DateTimeOffset), 1, 300)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1178, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.3754210+00:00' AS DateTimeOffset), 2, 300)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1179, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:20.3777450+00:00' AS DateTimeOffset), 3, 300)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1180, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.3799590+00:00' AS DateTimeOffset), 4, 300)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1181, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.3850190+00:00' AS DateTimeOffset), 1, 301)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1182, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.3872370+00:00' AS DateTimeOffset), 2, 301)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1183, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.3895220+00:00' AS DateTimeOffset), 3, 301)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1184, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.3916630+00:00' AS DateTimeOffset), 4, 301)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1185, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.3970350+00:00' AS DateTimeOffset), 1, 302)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1186, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.3993040+00:00' AS DateTimeOffset), 2, 302)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1187, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:20.4014600+00:00' AS DateTimeOffset), 3, 302)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1188, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.4038210+00:00' AS DateTimeOffset), 4, 302)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1189, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.4090450+00:00' AS DateTimeOffset), 1, 303)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1190, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.4115640+00:00' AS DateTimeOffset), 2, 303)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1191, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:20.4137860+00:00' AS DateTimeOffset), 3, 303)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1192, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.4162550+00:00' AS DateTimeOffset), 4, 303)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1193, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.4209120+00:00' AS DateTimeOffset), 1, 304)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1194, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.4233870+00:00' AS DateTimeOffset), 2, 304)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1195, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.4256140+00:00' AS DateTimeOffset), 3, 304)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1196, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.4286510+00:00' AS DateTimeOffset), 4, 304)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1197, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.4338840+00:00' AS DateTimeOffset), 1, 305)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1198, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.4364550+00:00' AS DateTimeOffset), 2, 305)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1199, N'TDAH', 0.94568582549792735, CAST(N'2025-04-30T20:45:20.4391400+00:00' AS DateTimeOffset), 3, 305)
GO
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1200, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.4418640+00:00' AS DateTimeOffset), 4, 305)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1201, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-04-30T20:45:20.4511930+00:00' AS DateTimeOffset), 1, 306)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1202, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-04-30T20:45:20.4547500+00:00' AS DateTimeOffset), 2, 306)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1203, N'TDAH', 0.75949252199370743, CAST(N'2025-04-30T20:45:20.4576010+00:00' AS DateTimeOffset), 3, 306)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1204, N'TEA', 0.7466633123211901, CAST(N'2025-04-30T20:45:20.4610150+00:00' AS DateTimeOffset), 4, 306)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1205, N'Ansiedad/Depresión', 0.82629916857903485, CAST(N'2025-05-06T18:22:51.2647350+00:00' AS DateTimeOffset), 1, 308)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1206, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-05-06T18:23:08.3342930+00:00' AS DateTimeOffset), 2, 308)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1207, N'TDAH', 0.57110059231710331, CAST(N'2025-05-06T18:23:23.7878190+00:00' AS DateTimeOffset), 3, 308)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1208, N'TEA', 0.7466633123211901, CAST(N'2025-05-06T18:24:53.3219620+00:00' AS DateTimeOffset), 4, 308)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1209, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-05-06T19:00:31.8649970+00:00' AS DateTimeOffset), 1, 309)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1210, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-05-06T19:01:06.6915030+00:00' AS DateTimeOffset), 2, 309)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1211, N'TDAH', 0.77573700959377845, CAST(N'2025-05-06T19:01:20.7093340+00:00' AS DateTimeOffset), 3, 309)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1212, N'TEA', 0.7466633123211901, CAST(N'2025-05-06T19:01:33.7369480+00:00' AS DateTimeOffset), 4, 309)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1213, N'Ansiedad/Depresión', 0.8570442159519891, CAST(N'2025-05-15T22:32:57.8528920+00:00' AS DateTimeOffset), 1, 307)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1214, N'Discapacidad Intelectual', 0.85800767759483809, CAST(N'2025-05-15T22:33:12.9633040+00:00' AS DateTimeOffset), 2, 307)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1215, N'TDAH', 0.57110059231710331, CAST(N'2025-05-15T22:33:29.1473840+00:00' AS DateTimeOffset), 3, 307)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1216, N'TEA', 0.7466633123211901, CAST(N'2025-05-15T22:33:50.6667850+00:00' AS DateTimeOffset), 4, 307)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1217, N'Ansiedad/Depresión', 0.82629916857903485, CAST(N'2025-05-22T15:14:23.1388360+00:00' AS DateTimeOffset), 1, 310)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1218, N'Discapacidad Intelectual', 0.79710924135798744, CAST(N'2025-05-22T15:14:37.7695890+00:00' AS DateTimeOffset), 2, 310)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1219, N'TDAH', 0.57110059231710331, CAST(N'2025-05-22T15:14:49.1967550+00:00' AS DateTimeOffset), 3, 310)
INSERT [dbo].[evaluaciones_resultadoia] ([id], [prediccion], [probabilidad], [fecha], [juego_id], [nino_id]) VALUES (1220, N'TEA', 0.7466633123211901, CAST(N'2025-05-22T15:15:06.4822190+00:00' AS DateTimeOffset), 4, 310)
SET IDENTITY_INSERT [dbo].[evaluaciones_resultadoia] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [auth_group_name_a6ea08ec_uniq]    Script Date: 22/05/2025 11:59:39 ******/
ALTER TABLE [dbo].[auth_group] ADD  CONSTRAINT [auth_group_name_a6ea08ec_uniq] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [auth_group_permissions_group_id_b120cbf9]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [auth_group_permissions_group_id_b120cbf9] ON [dbo].[auth_group_permissions]
(
	[group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [auth_group_permissions_group_id_permission_id_0cd325b0_uniq]    Script Date: 22/05/2025 11:59:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [auth_group_permissions_group_id_permission_id_0cd325b0_uniq] ON [dbo].[auth_group_permissions]
(
	[group_id] ASC,
	[permission_id] ASC
)
WHERE ([group_id] IS NOT NULL AND [permission_id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [auth_group_permissions_permission_id_84c5c92e]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [auth_group_permissions_permission_id_84c5c92e] ON [dbo].[auth_group_permissions]
(
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [auth_permission_content_type_id_2f476e4b]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [auth_permission_content_type_id_2f476e4b] ON [dbo].[auth_permission]
(
	[content_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [auth_permission_content_type_id_codename_01ab375a_uniq]    Script Date: 22/05/2025 11:59:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [auth_permission_content_type_id_codename_01ab375a_uniq] ON [dbo].[auth_permission]
(
	[content_type_id] ASC,
	[codename] ASC
)
WHERE ([content_type_id] IS NOT NULL AND [codename] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [auth_user_username_6821ab7c_uniq]    Script Date: 22/05/2025 11:59:39 ******/
ALTER TABLE [dbo].[auth_user] ADD  CONSTRAINT [auth_user_username_6821ab7c_uniq] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [auth_user_groups_group_id_97559544]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [auth_user_groups_group_id_97559544] ON [dbo].[auth_user_groups]
(
	[group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [auth_user_groups_user_id_6a12ed8b]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [auth_user_groups_user_id_6a12ed8b] ON [dbo].[auth_user_groups]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [auth_user_groups_user_id_group_id_94350c0c_uniq]    Script Date: 22/05/2025 11:59:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [auth_user_groups_user_id_group_id_94350c0c_uniq] ON [dbo].[auth_user_groups]
(
	[user_id] ASC,
	[group_id] ASC
)
WHERE ([user_id] IS NOT NULL AND [group_id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [auth_user_user_permissions_permission_id_1fbb5f2c]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [auth_user_user_permissions_permission_id_1fbb5f2c] ON [dbo].[auth_user_user_permissions]
(
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [auth_user_user_permissions_user_id_a95ead1b]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [auth_user_user_permissions_user_id_a95ead1b] ON [dbo].[auth_user_user_permissions]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [auth_user_user_permissions_user_id_permission_id_14a6b632_uniq]    Script Date: 22/05/2025 11:59:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [auth_user_user_permissions_user_id_permission_id_14a6b632_uniq] ON [dbo].[auth_user_user_permissions]
(
	[user_id] ASC,
	[permission_id] ASC
)
WHERE ([user_id] IS NOT NULL AND [permission_id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [django_admin_log_content_type_id_c4bce8eb]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [django_admin_log_content_type_id_c4bce8eb] ON [dbo].[django_admin_log]
(
	[content_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [django_admin_log_user_id_c564eba6]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [django_admin_log_user_id_c564eba6] ON [dbo].[django_admin_log]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [django_content_type_app_label_model_76bd3d3b_uniq]    Script Date: 22/05/2025 11:59:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [django_content_type_app_label_model_76bd3d3b_uniq] ON [dbo].[django_content_type]
(
	[app_label] ASC,
	[model] ASC
)
WHERE ([app_label] IS NOT NULL AND [model] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [django_session_expire_date_a5c62663]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [django_session_expire_date_a5c62663] ON [dbo].[django_session]
(
	[expire_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__evaluaci__638DD32D3E461F43]    Script Date: 22/05/2025 11:59:39 ******/
ALTER TABLE [dbo].[evaluaciones_especialista] ADD UNIQUE NONCLUSTERED 
(
	[perfil_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [evaluaciones_evaluacion_especialista_id_cc17be57]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [evaluaciones_evaluacion_especialista_id_cc17be57] ON [dbo].[evaluaciones_evaluacion]
(
	[especialista_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [evaluaciones_evaluacion_nino_id_dfacac33]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [evaluaciones_evaluacion_nino_id_dfacac33] ON [dbo].[evaluaciones_evaluacion]
(
	[nino_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [evaluaciones_intentojuego_juego_id_001cffda]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [evaluaciones_intentojuego_juego_id_001cffda] ON [dbo].[evaluaciones_intentojuego]
(
	[juego_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [evaluaciones_intentojuego_nino_id_1737a1bd]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [evaluaciones_intentojuego_nino_id_1737a1bd] ON [dbo].[evaluaciones_intentojuego]
(
	[nino_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [evaluaciones_intentojuegoinvitado_juego_id_ade01c99]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [evaluaciones_intentojuegoinvitado_juego_id_ade01c99] ON [dbo].[evaluaciones_intentojuegoinvitado]
(
	[juego_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [evaluaciones_logenvioreporte_especialista_id_83948416]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [evaluaciones_logenvioreporte_especialista_id_83948416] ON [dbo].[evaluaciones_logenvioreporte]
(
	[especialista_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [evaluaciones_logenvioreporte_nino_id_9f1ade64]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [evaluaciones_logenvioreporte_nino_id_9f1ade64] ON [dbo].[evaluaciones_logenvioreporte]
(
	[nino_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__evaluaci__B9BE370EF5327DEC]    Script Date: 22/05/2025 11:59:39 ******/
ALTER TABLE [dbo].[evaluaciones_nino] ADD UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [evaluaciones_nino_email_dbb9ebb3_uniq]    Script Date: 22/05/2025 11:59:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [evaluaciones_nino_email_dbb9ebb3_uniq] ON [dbo].[evaluaciones_nino]
(
	[email] ASC
)
WHERE ([email] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__evaluaci__B9BE370E44D75646]    Script Date: 22/05/2025 11:59:39 ******/
ALTER TABLE [dbo].[evaluaciones_perfil] ADD UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [evaluaciones_resultado_juego_id_88a41a67]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [evaluaciones_resultado_juego_id_88a41a67] ON [dbo].[evaluaciones_resultado]
(
	[juego_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [evaluaciones_resultado_nino_id_f8f5ff1f]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [evaluaciones_resultado_nino_id_f8f5ff1f] ON [dbo].[evaluaciones_resultado]
(
	[nino_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [evaluaciones_resultadoia_juego_id_a46f4916]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [evaluaciones_resultadoia_juego_id_a46f4916] ON [dbo].[evaluaciones_resultadoia]
(
	[juego_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [evaluaciones_resultadoia_nino_id_9c62b8ce]    Script Date: 22/05/2025 11:59:39 ******/
CREATE NONCLUSTERED INDEX [evaluaciones_resultadoia_nino_id_9c62b8ce] ON [dbo].[evaluaciones_resultadoia]
(
	[nino_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[auth_group_permissions]  WITH CHECK ADD  CONSTRAINT [auth_group_permissions_group_id_b120cbf9_fk_auth_group_id] FOREIGN KEY([group_id])
REFERENCES [dbo].[auth_group] ([id])
GO
ALTER TABLE [dbo].[auth_group_permissions] CHECK CONSTRAINT [auth_group_permissions_group_id_b120cbf9_fk_auth_group_id]
GO
ALTER TABLE [dbo].[auth_group_permissions]  WITH CHECK ADD  CONSTRAINT [auth_group_permissions_permission_id_84c5c92e_fk_auth_permission_id] FOREIGN KEY([permission_id])
REFERENCES [dbo].[auth_permission] ([id])
GO
ALTER TABLE [dbo].[auth_group_permissions] CHECK CONSTRAINT [auth_group_permissions_permission_id_84c5c92e_fk_auth_permission_id]
GO
ALTER TABLE [dbo].[auth_permission]  WITH CHECK ADD  CONSTRAINT [auth_permission_content_type_id_2f476e4b_fk_django_content_type_id] FOREIGN KEY([content_type_id])
REFERENCES [dbo].[django_content_type] ([id])
GO
ALTER TABLE [dbo].[auth_permission] CHECK CONSTRAINT [auth_permission_content_type_id_2f476e4b_fk_django_content_type_id]
GO
ALTER TABLE [dbo].[auth_user_groups]  WITH CHECK ADD  CONSTRAINT [auth_user_groups_group_id_97559544_fk_auth_group_id] FOREIGN KEY([group_id])
REFERENCES [dbo].[auth_group] ([id])
GO
ALTER TABLE [dbo].[auth_user_groups] CHECK CONSTRAINT [auth_user_groups_group_id_97559544_fk_auth_group_id]
GO
ALTER TABLE [dbo].[auth_user_groups]  WITH CHECK ADD  CONSTRAINT [auth_user_groups_user_id_6a12ed8b_fk_auth_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[auth_user] ([id])
GO
ALTER TABLE [dbo].[auth_user_groups] CHECK CONSTRAINT [auth_user_groups_user_id_6a12ed8b_fk_auth_user_id]
GO
ALTER TABLE [dbo].[auth_user_user_permissions]  WITH CHECK ADD  CONSTRAINT [auth_user_user_permissions_permission_id_1fbb5f2c_fk_auth_permission_id] FOREIGN KEY([permission_id])
REFERENCES [dbo].[auth_permission] ([id])
GO
ALTER TABLE [dbo].[auth_user_user_permissions] CHECK CONSTRAINT [auth_user_user_permissions_permission_id_1fbb5f2c_fk_auth_permission_id]
GO
ALTER TABLE [dbo].[auth_user_user_permissions]  WITH CHECK ADD  CONSTRAINT [auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[auth_user] ([id])
GO
ALTER TABLE [dbo].[auth_user_user_permissions] CHECK CONSTRAINT [auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id]
GO
ALTER TABLE [dbo].[django_admin_log]  WITH CHECK ADD  CONSTRAINT [django_admin_log_content_type_id_c4bce8eb_fk_django_content_type_id] FOREIGN KEY([content_type_id])
REFERENCES [dbo].[django_content_type] ([id])
GO
ALTER TABLE [dbo].[django_admin_log] CHECK CONSTRAINT [django_admin_log_content_type_id_c4bce8eb_fk_django_content_type_id]
GO
ALTER TABLE [dbo].[django_admin_log]  WITH CHECK ADD  CONSTRAINT [django_admin_log_user_id_c564eba6_fk_auth_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[auth_user] ([id])
GO
ALTER TABLE [dbo].[django_admin_log] CHECK CONSTRAINT [django_admin_log_user_id_c564eba6_fk_auth_user_id]
GO
ALTER TABLE [dbo].[evaluaciones_especialista]  WITH CHECK ADD  CONSTRAINT [evaluaciones_especialista_perfil_id_8c3a80dc_fk_evaluaciones_perfil_id] FOREIGN KEY([perfil_id])
REFERENCES [dbo].[evaluaciones_perfil] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_especialista] CHECK CONSTRAINT [evaluaciones_especialista_perfil_id_8c3a80dc_fk_evaluaciones_perfil_id]
GO
ALTER TABLE [dbo].[evaluaciones_evaluacion]  WITH CHECK ADD  CONSTRAINT [evaluaciones_evaluacion_especialista_id_cc17be57_fk_evaluaciones_especialista_id] FOREIGN KEY([especialista_id])
REFERENCES [dbo].[evaluaciones_especialista] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_evaluacion] CHECK CONSTRAINT [evaluaciones_evaluacion_especialista_id_cc17be57_fk_evaluaciones_especialista_id]
GO
ALTER TABLE [dbo].[evaluaciones_evaluacion]  WITH CHECK ADD  CONSTRAINT [evaluaciones_evaluacion_nino_id_dfacac33_fk_evaluaciones_nino_id] FOREIGN KEY([nino_id])
REFERENCES [dbo].[evaluaciones_nino] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_evaluacion] CHECK CONSTRAINT [evaluaciones_evaluacion_nino_id_dfacac33_fk_evaluaciones_nino_id]
GO
ALTER TABLE [dbo].[evaluaciones_intentojuego]  WITH CHECK ADD  CONSTRAINT [evaluaciones_intentojuego_juego_id_001cffda_fk_evaluaciones_juego_id] FOREIGN KEY([juego_id])
REFERENCES [dbo].[evaluaciones_juego] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_intentojuego] CHECK CONSTRAINT [evaluaciones_intentojuego_juego_id_001cffda_fk_evaluaciones_juego_id]
GO
ALTER TABLE [dbo].[evaluaciones_intentojuego]  WITH CHECK ADD  CONSTRAINT [evaluaciones_intentojuego_nino_id_1737a1bd_fk_evaluaciones_nino_id] FOREIGN KEY([nino_id])
REFERENCES [dbo].[evaluaciones_nino] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_intentojuego] CHECK CONSTRAINT [evaluaciones_intentojuego_nino_id_1737a1bd_fk_evaluaciones_nino_id]
GO
ALTER TABLE [dbo].[evaluaciones_intentojuegoinvitado]  WITH CHECK ADD  CONSTRAINT [evaluaciones_intentojuegoinvitado_juego_id_ade01c99_fk_evaluaciones_juego_id] FOREIGN KEY([juego_id])
REFERENCES [dbo].[evaluaciones_juego] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_intentojuegoinvitado] CHECK CONSTRAINT [evaluaciones_intentojuegoinvitado_juego_id_ade01c99_fk_evaluaciones_juego_id]
GO
ALTER TABLE [dbo].[evaluaciones_logenvioreporte]  WITH CHECK ADD  CONSTRAINT [evaluaciones_logenvioreporte_especialista_id_83948416_fk_evaluaciones_especialista_id] FOREIGN KEY([especialista_id])
REFERENCES [dbo].[evaluaciones_especialista] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_logenvioreporte] CHECK CONSTRAINT [evaluaciones_logenvioreporte_especialista_id_83948416_fk_evaluaciones_especialista_id]
GO
ALTER TABLE [dbo].[evaluaciones_logenvioreporte]  WITH CHECK ADD  CONSTRAINT [evaluaciones_logenvioreporte_nino_id_9f1ade64_fk_evaluaciones_nino_id] FOREIGN KEY([nino_id])
REFERENCES [dbo].[evaluaciones_nino] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_logenvioreporte] CHECK CONSTRAINT [evaluaciones_logenvioreporte_nino_id_9f1ade64_fk_evaluaciones_nino_id]
GO
ALTER TABLE [dbo].[evaluaciones_nino]  WITH CHECK ADD  CONSTRAINT [evaluaciones_nino_user_id_061a0cb4_fk_auth_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[auth_user] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_nino] CHECK CONSTRAINT [evaluaciones_nino_user_id_061a0cb4_fk_auth_user_id]
GO
ALTER TABLE [dbo].[evaluaciones_perfil]  WITH CHECK ADD  CONSTRAINT [evaluaciones_perfil_user_id_87e0c285_fk_auth_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[auth_user] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_perfil] CHECK CONSTRAINT [evaluaciones_perfil_user_id_87e0c285_fk_auth_user_id]
GO
ALTER TABLE [dbo].[evaluaciones_resultado]  WITH CHECK ADD  CONSTRAINT [evaluaciones_resultado_juego_id_88a41a67_fk_evaluaciones_juego_id] FOREIGN KEY([juego_id])
REFERENCES [dbo].[evaluaciones_juego] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_resultado] CHECK CONSTRAINT [evaluaciones_resultado_juego_id_88a41a67_fk_evaluaciones_juego_id]
GO
ALTER TABLE [dbo].[evaluaciones_resultado]  WITH CHECK ADD  CONSTRAINT [evaluaciones_resultado_nino_id_f8f5ff1f_fk_evaluaciones_nino_id] FOREIGN KEY([nino_id])
REFERENCES [dbo].[evaluaciones_nino] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_resultado] CHECK CONSTRAINT [evaluaciones_resultado_nino_id_f8f5ff1f_fk_evaluaciones_nino_id]
GO
ALTER TABLE [dbo].[evaluaciones_resultadoia]  WITH CHECK ADD  CONSTRAINT [evaluaciones_resultadoia_juego_id_a46f4916_fk_evaluaciones_juego_id] FOREIGN KEY([juego_id])
REFERENCES [dbo].[evaluaciones_juego] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_resultadoia] CHECK CONSTRAINT [evaluaciones_resultadoia_juego_id_a46f4916_fk_evaluaciones_juego_id]
GO
ALTER TABLE [dbo].[evaluaciones_resultadoia]  WITH CHECK ADD  CONSTRAINT [evaluaciones_resultadoia_nino_id_9c62b8ce_fk_evaluaciones_nino_id] FOREIGN KEY([nino_id])
REFERENCES [dbo].[evaluaciones_nino] ([id])
GO
ALTER TABLE [dbo].[evaluaciones_resultadoia] CHECK CONSTRAINT [evaluaciones_resultadoia_nino_id_9c62b8ce_fk_evaluaciones_nino_id]
GO
ALTER TABLE [dbo].[django_admin_log]  WITH CHECK ADD  CONSTRAINT [django_admin_log_action_flag_a8637d59_check] CHECK  (([action_flag]>=(0)))
GO
ALTER TABLE [dbo].[django_admin_log] CHECK CONSTRAINT [django_admin_log_action_flag_a8637d59_check]
GO
USE [master]
GO
ALTER DATABASE [neurokidDB] SET  READ_WRITE 
GO
