CREATE TABLE [dbo].[AlunoDisciplina] (
    [codigo]            INT IDENTITY (1, 1) NOT NULL,
    [matricula_aluno]   INT NOT NULL,
    [codigo_disciplina] INT NOT NULL,
    CONSTRAINT [PK_AlunoDisciplina] PRIMARY KEY CLUSTERED ([codigo] ASC),
    CONSTRAINT [FK_AlunoDisciplina_Aluno] FOREIGN KEY ([matricula_aluno]) REFERENCES [dbo].[Aluno] ([matricula]),
    CONSTRAINT [FK_AlunoDisciplina_Disciplina] FOREIGN KEY ([codigo_disciplina]) REFERENCES [dbo].[Disciplina] ([codigo])
);


GO

