CREATE TABLE [dbo].[Disciplina] (
    [nome]   VARCHAR (30) NOT NULL,
    [codigo] INT          IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_Disciplina] PRIMARY KEY CLUSTERED ([codigo] ASC)
);


GO

