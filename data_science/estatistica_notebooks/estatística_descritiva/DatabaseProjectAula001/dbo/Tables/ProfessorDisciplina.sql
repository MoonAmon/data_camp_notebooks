CREATE TABLE [dbo].[ProfessorDisciplina] (
    [codigo]              INT IDENTITY (1, 1) NOT NULL,
    [matricula_professor] INT NOT NULL,
    [codigo_disciplina]   INT NOT NULL,
    CONSTRAINT [PK_ProfessorDisciplina] PRIMARY KEY CLUSTERED ([codigo] ASC),
    CONSTRAINT [FK_ProfessorDisciplina_Disciplina] FOREIGN KEY ([codigo_disciplina]) REFERENCES [dbo].[Disciplina] ([codigo]),
    CONSTRAINT [FK_ProfessorDisciplina_Professor] FOREIGN KEY ([matricula_professor]) REFERENCES [dbo].[Professor] ([matricula])
);


GO

