CREATE TABLE [dbo].[Aluno] (
    [nome]            NCHAR (80) NOT NULL,
    [data_nascimento] DATE       NOT NULL,
    [matricula]       INT        NOT NULL,
    CONSTRAINT [PK_Aluno] PRIMARY KEY CLUSTERED ([matricula] ASC)
);


GO

