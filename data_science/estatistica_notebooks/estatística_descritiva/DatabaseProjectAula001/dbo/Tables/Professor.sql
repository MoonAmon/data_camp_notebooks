CREATE TABLE [dbo].[Professor] (
    [matricula] INT        NOT NULL,
    [nome]      NCHAR (80) NOT NULL,
    [telefone]  NCHAR (17) NULL,
    CONSTRAINT [PK_Professor] PRIMARY KEY CLUSTERED ([matricula] ASC)
);


GO

